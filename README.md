
# System Info Dashboard

![AutoIt](https://img.shields.io/badge/built%20with-AutoIt-1abc9c)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Version](https://img.shields.io/badge/version-5.0.0-orange)

**System Info Dashboard** is a lightweight system utility for Windows, written in AutoIt, that brings key system information into a clean, technician‑friendly dashboard.

---

## Features

- **Main Dashboard**
  - CPU usage
  - RAM usage (MB + %)
  - Disk usage for all fixed drives
  - OS version & architecture
  - System uptime
  - Current time
  - Network summary (hostname + IP)
  - Security summary: Antivirus, Firewall, Windows Update status
  - Optional: CPU / Disk temperatures via LibreHardwareMonitor

- **Process Monitor**
  - List of running processes with:
    - Name, PID, Memory (MB)
  - Filter by name
  - Kill selected process (with warning about possible instability)

- **Network Details**
  - Detailed information for IP‑enabled adapters (WMI):
    - Description, MAC, IP, subnet, gateway, DNS

- **System Information**
  - OS info (caption, version, build, install date, last boot)
  - Computer system info (manufacturer, model, total RAM, logical/physical processors)

- **Extra Tools**
  - Tray icon & minimize to tray
  - Dark theme toggle
  - Export system report to **TXT** or **HTML**
  - Windows Tools menu:
    - Task Manager
    - Device Manager
    - Event Viewer
    - Services
    - Disk Management
    - System Information (msinfo32)
    - Command Prompt

---

## Download & Requirements

- **Platform:** Windows 10/11 (x64 recommended)
- **Dependencies:** none for basic functionality  
- Optional temperature support:
  - [LibreHardwareMonitor](https://github.com/LibreHardwareMonitor/LibreHardwareMonitor) next to the EXE

> For portable use, simply extract the ZIP to a folder and run `System Info Dashboard.exe`.
> No installer is required and no registry changes are made by default.

---

## LibreHardwareMonitor integration (temperatures)

System Info Dashboard can show CPU / Disk temperatures if it finds a file:

```text
lhm_temps.txt
```

in the same folder as the EXE, with content like:

```text
CPU=45
DISK=33
```

Basic workflow:

1. Download **LibreHardwareMonitor**.
2. Place `LibreHardwareMonitor.exe` in the same folder as `System Info Dashboard.exe`.
3. Use a small script / log rule in LibreHardwareMonitor to write temperatures to `lhm_temps.txt`.
4. The main dashboard will read this file and display the values in the **Temperatures** line.

(A dedicated helper for this may be added in the future.)

---

## Usage

1. Run `System Info Dashboard.exe`.
2. Check the overall system overview in the **main window**.
3. From the menu:
   - **Main → Process Monitor…** to inspect and manage processes.
   - **Main → Network Details…** for detailed network info (WMI).
   - **Main → System Information…** for OS & hardware details.
   - **Main → Export TXT/HTML report** to save a system report.
   - **Windows Tools** for quick access to native Windows tools.
   - **Help → Open Help…** opens `HELP.txt`.
   - **Help → About System Info Dashboard** shows version & links.

The app can hide to the tray when minimized, so it can stay out of the way while you work.

---

## Security & Antivirus notes

**System Info Dashboard:**

- is written in **AutoIt**,
- uses WMI and process APIs to read system information,
- can terminate processes (Process Monitor).

Because of these behaviours:

- Some antivirus engines may flag it as **“suspicious” or “generic”** (false positive).
- The code is **open source** – you can review it, build your own binary, and compare hashes.

Recommended:

- Verify the hashes of the EXE against the ones published on the website / release page.
- If your antivirus blocks it, only whitelist it if you trust the source and have verified the binary.

---

## Build from source

1. Install:
   - [AutoIt](https://www.autoitscript.com/site/autoit/)
   - SciTE + AutoIt3Wrapper (usually comes with the AutoIt full install)
2. Clone or download the repository.
3. Open `info.au3` in SciTE.
4. Use `Tools → Build` to create the EXE with:
   - embedded icon (`sysinfo.ico`)
   - version info (`5.0.0.0`)
   - file description: `System Info Dashboard v5.0.0`

You can change the version by editing:

```autoit
Global Const $APP_VER = "5.0.0"

#AutoIt3Wrapper_Res_Description=System Info Dashboard v5.0.0
#AutoIt3Wrapper_Res_Fileversion=5.0.0.0
#AutoIt3Wrapper_Res_ProductVersion=5.0.0.0
```

---

## Author

- **Author:** gexos (Giorgos Xanthopoulos)  
- **Website:** https://www.gexos.org  
- **Project page:** https://gexsoft.org/systeminfodashboard.html  
- **GitHub:** https://github.com/Gexos/System-Info-Dashboard
