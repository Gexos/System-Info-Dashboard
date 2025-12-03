#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\gexos_apps\System info dashboard\sysinfo.ico
#AutoIt3Wrapper_Outfile=SysInfoDash.exe
#AutoIt3Wrapper_Outfile_x64=SysInfoDash_X64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=System Info Dashboard v5.0.1
#AutoIt3Wrapper_Res_Fileversion=5.0.1.0
#AutoIt3Wrapper_Res_ProductName=System Info Dashboard
#AutoIt3Wrapper_Res_ProductVersion=5.0.1.0
#AutoIt3Wrapper_Res_CompanyName=GexSoft
#AutoIt3Wrapper_Res_Field=Comments|System Info Dashboard v5.0.1 by gexos
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; ==== VERSION INFO (tooltip + file properties) ====

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <ListViewConstants.au3>
#include <GuiListView.au3>
#include <Date.au3>
#include <Misc.au3>
#include <FileConstants.au3>
#include <Constants.au3> ; for $STDOUT_CHILD

; ==========================
;  GLOBALS / CONFIG
; ==========================

Global Const $APP_NAME = "System Info Dashboard"
Global Const $APP_VER  = "5.0.1"
Global Const $GEXSOFT_ORANGE = 0xFF6600

Global $g_hMainGUI, $g_hProcGUI, $g_hNetGUI, $g_hSysGUI, $g_hAboutGUI

Global $g_lblCPU, $g_lblRAM, $g_lblDisk, $g_lblOS, $g_lblUptime, $g_lblTime, _
       $g_lblNet, $g_lblSec, $g_lblTemps, $g_lblVersion
Global $g_lvProc, $g_inpProcFilter
Global $g_txtNetDetails, $g_txtSysInfo

; menu/control IDs
Global _
    $ID_MAIN_TXT, _
    $ID_MAIN_HTML, _
    $ID_MAIN_PROC, _
    $ID_MAIN_NET, _
    $ID_MAIN_SYS, _
    $ID_MAIN_LHM, _
    $ID_MAIN_EXIT, _
    $ID_HELP_OPENHELP, _
    $ID_HELP_ABOUT, _
    $ID_PROC_REFRESH, _
    $ID_PROC_KILL, _
    $ID_NET_REFRESH, _
    $ID_SYS_REFRESH, _
    $ID_WT_TASKMGR, _
    $ID_WT_DEVMGR, _
    $ID_WT_EVENTVWR, _
    $ID_WT_SERVICES, _
    $ID_WT_DISKMGMT, _
    $ID_WT_MSINFO, _
    $ID_WT_CMD, _
    $ID_SET_THEME

; About window clickable labels – set later
Global $ID_ABOUT_WEB  = -1
Global $ID_ABOUT_GEXSOFT = -1
Global $ID_ABOUT_GITHUB  = -1

Global $g_iRefreshMs = 2000      ; how often to refresh the main dashboard
Global $g_bDarkTheme = True
Global $g_hLastUpdate = 0        ; timer handle for manual refresh

; tray menu
Global $g_idTrayShow, $g_idTrayExit

; COM error handler (so WMI/COM glitches don’t crash the app)
Global $g_oComError = ObjEvent("AutoIt.Error", "_ComErrHandler")

; ==========================
;  MAIN
; ==========================

Opt("TrayMenuMode", 3) ; we handle tray menu manually

_CreateMainGUI()
_CreateProcessGUI()
_CreateNetworkGUI()
_CreateSystemGUI()

; tray icon
TraySetToolTip($APP_NAME)
If FileExists("sysinfo.ico") Then TraySetIcon("sysinfo.ico")
$g_idTrayShow = TrayCreateItem("Show " & $APP_NAME)
$g_idTrayExit = TrayCreateItem("Exit")
TraySetState()

; fill dashboard once so it doesn't show "..."
_UpdateMainDashboard()

GUISetState(@SW_SHOW, $g_hMainGUI)

; start timer for manual refresh (replaces AdlibRegister)
$g_hLastUpdate = TimerInit()

