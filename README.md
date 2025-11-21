<p align="center">
  <!-- Adjust the path if needed -->
  <img src="assets/systeminfo-logo.png" alt="System Info Dashboard logo" width="96">
</p>

<h1 align="center">System Info Dashboard</h1>

<p align="center">
  <strong>Lightweight system monitoring tool for Windows (CPU / RAM / Disks / Network / Processes)</strong>
</p>

<p align="center">
  <a href="https://github.com/Gexos/System-Info-Dashboard/releases">
    <img src="https://img.shields.io/github/v/release/Gexos/System-Info-Dashboard?style=for-the-badge" alt="Latest release">
  </a>
  <a href="https://github.com/Gexos/System-Info-Dashboard/releases">
    <img src="https://img.shields.io/github/downloads/Gexos/System-Info-Dashboard/total?style=for-the-badge" alt="Downloads">
  </a>
  <img src="https://img.shields.io/badge/platform-Windows-0078D6?style=for-the-badge&logo=windows" alt="Windows">
  <img src="https://img.shields.io/badge/language-AutoIt-1f425f?style=for-the-badge" alt="AutoIt">
  <a href="LICENSE">
    <img src="https://img.shields.io/github/license/Gexos/System-Info-Dashboard?style=for-the-badge" alt="License">
  </a>
</p>

---

**System Info Dashboard** is a compact system monitoring & diagnostics tool for **Windows**, written in [AutoIt](https://www.autoitscript.com/).

It shows, in real time:

- CPU usage (+ temperature when available)
- RAM usage (% and MB)
- Disk usage for all fixed drives
- Basic network info & diagnostics
- System & hardware info
- Running processes (with kill / force-kill / end process tree)

Project by **gexos (Giorgos Xanthopoulos)** · Open source

---

## Screenshots

> Replace the image paths with your actual files (e.g. `docs/img/...`).

<p align="center">
  <img src="docs/img/main-dashboard.png" alt="Main dashboard" width="700"><br>
  <em>Main dashboard – CPU, RAM, disks, uptime, network summary.</em>
</p>

<p align="center">
  <img src="docs/img/process-monitor.png" alt="Process monitor" width="700"><br>
  <em>Process Monitor – filter, kill, force kill, end process tree, export.</em>
</p>

---

## Features (Quick List)

- Live CPU & RAM usage
- CPU temperature via **LibreHardwareMonitor** / **OpenHardwareMonitor** / ACPI (when supported)
- Auto-detected fixed drives (C:, D:, …) with usage and GB
- System info: OS version, uptime, clock, battery status
- Network details + simple network diagnostics (pings)
- Process Monitor:
  - Name + PID
  - Filter by name
  - Kill / Force Kill / End Process Tree
  - Export list to TXT/CSV
- Optional tray icon & settings:
  - Refresh interval
  - Show system processes
  - Run at startup
- Exports:
  - TXT / HTML system report
  - JSON snapshot
  - CSV performance history
  - Support bundle (logs + info)

---

## Temperatures & LibreHardwareMonitor

For better CPU temperature readings, the app can use **LibreHardwareMonitor** as a backend:

1. Download **LibreHardwareMonitor** (portable ZIP) from its official GitHub.
2. Put `LibreHardwareMonitor.exe` in the **same folder** as `SystemInfoDashboard.exe`.
3. Run System Info Dashboard.

The app will:

- Check if `LibreHardwareMonitor.exe` is already running,  
  and if not, try to start it minimized.
- Read temperature sensors from WMI:
  - Namespace: `root\LibreHardwareMonitor`
  - Class: `Sensor`
  - Filter: `SensorType = 'Temperature'` and names that contain `"CPU"`.

If LibreHardwareMonitor / OpenHardwareMonitor or WMI sensors are not available on the machine, CPU temperature will show as **N/A**.

---

## Antivirus False Positives (IMPORTANT)

Some antivirus products may flag the EXE as a *“tool”*, *“hacktool”* or *“potentially unwanted”*. Common reasons:

- Written in **AutoIt**, often used for admin utilities and scripts.
- Can **enumerate and kill processes**, including `taskkill /F`.
- Portable EXE that does not come from a big vendor.

This does **not** mean the app is malicious:

- The code is **open source** – see `info.au3` in this repository.
- You can **build the EXE yourself** from the source.
- The app works **locally only** – it does not send data anywhere.

If you’re unsure, you can:

- Upload the EXE to [VirusTotal](https://www.virustotal.com).
- Compare the hash with the one listed on the release page.
- Build your own EXE and verify its hash.

---

## Requirements

- Windows 10 or later (32-bit or 64-bit)
- WMI enabled

Optional (recommended for temperature):

- [LibreHardwareMonitor](https://github.com/LibreHardwareMonitor/LibreHardwareMonitor)

---

## Download & Install

- **Source:**  
  `https://github.com/Gexos/System-Info-Dashboard`

- **Binary:**  
  `https://github.com/Gexos/System-Info-Dashboard/releases`  
  or via `https://gexsoft.org/systeminfodashboard.html`

**Install / run:**

1. Extract the `.zip` to a folder, e.g. `C:\Tools\SystemInfoDashboard\`.
2. (Optional) In the same folder, place:
   - `LibreHardwareMonitor.exe`
   - `sysinfo.ico`
   - `logo.png`
3. Run `SystemInfoDashboard.exe` (portable, no installer).

The app writes only:

- Optional `Run` key in `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` (if you enable “Run at startup”).
- An `.ini` configuration next to the EXE.
- Log file in `%TEMP%\SystemInfoDashboard\`.

---

## Build from Source

1. Install **AutoIt** and **SciTE**.
2. Open `info.au3` in SciTE.
3. Ensure `sysinfo.ico` exists if referenced by `#AutoIt3Wrapper_Icon`.
4. Use **Tools → Build** to generate the EXE.

---

## License

Open source. See [`LICENSE`](LICENSE) for details.
