# System Info Dashboard

**System Info Dashboard** is a lightweight system monitoring tool for Windows, written in [AutoIt](https://www.autoitscript.com/).

It shows real-time:
- CPU usage (+ temperature when available)
- RAM usage (% and MB)
- Disk usage for all fixed drives
- Basic network info
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
3. Make sure `sysinfo.ico` is available if referenced in `#AutoIt3Wrapper_Icon`.
4. `Tools → Build` to create the EXE.

---

## Security & Verification

- No telemetry, no hidden services.
- Only writes:
  - Optional Run key (if you enable “Run at startup”)
  - `.ini` config next to the EXE
  - Log file in `%TEMP%\SystemInfoDashboard\`

You can verify the EXE:

```cmd
certutil -hashfile SystemInfoDashboard.exe SHA256
