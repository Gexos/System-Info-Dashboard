# System Info Dashboard

**System Info Dashboard** is a lightweight system monitoring tool for Windows, written in [AutoIt](https://www.autoitscript.com/).

It shows real-time:

- CPU usage (+ temperature when available)
- RAM usage (% and MB)
- Disk usage for all fixed drives
- Basic network info & diagnostics
- System & hardware details
- Running processes (with kill / force-kill options)

Project by **gexos (Giorgos Xanthopoulos)** · Open source

---

## Features

- Live CPU & RAM usage
- CPU temperature via LibreHardwareMonitor / OpenHardwareMonitor / ACPI (when supported)
- Auto-detected fixed drives (C:, D:, …) with usage and GB
- System info: OS version, uptime, time, battery status
- Network details + simple network diagnostics (pings)
- Process Monitor with:
  - Name + PID
  - Filter by name
  - Kill / Force Kill / End Process Tree
  - Export to TXT/CSV
- Optional tray icon, settings (refresh interval, show system processes, run at startup)
- Exports: TXT, HTML, JSON, CSV, support bundle (logs + info)

---

## Temperatures & LibreHardwareMonitor

To get more accurate CPU temperature readings, the app can use **LibreHardwareMonitor** as a backend:

1. Download **LibreHardwareMonitor** (portable ZIP) from its official GitHub.
2. Put `LibreHardwareMonitor.exe` in the **same folder** as `SystemInfoDashboard.exe`.
3. Start System Info Dashboard.
4. The app will:
   - Check if `LibreHardwareMonitor.exe` is running; if not, try to start it minimized.
   - Read temperature sensors from WMI: `root\LibreHardwareMonitor`, class `Sensor`, `SensorType='Temperature'`.

If LibreHardwareMonitor / OpenHardwareMonitor or WMI sensors are not available on a machine, CPU temperature will show as `N/A`.

---

## Why Some Antivirus Tools Flag It

Some antivirus engines may flag this app as a “tool”, “hacktool” or “potentially unwanted program”. Typical reasons:

- It is written in **AutoIt**, which is often used for admin tools and scripts.
- It can **list and kill processes**, including using `taskkill /F`, which is powerful behavior.
- It is a **portable executable** and may be packed/compressed.

This does **not** mean the app is malicious. The code is:

- **Open source** – you can read the `info.au3` script yourself.
- **Buildable by you** – you can compile your own EXE from the source.
- **Local only** – it does not send data anywhere.

If you are unsure, you can:

- Upload the EXE to [VirusTotal](https://www.virustotal.com).
- Build the EXE yourself from source and compare hashes.

---

## Requirements

- Windows 10 or later (32-bit or 64-bit)
- WMI enabled

Optional (recommended for temperature):

- [LibreHardwareMonitor](https://github.com/LibreHardwareMonitor/LibreHardwareMonitor)

---

## Download & Install

- Source: `https://github.com/Gexos/System-Info-Dashboard`
- Binary: `https://github.com/Gexos/System-Info-Dashboard/releases`  
  (or via `https://gexsoft.org/systeminfodashboard.html`)

To install:

1. Extract the `.zip` to a folder, e.g. `C:\Tools\SystemInfoDashboard\`
2. (Optional) Place in the same folder:
   - `LibreHardwareMonitor.exe`
   - `sysinfo.ico`
   - `logo.png`
3. Run `SystemInfoDashboard.exe` (portable, no installer).

---

## Build from Source

1. Install AutoIt + SciTE.
2. Open `info.au3` in SciTE.
3. Make sure `sysinfo.ico` exists if referenced in `#AutoIt3Wrapper_Icon`.
4. Use `Tools → Build` to create the EXE.

---

## Security & Verification

- No telemetry, no hidden services.
- Writes only:
  - Optional Run key (if you enable “Run at startup”)
  - `.ini` config next to the EXE
  - Log file in `%TEMP%\SystemInfoDashboard\`

Verify the EXE (example, Command Prompt):

```cmd
certutil -hashfile SystemInfoDashboard.exe SHA256
