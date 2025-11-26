# System Info Dashboard

![AutoIt](https://img.shields.io/badge/built%20with-AutoIt-1abc9c)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Version](https://img.shields.io/badge/version-5.0.0-orange)

**System Info Dashboard** is a lightweight system utility for Windows, written in AutoIt, that brings key system information into a clean, technician-friendly dashboard.

The app is **portable**: no installer, no default registry changes, and can be run from a USB stick or tools folder.

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
  - **Optional:** CPU / disk temperatures via an external LibreHardwareMonitor setup (not enabled by default)

- **Process Monitor**
  - List of running processes with:
    - Name, PID, Memory (MB)
  - Filter by name
  - Kill selected process (with warning about possible instability)

- **Network Details**
  - Detailed information for IP-enabled adapters (WMI):
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
- **Dependencies:** none for the main features  
- **Optional:** LibreHardwareMonitor if you want temperature integration

For portable use:

1. Download the ZIP from ![GitHub Releases](https://github.com/Gexos/System-Info-Dashboard/releases).
2. Extract it to a folder.
3. Run `System Info Dashboard.exe`.

No installer is required.

---

## Optional temperature integration (LibreHardwareMonitor)

System Info Dashboard has an **optional** temperature line on the main dashboard.

By default, if no temperature data is available, it will show a message like:

> `N/A (LibreHardwareMonitor)`

If you want temperature support:

1. Download **LibreHardwareMonitor**:  
   https://github.com/LibreHardwareMonitor/LibreHardwareMonitor

2. Place `LibreHardwareMonitor.exe` in the same folder as `System Info Dashboard.exe`.

3. (Advanced / optional) Configure LibreHardwareMonitor and/or a small helper to write a simple file named `lhm_temps.txt` in the same folder, for example:

   ```text
   CPU=45
   DISK=33
   ```

4. When `lhm_temps.txt` exists and contains valid values, System Info Dashboard will read it and display CPU / disk temperatures.  
   If the file is missing or invalid, the app will simply show “N/A” and you can open LibreHardwareMonitor from the menu to see full sensor details.

Temperatures are treated as an extra convenience, not a guaranteed built-in feature.

---

## Usage

1. Run `System Info Dashboard.exe`.
2. Use the **main window** to see overall system status.
3. From the menu:
   - **Main → Process Monitor…** to inspect and manage processes.
   - **Main → Network Details…** for WMI-based network information.
   - **Main → System Information…** for WMI-based OS & hardware details.
   - **Main → Export TXT/HTML report** to save a quick system report.
   - **Windows Tools** for quick access to built-in Windows utilities.
   - **Help → Open Help…** opens `HELP.txt`.
   - **Help → About System Info Dashboard** shows version, author and links.

When minimized, the app can hide to the tray so it stays out of the way.

---

## Security & Antivirus notes

**System Info Dashboard:**

- is written in **AutoIt**
- uses WMI and process APIs to read system information
- can terminate processes via the Process Monitor

Because of these behaviours, some antivirus engines may flag the EXE as **“suspicious” or “generic”**, even if it is clean. These are common false positives for utilities written in AutoIt.

The project is **open source**, so you can:

- review the source code
- build your own binary from the `.au3` script
- verify the hashes (MD5 / SHA256) of the downloaded ZIP/EXE against the values published on the release page

Only whitelist the program in your antivirus if you trust the source and have verified the binary.

---

## Build from source

1. Install:
   - [AutoIt](https://www.autoitscript.com/site/autoit/)
   - SciTE + AutoIt3Wrapper (usually part of the full AutoIt install)
2. Clone or download this repository.
3. Open `info.au3` in SciTE.
4. Go to **Tools → Build** to create the EXE with:
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