While 1
    Local $msg  = GUIGetMsg()
    Local $tmsg = TrayGetMsg()

    ; --- tray events ---
    If $tmsg <> 0 Then
        Switch $tmsg
            Case $g_idTrayShow
                GUISetState(@SW_SHOW, $g_hMainGUI)
                WinActivate($g_hMainGUI)
            Case $g_idTrayExit
                Exit
        EndSwitch
    EndIf

    ; --- GUI events ---
    Switch $msg
        Case $GUI_EVENT_CLOSE
            ; if main is active ? hide to tray
            If WinActive($g_hMainGUI) Then
                GUISetState(@SW_HIDE, $g_hMainGUI)
            ElseIf WinActive($g_hProcGUI) Then
                GUISetState(@SW_HIDE, $g_hProcGUI)
            ElseIf WinActive($g_hNetGUI) Then
                GUISetState(@SW_HIDE, $g_hNetGUI)
            ElseIf WinActive($g_hSysGUI) Then
                GUISetState(@SW_HIDE, $g_hSysGUI)
            ElseIf IsHWnd($g_hAboutGUI) And WinActive($g_hAboutGUI) Then
                GUISetState(@SW_HIDE, $g_hAboutGUI)
            EndIf

        Case $GUI_EVENT_MINIMIZE
            ; minimize main ? send to tray
            If WinActive($g_hMainGUI) Then
                GUISetState(@SW_HIDE, $g_hMainGUI)
            EndIf

        ; --- MAIN MENU ---
        Case $ID_MAIN_TXT
            _ExportReport("txt")

        Case $ID_MAIN_HTML
            _ExportReport("html")

        Case $ID_MAIN_PROC
            GUISetState(@SW_SHOW, $g_hProcGUI)
            _UpdateProcessList()

        Case $ID_MAIN_NET
            GUISetState(@SW_SHOW, $g_hNetGUI)
            _UpdateNetworkDetails()

        Case $ID_MAIN_SYS
            GUISetState(@SW_SHOW, $g_hSysGUI)
            _UpdateSystemInfo()

        Case $ID_MAIN_LHM
            _OpenLibreHardwareMonitor()

        Case $ID_MAIN_EXIT
            Exit

        ; --- SETTINGS ---
        Case $ID_SET_THEME
            _ToggleTheme()

        ; --- WINDOWS TOOLS ---
        Case $ID_WT_TASKMGR
            ShellExecute("taskmgr.exe")
        Case $ID_WT_DEVMGR
            ShellExecute("devmgmt.msc")
        Case $ID_WT_EVENTVWR
            ShellExecute("eventvwr.msc")
        Case $ID_WT_SERVICES
            ShellExecute("services.msc")
        Case $ID_WT_DISKMGMT
            ShellExecute("diskmgmt.msc")
        Case $ID_WT_MSINFO
            ShellExecute("msinfo32.exe")
        Case $ID_WT_CMD
            ShellExecute(@ComSpec)

        ; --- HELP MENU ---
        Case $ID_HELP_OPENHELP
            _OpenHelpFile()

        Case $ID_HELP_ABOUT
            _ShowAbout()

        ; --- ABOUT LINKS ---
        Case $ID_ABOUT_WEB
            If $ID_ABOUT_WEB > 0 Then ShellExecute("https://www.gexos.org")

        Case $ID_ABOUT_GEXSOFT
            If $ID_ABOUT_GEXSOFT > 0 Then ShellExecute("https://gexsoft.org/systeminfodashboard.html")

        Case $ID_ABOUT_GITHUB
            If $ID_ABOUT_GITHUB > 0 Then ShellExecute("https://github.com/Gexos/System-Info-Dashboard")

        ; --- PROCESS WINDOW ---
        Case $ID_PROC_REFRESH
            _UpdateProcessList()
        Case $ID_PROC_KILL
            _KillSelectedProcess()

        ; --- NETWORK WINDOW ---
        Case $ID_NET_REFRESH
            _UpdateNetworkDetails()

        ; --- SYSTEM WINDOW ---
        Case $ID_SYS_REFRESH
            _UpdateSystemInfo()
    EndSwitch

    ; refresh main dashboard every g_iRefreshMs ms (no Adlib, smoother dragging)
    If TimerDiff($g_hLastUpdate) > $g_iRefreshMs Then
        _UpdateMainDashboard()
        $g_hLastUpdate = TimerInit()
    EndIf
WEnd

; ==========================
;  COM ERROR HANDLER
; ==========================

Func _ComErrHandler($oError)
    ; Just ignore COM/WMI glitches so they don't kill the app
    Return 0
EndFunc

; ==========================
;  GUI CREATION
; ==========================

