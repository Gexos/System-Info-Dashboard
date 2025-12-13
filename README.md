# System Info Dashboard

![AutoIt](https://img.shields.io/badge/built%20with-AutoIt-1abc9c)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Version](https://img.shields.io/badge/version-5.0.2-orange)

# System Info Dashboard (SID)

System Info Dashboard (SID) is a small, portable Windows utility written in AutoIt.  
It gives you a quick, at-a-glance view of your system status and a simple process monitor in one clean window.

> **Platform:** Windows 10/11  
> **Type:** Portable EXE (no installer)  
> **Source:** AutoIt `.au3` script included in this repository

---

## Features

- **System overview (main window)**
  - CPU usage (live)
  - RAM usage (used / total)
  - Disk usage summary per drive (C:, D:, external drives, VHDs, etc.)
  - OS version and architecture
  - System uptime
  - Current date and time
  - Basic network info
  - Simple security status summary (firewall/AV status where available)
- **Process Monitor**
  - List running processes with name, PID and memory usage
  - Filter by process name
  - Refresh list on demand
  - **Kill Selected** with confirmation dialog (improved handling to avoid “no process selected” issues)
- **Temperatures (optional)**
  - Designed to work together with LibreHardwareMonitor
  - SID can open LibreHardwareMonitor so you can see temperatures and sensors when needed
- **Portable & lightweight**
  - Single EXE, no installer
  - No services, no scheduled tasks
  - No registry modifications required for normal use

---

## Download

You can download:

- The compiled **SysInfoDash.exe**  
- The full **AutoIt source** (`System_Info_Dashboard.au3`)

from the **Releases** section of this repository.

> Tip: If you don’t trust prebuilt binaries, you can open the `.au3` source in SciTE and compile SID yourself with AutoIt.

---

## How to use

1. **Run `SysInfoDash.exe`**
   - No installation needed. You can run it from any folder, including a USB stick.

2. **Main dashboard**
   - The main window shows CPU, RAM, disk usage, OS, uptime, time, network and a short security summary.
   - Disk usage has a dedicated multi-line area so multiple drives (internal, external, VHDs) are displayed clearly.

3. **Process Monitor**
   - Open **Tools >> Process Monitor** (or the corresponding button/menu in the app).
   - You can:
     - Filter processes by name.
     - Select a process and click **Kill Selected**.
   - SID shows a confirmation dialog before terminating a process.
   - If Windows/AutoIt loses track of the selection, SID safely falls back to the first row and still shows a confirmation dialog, so you always know what you’re about to kill.

4. **Temperatures (optional)**
   - Download LibreHardwareMonitor and place it somewhere on your system.
   - Use the SID menu/option to open LibreHardwareMonitor when you want detailed temperature and sensor readings.

---

## Security / Antivirus (false positives)

SID is written in **AutoIt**, which unfortunately is sometimes abused by malware authors.  
Because of that, some antivirus products may occasionally flag **legitimate AutoIt tools** as suspicious or as a *generic* threat, even when the code is clean.

A few important points:

- The full **source code** (`.au3`) is included in this repository.
- You can **review** the code and **compile the EXE yourself** using the official AutoIt tools.
- SID does **not** install drivers, services, or scheduled tasks.
- SID does **not** make unsolicited network connections.

If your antivirus flags SID:

1. Make sure you downloaded it from the **official repository/GexSoft links**.
2. Verify the file hash against the hash provided on the download page (if available).
3. If you are still unsure, compile the EXE yourself from the included `.au3` script.

---

## Known limitations/notes

- Very tiny volumes (e.g. test VHDs of only a few MB) may show rounded capacity values when converted to GB.  
  This doesn’t affect normal use on regular system drives.
- Some advanced security / AV status checks depend on Windows APIs and may not be available in all environments.

--- 
- Written in AutoIt by Giorgos Xanthopoulos (gexos)

See the repository for license information, usage terms, and contribution guidelines.