Func _CreateMainGUI()
    $g_hMainGUI = GUICreate($APP_NAME, 720, 440, -1, -1, BitOR($WS_CAPTION, $WS_SYSMENU, $WS_MINIMIZEBOX))
    GUISetBkColor(0x001F4F, $g_hMainGUI) ; dark blue background
    GUISetFont(10, 700, 0, "Segoe UI", $g_hMainGUI)

    ; tiny orange bar on top for GexSoft style
    Local $bar = GUICtrlCreateLabel("", 0, 0, 720, 4)
    GUICtrlSetBkColor($bar, $GEXSOFT_ORANGE)

    ; Menus (Help is last)
    Local $mMain = GUICtrlCreateMenu("&Main")
    $ID_MAIN_TXT   = GUICtrlCreateMenuItem("Export &TXT report", $mMain)
    $ID_MAIN_HTML  = GUICtrlCreateMenuItem("Export &HTML report", $mMain)
    GUICtrlCreateMenuItem("", $mMain)
    $ID_MAIN_PROC  = GUICtrlCreateMenuItem("&Process Monitor...", $mMain)
    $ID_MAIN_NET   = GUICtrlCreateMenuItem("Network &Details...", $mMain)
    $ID_MAIN_SYS   = GUICtrlCreateMenuItem("&System Information...", $mMain)
    $ID_MAIN_LHM   = GUICtrlCreateMenuItem("Open &LibreHardwareMonitor...", $mMain)
    GUICtrlCreateMenuItem("", $mMain)
    $ID_MAIN_EXIT  = GUICtrlCreateMenuItem("E&xit", $mMain)

    Local $mSettings = GUICtrlCreateMenu("&Settings")
    $ID_SET_THEME = GUICtrlCreateMenuItem("Toggle &Dark Theme", $mSettings)

    Local $mWinTools = GUICtrlCreateMenu("&Windows Tools")
    $ID_WT_TASKMGR  = GUICtrlCreateMenuItem("Task Manager", $mWinTools)
    $ID_WT_DEVMGR   = GUICtrlCreateMenuItem("Device Manager", $mWinTools)
    $ID_WT_EVENTVWR = GUICtrlCreateMenuItem("Event Viewer", $mWinTools)
    $ID_WT_SERVICES = GUICtrlCreateMenuItem("Services", $mWinTools)
    $ID_WT_DISKMGMT = GUICtrlCreateMenuItem("Disk Management", $mWinTools)
    $ID_WT_MSINFO   = GUICtrlCreateMenuItem("System Information (msinfo32)", $mWinTools)
    $ID_WT_CMD      = GUICtrlCreateMenuItem("Command Prompt", $mWinTools)

    Local $mHelp = GUICtrlCreateMenu("&Help")
    $ID_HELP_OPENHELP = GUICtrlCreateMenuItem("Open &Help...", $mHelp)
    GUICtrlCreateMenuItem("", $mHelp)
    $ID_HELP_ABOUT = GUICtrlCreateMenuItem("&About System Info Dashboard", $mHelp)

    ; title
    Local $lblTitle = GUICtrlCreateLabel($APP_NAME, 20, 15, 400, 24)
    GUICtrlSetFont($lblTitle, 14, 700, 0, "Segoe UI")
    GUICtrlSetColor($lblTitle, 0xFFFFFF)

    ; section title
    Local $lblSysOverview = GUICtrlCreateLabel("System Overview", 20, 45, 300, 20)
    GUICtrlSetFont($lblSysOverview, 11, 700, 0, "Segoe UI")
    GUICtrlSetColor($lblSysOverview, 0xFFFFFF)

    ; orange border around main info area
    Local $gfxBorder = GUICtrlCreateGraphic(15, 60, 690, 300)
    GUICtrlSetGraphic($gfxBorder, $GUI_GR_COLOR, $GEXSOFT_ORANGE)
    GUICtrlSetGraphic($gfxBorder, $GUI_GR_PENSIZE, 1)
    GUICtrlSetGraphic($gfxBorder, $GUI_GR_RECT, 0, 0, 690, 300)

    ; labels
    Local $lblCPUtxt   = GUICtrlCreateLabel("CPU Usage:",       30,  75, 120, 22)
    Local $lblRAMtxt   = GUICtrlCreateLabel("RAM Usage:",       30, 100, 120, 22)
    Local $lblDisktxt  = GUICtrlCreateLabel("Disk Usage:",      30, 125, 120, 22)
    Local $lblOStxt    = GUICtrlCreateLabel("OS Version:",      30, 170, 120, 22)
    Local $lblUptxt    = GUICtrlCreateLabel("System Uptime:",   30, 195, 120, 22)
    Local $lblTimetxt  = GUICtrlCreateLabel("Current Time:",    30, 220, 120, 22)
    Local $lblNettxt   = GUICtrlCreateLabel("Network:",         30, 245, 120, 22)
    Local $lblSectxt   = GUICtrlCreateLabel("Security:",        30, 270, 120, 22)
    Local $lblTempstxt = GUICtrlCreateLabel("Temperatures:",    30, 295, 120, 22)

    GUICtrlSetColor($lblCPUtxt,   0xFFFFFF)
    GUICtrlSetColor($lblRAMtxt,   0xFFFFFF)
    GUICtrlSetColor($lblDisktxt,  0xFFFFFF)
    GUICtrlSetColor($lblOStxt,    0xFFFFFF)
    GUICtrlSetColor($lblUptxt,    0xFFFFFF)
    GUICtrlSetColor($lblTimetxt,  0xFFFFFF)
    GUICtrlSetColor($lblNettxt,   0xFFFFFF)
    GUICtrlSetColor($lblSectxt,   0xFFFFFF)
    GUICtrlSetColor($lblTempstxt, 0xFFFFFF)

    $g_lblCPU    = GUICtrlCreateLabel("...", 160,  75, 520, 22)
    $g_lblRAM    = GUICtrlCreateLabel("...", 160, 100, 520, 22)
    ; give disk more height for multi-line drive list
    $g_lblDisk   = GUICtrlCreateLabel("...", 160, 125, 520, 44)
    $g_lblOS     = GUICtrlCreateLabel(@OSVersion & " (" & @OSArch & ")", 160, 170, 520, 22)
    $g_lblUptime = GUICtrlCreateLabel("...", 160, 195, 520, 22)
    $g_lblTime   = GUICtrlCreateLabel("...", 160, 220, 520, 22)
    $g_lblNet    = GUICtrlCreateLabel("...", 160, 245, 520, 22)
    $g_lblSec    = GUICtrlCreateLabel("...", 160, 270, 520, 22)
    $g_lblTemps  = GUICtrlCreateLabel("...", 160, 295, 520, 22)

    GUICtrlSetColor($g_lblCPU,    0xFFFFFF)
    GUICtrlSetColor($g_lblRAM,    0xFFFFFF)
    GUICtrlSetColor($g_lblDisk,   0xFFFFFF)
    GUICtrlSetColor($g_lblOS,     0xFFFFFF)
    GUICtrlSetColor($g_lblUptime, 0xFFFFFF)
    GUICtrlSetColor($g_lblTime,   0xFFFFFF)
    GUICtrlSetColor($g_lblNet,    0xFFFFFF)
    GUICtrlSetColor($g_lblSec,    0xFFFFFF)
    GUICtrlSetColor($g_lblTemps,  0xFFFFFF)

    ; version text at bottom left
    $g_lblVersion = GUICtrlCreateLabel("GexSoft – " & $APP_NAME & " v" & $APP_VER & " (by gexos)", 20, 380, 600, 22)
    GUICtrlSetColor($g_lblVersion, 0xFFFFFF)
EndFunc

Func _CreateProcessGUI()
    $g_hProcGUI = GUICreate("Process Monitor", 760, 460, -1, -1, _
        BitOR($WS_CAPTION, $WS_SYSMENU, $WS_MINIMIZEBOX), -1, $g_hMainGUI)
    GUISetBkColor(0x001F4F, $g_hProcGUI)
    GUISetFont(10, 700, 0, "Segoe UI", $g_hProcGUI)

    Local $bar = GUICtrlCreateLabel("", 0, 0, 760, 4)
    GUICtrlSetBkColor($bar, $GEXSOFT_ORANGE)

    Local $lblTitle = GUICtrlCreateLabel("Process Monitor", 20, 15, 300, 24)
    GUICtrlSetFont($lblTitle, 14, 700, 0, "Segoe UI")
    GUICtrlSetColor($lblTitle, 0xFFFFFF)

    Local $lblFilter = GUICtrlCreateLabel("Filter:", 20, 50, 60, 22)
    GUICtrlSetColor($lblFilter, 0xFFFFFF)

    $g_inpProcFilter = GUICtrlCreateInput("", 75, 48, 250, 24)
    $ID_PROC_REFRESH = GUICtrlCreateButton("Refresh", 340, 45, 90, 28, $BS_FLAT)
    $ID_PROC_KILL    = GUICtrlCreateButton("Kill selected", 440, 45, 110, 28, $BS_FLAT)

    Local $grp = GUICtrlCreateGroup(" Running processes ", 15, 80, 730, 360)
    GUICtrlSetColor($grp, 0xFFFFFF)
    GUICtrlSetFont($grp, 10, 700, 0, "Segoe UI")

    $g_lvProc = GUICtrlCreateListView("Name|PID|Memory (MB)", 25, 105, 710, 320, _
        BitOR($LVS_REPORT, $LVS_SINGLESEL, $LVS_SHOWSELALWAYS), $WS_EX_CLIENTEDGE)

    Local $hLV = GUICtrlGetHandle($g_lvProc)
    _GUICtrlListView_SetExtendedListViewStyle($hLV, _
        BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_DOUBLEBUFFER))
    _GUICtrlListView_SetColumnWidth($hLV, 0, 360)
    _GUICtrlListView_SetColumnWidth($hLV, 1, 80)
    _GUICtrlListView_SetColumnWidth($hLV, 2, 120)

    GUICtrlCreateGroup("", -99, -99, 1, 1)

    GUISetState(@SW_HIDE, $g_hProcGUI)
EndFunc

Func _CreateNetworkGUI()
    $g_hNetGUI = GUICreate("Network Details", 700, 460, -1, -1, _
        BitOR($WS_CAPTION, $WS_SYSMENU, $WS_MINIMIZEBOX), -1, $g_hMainGUI)
    GUISetBkColor(0x001F4F, $g_hNetGUI)
    GUISetFont(10, 700, 0, "Segoe UI", $g_hNetGUI)

    Local $bar = GUICtrlCreateLabel("", 0, 0, 700, 4)
    GUICtrlSetBkColor($bar, $GEXSOFT_ORANGE)

    Local $lblTitle = GUICtrlCreateLabel("Network Details (WMI)", 20, 15, 350, 24)
    GUICtrlSetFont($lblTitle, 14, 700, 0, "Segoe UI")
    GUICtrlSetColor($lblTitle, 0xFFFFFF)

    $ID_NET_REFRESH = GUICtrlCreateButton("Refresh", 560, 15, 100, 28, $BS_FLAT)

    Local $grp = GUICtrlCreateGroup(" IP-enabled adapters ", 15, 50, 670, 380)
    GUICtrlSetColor($grp, 0xFFFFFF)
    GUICtrlSetFont($grp, 10, 700, 0, "Segoe UI")

    $g_txtNetDetails = GUICtrlCreateEdit("", 25, 75, 650, 340, _
        BitOR($ES_AUTOVSCROLL, $ES_READONLY, $WS_VSCROLL))

    GUICtrlCreateGroup("", -99, -99, 1, 1)

    GUISetState(@SW_HIDE, $g_hNetGUI)
EndFunc

Func _CreateSystemGUI()
    $g_hSysGUI = GUICreate("System Information", 700, 460, -1, -1, _
        BitOR($WS_CAPTION, $WS_SYSMENU, $WS_MINIMIZEBOX), -1, $g_hMainGUI)
    GUISetBkColor(0x001F4F, $g_hSysGUI)
    GUISetFont(10, 700, 0, "Segoe UI", $g_hSysGUI)

    Local $bar = GUICtrlCreateLabel("", 0, 0, 700, 4)
    GUICtrlSetBkColor($bar, $GEXSOFT_ORANGE)

    Local $lblTitle = GUICtrlCreateLabel("System Information (OS + hardware)", 20, 15, 420, 24)
    GUICtrlSetFont($lblTitle, 14, 700, 0, "Segoe UI")
    GUICtrlSetColor($lblTitle, 0xFFFFFF)

    $ID_SYS_REFRESH = GUICtrlCreateButton("Refresh", 560, 15, 100, 28, $BS_FLAT)

    Local $grp = GUICtrlCreateGroup(" System details ", 15, 50, 670, 380)
    GUICtrlSetColor($grp, 0xFFFFFF)
    GUICtrlSetFont($grp, 10, 700, 0, "Segoe UI")

    $g_txtSysInfo = GUICtrlCreateEdit("", 25, 75, 650, 340, _
        BitOR($ES_AUTOVSCROLL, $ES_READONLY, $WS_VSCROLL))

    GUICtrlCreateGroup("", -99, -99, 1, 1)

    GUISetState(@SW_HIDE, $g_hSysGUI)
EndFunc

Func _ShowAbout()
    If Not IsHWnd($g_hAboutGUI) Then
        $g_hAboutGUI = GUICreate("About " & $APP_NAME, 480, 260, -1, -1, _
            BitOR($WS_CAPTION, $WS_SYSMENU), -1, $g_hMainGUI)
        GUISetBkColor(0x001F4F, $g_hAboutGUI)
        GUISetFont(10, 700, 0, "Segoe UI", $g_hAboutGUI)

        Local $bar = GUICtrlCreateLabel("", 0, 0, 480, 4)
        GUICtrlSetBkColor($bar, $GEXSOFT_ORANGE)

        If FileExists("logo.png") Then
            GUICtrlCreatePic("logo.png", 380, 20, 64, 64)
        EndIf

        Local $lblTitle = GUICtrlCreateLabel($APP_NAME & " v" & $APP_VER, 20, 20, 340, 24)
        GUICtrlSetFont($lblTitle, 14, 700, 0, "Segoe UI")
        GUICtrlSetColor($lblTitle, 0xFFFFFF)

        Local $y = 70

        Local $lblAuthor = GUICtrlCreateLabel("Author: gexos (Giorgos Xanthopoulos)", 20, $y, 420, 20)
        GUICtrlSetColor($lblAuthor, 0xFFFFFF)
        $y += 20

        $ID_ABOUT_WEB = GUICtrlCreateLabel("Website: https://www.gexos.org", 20, $y, 420, 20)
        GUICtrlSetColor($ID_ABOUT_WEB, $GEXSOFT_ORANGE)
        GUICtrlSetCursor($ID_ABOUT_WEB, 4)
        $y += 20

        $ID_ABOUT_GEXSOFT = GUICtrlCreateLabel("GexSoft page: https://gexsoft.org/systeminfodashboard.html", 20, $y, 440, 20)
        GUICtrlSetColor($ID_ABOUT_GEXSOFT, $GEXSOFT_ORANGE)
        GUICtrlSetCursor($ID_ABOUT_GEXSOFT, 4)
        $y += 20

        $ID_ABOUT_GITHUB = GUICtrlCreateLabel("GitHub: https://github.com/Gexos/System-Info-Dashboard", 20, $y, 440, 20)
        GUICtrlSetColor($ID_ABOUT_GITHUB, $GEXSOFT_ORANGE)
        GUICtrlSetCursor($ID_ABOUT_GITHUB, 4)
        $y += 30

        Local $sTxt = _
            "Open source system dashboard for Windows." & @CRLF & _
            "You can review the code, build your own binary," & @CRLF & _
            "and verify hashes for extra peace of mind."

        Local $lblBody = GUICtrlCreateLabel($sTxt, 20, $y, 440, 80)
        GUICtrlSetColor($lblBody, 0xFFFFFF)
    EndIf

    GUISetState(@SW_SHOW, $g_hAboutGUI)
EndFunc

; ==========================
;  THEME TOGGLE
; ==========================

Func _ToggleTheme()
    $g_bDarkTheme = Not $g_bDarkTheme
    Local $col
    If $g_bDarkTheme Then
        $col = 0x001F4F
    Else
        $col = 0x202020
    EndIf

    If IsHWnd($g_hMainGUI) Then GUISetBkColor($col, $g_hMainGUI)
    If IsHWnd($g_hProcGUI) Then GUISetBkColor($col, $g_hProcGUI)
    If IsHWnd($g_hNetGUI) Then GUISetBkColor($col, $g_hNetGUI)
    If IsHWnd($g_hSysGUI) Then GUISetBkColor($col, $g_hSysGUI)
    If IsHWnd($g_hAboutGUI) Then GUISetBkColor($col, $g_hAboutGUI)
EndFunc

; ==========================
;  MAIN DASHBOARD UPDATE
; ==========================

Func _UpdateMainDashboard()
    Local $sCPU    = _GetCPUUsage()
    Local $sRAM    = _GetRAMUsage()
    Local $sDisk   = _GetDiskUsageSummary()
    Local $sUpt    = _GetSystemUptime()
    Local $sTime   = _NowCalc()
    Local $sNet    = _GetNetworkSummary()
    Local $sSec    = _GetSecuritySummary()
    Local $sTemp   = _GetTemperatureSummary()

    GUICtrlSetData($g_lblCPU,    $sCPU)
    GUICtrlSetData($g_lblRAM,    $sRAM)
    GUICtrlSetData($g_lblDisk,   $sDisk)
    GUICtrlSetData($g_lblUptime, $sUpt)
    GUICtrlSetData($g_lblTime,   $sTime)
    GUICtrlSetData($g_lblNet,    $sNet)
    GUICtrlSetData($g_lblSec,    $sSec)
    GUICtrlSetData($g_lblTemps,  $sTemp)
EndFunc

; ==========================
;  PROCESS MONITOR
; ==========================

Func _UpdateProcessList()
    Local $sFilter = StringLower(StringStripWS(GUICtrlRead($g_inpProcFilter), 3))
    Local $hLV = GUICtrlGetHandle($g_lvProc)
    _GUICtrlListView_DeleteAllItems($hLV)

    Local $aList = ProcessList()
    If @error Then Return

    For $i = 1 To $aList[0][0]
        Local $name = $aList[$i][0]
        Local $pid  = $aList[$i][1]

        If $sFilter <> "" Then
            If Not StringInStr(StringLower($name), $sFilter) Then ContinueLoop
        EndIf

        Local $memMB = "-"
        Local $aStats = ProcessGetStats($pid)
        If IsArray($aStats) Then
            Local $memKB = $aStats[0]
            $memMB = Int($memKB / 1024)
        EndIf

        Local $sItem = $name & "|" & $pid & "|" & $memMB
        GUICtrlCreateListViewItem($sItem, $g_lvProc)
    Next
EndFunc

Func _KillSelectedProcess()
    Local $hLV = GUICtrlGetHandle($g_lvProc)
    Local $iIndex = _GUICtrlListView_GetNextItem($hLV, -1, $LVNI_SELECTED)
    If $iIndex = -1 Then
        MsgBox(48, "Kill Process", "No process selected.")
        Return
    EndIf

    Local $sName = _GUICtrlListView_GetItemText($hLV, $iIndex, 0)
    Local $sPID  = _GUICtrlListView_GetItemText($hLV, $iIndex, 1)
    Local $iPID  = Number($sPID)

    If $iPID <= 0 Then
        MsgBox(48, "Kill Process", "Invalid PID.")
        Return
    EndIf

    Local $iAns = MsgBox(49, "Kill Process", _
        "You are about to kill:" & @CRLF & @CRLF & _
        "  " & $sName & " (PID " & $iPID & ")" & @CRLF & @CRLF & _
        "This may cause instability or data loss." & @CRLF & _
        "Are you sure?")

    If $iAns <> 1 Then Return

    ; try normal kill first
    Local $bOk = ProcessClose($iPID)

    ; if it survives, use taskkill /F
    If Not $bOk Then
        Local $sCmd = 'taskkill /PID ' & $iPID & ' /F'
        Local $pidTk = Run(@ComSpec & " /c " & $sCmd, "", @SW_HIDE, $STDOUT_CHILD)
        If $pidTk Then ProcessWaitClose($pidTk)
    EndIf

    Sleep(300)
    _UpdateProcessList()
EndFunc

; ==========================
;  NETWORK DETAILS
; ==========================

Func _UpdateNetworkDetails()
    Local $sOut = ""
    Local $oWMI = ObjGet("winmgmts:\\.\root\CIMV2")
    If @error Then
        GUICtrlSetData($g_txtNetDetails, "Failed to open WMI root\CIMV2.")
        Return
    EndIf

    Local $col = $oWMI.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = TRUE")
    If Not IsObj($col) Then
        GUICtrlSetData($g_txtNetDetails, "No IP-enabled adapters found (ExecQuery error).")
        Return
    EndIf

    For $obj In $col
        $sOut &= "--------------------------------------------------------" & @CRLF
        $sOut &= "Description: " & $obj.Description & @CRLF
        $sOut &= "MAC Address: " & $obj.MACAddress & @CRLF

        If IsArray($obj.IPAddress) Then $sOut &= "IP Address: " & $obj.IPAddress(0) & @CRLF
        If IsArray($obj.IPSubnet) Then $sOut &= "Subnet: " & $obj.IPSubnet(0) & @CRLF
        If IsArray($obj.DefaultIPGateway) Then $sOut &= "Gateway: " & $obj.DefaultIPGateway(0) & @CRLF
        If IsArray($obj.DNSServerSearchOrder) Then $sOut &= "DNS: " & $obj.DNSServerSearchOrder(0) & @CRLF

        $sOut &= @CRLF
    Next

    GUICtrlSetData($g_txtNetDetails, $sOut)
EndFunc

; ==========================
;  SYSTEM INFO
; ==========================

Func _UpdateSystemInfo()
    Local $sOut = ""
    Local $oWMI = ObjGet("winmgmts:\\.\root\CIMV2")
    If @error Then
        GUICtrlSetData($g_txtSysInfo, "Failed to open WMI root\CIMV2.")
        Return
    EndIf

    Local $colOS = $oWMI.ExecQuery("SELECT * FROM Win32_OperatingSystem")
    If IsObj($colOS) Then
        For $os In $colOS
            $sOut &= "Operating System" & @CRLF
            $sOut &= "----------------" & @CRLF
            $sOut &= "Caption: " & $os.Caption & @CRLF
            $sOut &= "Version: " & $os.Version & @CRLF
            $sOut &= "Build: " & $os.BuildNumber & @CRLF
            $sOut &= "Install Date: " & $os.InstallDate & @CRLF
            $sOut &= "Last Boot: " & $os.LastBootUpTime & @CRLF & @CRLF
        Next
    Else
        $sOut &= "Could not query Win32_OperatingSystem via WMI." & @CRLF & @CRLF
    EndIf

    Local $colCS = $oWMI.ExecQuery("SELECT * FROM Win32_ComputerSystem")
    If IsObj($colCS) Then
        For $cs In $colCS
            $sOut &= "Computer System" & @CRLF
            $sOut &= "----------------" & @CRLF
            $sOut &= "Manufacturer: " & $cs.Manufacturer & @CRLF
            $sOut &= "Model: " & $cs.Model & @CRLF
            $sOut &= "Total Physical Memory: " & Int($cs.TotalPhysicalMemory / 1024 / 1024) & " MB" & @CRLF
            $sOut &= "Number of Processors: " & $cs.NumberOfProcessors & @CRLF
            $sOut &= "Number of Logical Processors: " & $cs.NumberOfLogicalProcessors & @CRLF & @CRLF
        Next
    Else
        $sOut &= "Could not query Win32_ComputerSystem via WMI." & @CRLF & @CRLF
    EndIf

    GUICtrlSetData($g_txtSysInfo, $sOut)
EndFunc

; ==========================
;  EXPORT REPORT
; ==========================

Func _ExportReport($format)
    Local $filter, $defaultExt
    If $format = "html" Then
        $filter = "HTML Files (*.html)"
        $defaultExt = ".html"
    Else
        $filter = "Text Files (*.txt)"
        $defaultExt = ".txt"
    EndIf

    Local $path = FileSaveDialog("Save Report As", @DesktopDir, $filter, $FD_PATHMUSTEXIST, "SystemReport" & $defaultExt)
    If @error Or $path = "" Then Return

    Local $sReport = "System Info Report" & @CRLF & _
        "-----------------------------" & @CRLF & _
        "CPU Usage: " & GUICtrlRead($g_lblCPU) & @CRLF & _
        "RAM Usage: " & GUICtrlRead($g_lblRAM) & @CRLF & _
        "Disk Usage: " & GUICtrlRead($g_lblDisk) & @CRLF & _
        "OS Version: " & GUICtrlRead($g_lblOS) & @CRLF & _
        "System Uptime: " & GUICtrlRead($g_lblUptime) & @CRLF & _
        "Current Time: " & GUICtrlRead($g_lblTime) & @CRLF & _
        "Network: " & GUICtrlRead($g_lblNet) & @CRLF & _
        "Security: " & GUICtrlRead($g_lblSec) & @CRLF & _
        "Temperatures: " & GUICtrlRead($g_lblTemps)

    If $format = "txt" Then
        FileWrite($path, $sReport)
    Else
        Local $html = "<html><body><h2>System Info Report</h2><pre>" & _
            StringReplace($sReport, @CRLF, "<br>") & _
            "</pre></body></html>"
        FileWrite($path, $html)
    EndIf

    MsgBox(64, "Export", "Report saved:" & @CRLF & $path)
EndFunc

; ==========================
;  BASIC INFO HELPERS
; ==========================

Func _GetCPUUsage()
    Local $oWMI = ObjGet("winmgmts:\\.\root\CIMV2")
    If @error Then Return "N/A"
    Local $col = $oWMI.ExecQuery("SELECT LoadPercentage FROM Win32_Processor")
    If Not IsObj($col) Then Return "N/A"
    For $cpu In $col
        Return $cpu.LoadPercentage & " %"
    Next
    Return "N/A"
EndFunc

Func _GetRAMUsage()
    Local $oWMI = ObjGet("winmgmts:\\.\root\CIMV2")
    If Not @error Then
        Local $colOS = $oWMI.ExecQuery("SELECT TotalVisibleMemorySize, FreePhysicalMemory FROM Win32_OperatingSystem")
        If IsObj($colOS) Then
            For $os In $colOS
                Local $totalMB = Int($os.TotalVisibleMemorySize / 1024)
                Local $freeMB  = Int($os.FreePhysicalMemory / 1024)
                Local $usedMB  = $totalMB - $freeMB
                Local $percent = 0
                If $totalMB > 0 Then $percent = Int(($usedMB / $totalMB) * 100)
                Return $percent & " % (" & $usedMB & " MB / " & $totalMB & " MB)"
            Next
        EndIf
    EndIf

    ; fallback if WMI fails
    Local $memStats = MemGetStats()
    Local $totalMB = Int($memStats[0] / 1024)
    Local $freeMB  = Int($memStats[1] / 1024)
    Local $usedMB  = $totalMB - $freeMB
    Local $percent = 0
    If $totalMB > 0 Then $percent = Int(($usedMB / $totalMB) * 100)
    Return $percent & " % (" & $usedMB & " MB / " & $totalMB & " MB)"
EndFunc

Func _GetDiskUsageSummary()
    Local $drives = DriveGetDrive("FIXED")
    If @error Or Not IsArray($drives) Then Return "N/A"

    Local $s = ""
    For $i = 1 To $drives[0]
        Local $drive = $drives[$i] & "\"
        Local $total = DriveSpaceTotal($drive)
        Local $free  = DriveSpaceFree($drive)
        If $total = "" Or $free = "" Then ContinueLoop

        Local $used = $total - $free
        Local $p = 0
        If $total > 0 Then $p = Int(($used / $total) * 100)

        ; one line per drive, nice and readable
        $s &= $drives[$i] & ": " & $p & "% (" & Int($used) & " GB / " & Int($total) & " GB)" & @CRLF
    Next

    If $s = "" Then Return "N/A"
    Return StringStripWS($s, 2)
EndFunc

Func _GetSystemUptime()
    Local $oWMI = ObjGet("winmgmts:\\.\root\CIMV2")
    If @error Then Return "N/A"
    Local $colOS = $oWMI.ExecQuery("SELECT LastBootUpTime FROM Win32_OperatingSystem")
    If Not IsObj($colOS) Then Return "N/A"
    For $os In $colOS
        Local $boot = WMIDateStringToDate($os.LastBootUpTime)
        Local $secs = _DateDiff('s', $boot, _NowCalc())
        Local $hours = Int($secs / 3600)
        Return $hours & " hours"
    Next
    Return "N/A"
EndFunc

Func WMIDateStringToDate($sDate)
    Return StringMid($sDate, 1, 4) & "/" & StringMid($sDate, 5, 2) & "/" & StringMid($sDate, 7, 2) & " " & _
        StringMid($sDate, 9, 2) & ":" & StringMid($sDate, 11, 2) & ":" & StringMid($sDate, 13, 2)
EndFunc

Func _GetNetworkSummary()
    Local $host = @ComputerName
    Local $ip = @IPAddress1
    If $ip = "0.0.0.0" Then $ip = @IPAddress2
    If $ip = "0.0.0.0" Then $ip = "N/A"
    Return $host & " - IP: " & $ip
EndFunc

Func _GetSecuritySummary()
    Local $sAV = "AV: Unknown"
    Local $sFW = "FW: Unknown"
    Local $sWU = "WU: Unknown"

    ; AntiVirus
    Local $oSC = ObjGet("winmgmts:\\.\root\SecurityCenter2")
    If Not @error Then
        Local $colAV = $oSC.ExecQuery("SELECT * FROM AntiVirusProduct")
        If IsObj($colAV) Then
            For $av In $colAV
                Local $name = $av.displayName
                If $name = "" Then $name = "Unknown AV"
                $sAV = "AV: " & $name
                ExitLoop
            Next
        EndIf
    EndIf

    ; Firewall
    Local $oFW = ObjCreate("HNetCfg.FwPolicy2")
    If Not @error And IsObj($oFW) Then
        Local $onCount = 0
        If $oFW.FirewallEnabled(0) Then $onCount += 1 ; Domain
        If $oFW.FirewallEnabled(1) Then $onCount += 1 ; Private
        If $oFW.FirewallEnabled(2) Then $onCount += 1 ; Public

        Select
            Case $onCount = 3
                $sFW = "FW: ON (all)"
            Case $onCount = 0
                $sFW = "FW: OFF"
            Case Else
                $sFW = "FW: Partial"
        EndSelect
    EndIf

    ; Windows Update service
    Local $oWMI = ObjGet("winmgmts:\\.\root\CIMV2")
    If Not @error Then
        Local $colSvc = $oWMI.ExecQuery("SELECT * FROM Win32_Service WHERE Name='wuauserv'")
        If IsObj($colSvc) Then
            For $svc In $colSvc
                $sWU = "WU: " & $svc.State
                ExitLoop
            Next
        EndIf
    EndIf

    Return $sAV & " | " & $sFW & " | " & $sWU
EndFunc

; ==========================
;  TEMPERATURES (OPTIONAL)
; ==========================

Func _GetTemperatureSummary()
    ; If you drop a file "lhm_temps.txt" next to the EXE, it will read:
    ;   CPU=xx
    ;   DISK=yy
    Local $sFile = @ScriptDir & "\lhm_temps.txt"
    If Not FileExists($sFile) Then
        Return "N/A (LibreHardwareMonitor)"
    EndIf

    Local $data = FileRead($sFile)
    If @error Or $data = "" Then
        Return "N/A (LibreHardwareMonitor)"
    EndIf

    Local $cpu = ""
    Local $disk = ""

    $data = StringStripCR($data)
    Local $aLines = StringSplit($data, @LF, 1)
    If Not IsArray($aLines) Then Return "N/A (LibreHardwareMonitor)"

    For $i = 1 To $aLines[0]
        Local $line = StringStripWS($aLines[$i], 3)
        If $line = "" Then ContinueLoop
        If StringLeft($line, 4) = "CPU=" Then
            $cpu = StringTrimLeft($line, 4)
        ElseIf StringLeft($line, 5) = "DISK=" Then
            $disk = StringTrimLeft($line, 5)
        EndIf
    Next

    If $cpu = "" And $disk = "" Then Return "N/A (LibreHardwareMonitor)"

    Local $s = ""
    If $cpu <> "" Then $s &= "CPU: " & $cpu & "°C"
    If $disk <> "" Then
        If $s <> "" Then $s &= "  |  "
        $s &= "Disk: " & $disk & "°C"
    EndIf

    Return $s
EndFunc

; ==========================
;  LIBRE HARDWARE MONITOR
; ==========================

Func _OpenLibreHardwareMonitor()
    Local $exe = @ScriptDir & "\LibreHardwareMonitor.exe"
    If Not FileExists($exe) Then
        MsgBox(48, "LibreHardwareMonitor", _
            "LibreHardwareMonitor.exe not found in:" & @CRLF & @ScriptDir & @CRLF & _
            "Put LibreHardwareMonitor.exe in the same folder or edit the path in the code.")
        Return
    EndIf
    ShellExecute($exe)
EndFunc

; ==========================
;  OPEN HELP FILE
; ==========================

Func _OpenHelpFile()
    Local $sHelp = @ScriptDir & "\HELP.txt"
    If Not FileExists($sHelp) Then
        MsgBox(48, "Help", "HELP.txt not found in:" & @CRLF & @ScriptDir & @CRLF & _
            "Create HELP.txt (for example using the help text from the GitHub repo).")
        Return
    EndIf

    ShellExecute("notepad.exe", '"' & $sHelp & '"')
EndFunc
