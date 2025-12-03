# System Info Dashboard

![AutoIt](https://img.shields.io/badge/built%20with-AutoIt-1abc9c)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Version](https://img.shields.io/badge/version-5.0.1-orange)

# System Info Dashboard (Windows) – v5.0.1

System Info Dashboard is a small, portable system monitor for Windows.

It shows CPU/RAM/disk usage, uptime, OS details, network info, basic security status, and optional temperatures (via LibreHardwareMonitor). It also includes a simple process monitor and shortcuts to common Windows tools.

---

## Features

- **Main dashboard**
  - CPU usage (via WMI)
  - RAM usage (used / total, in MB and %)
  - Disk usage per fixed drive
  - System uptime
  - Current date/time
  - Network summary (hostname + IP)
  - Basic security status:
    - Antivirus product (from Windows Security Center)
    - Windows Firewall state
    - Windows Update service state
  - Optional temperatures from LibreHardwareMonitor (`lhm_temps.txt`)

- **Process Monitor window**
  - List running processes with:
    - Name
    - PID
    - Approx. memory usage (MB)
  - Simple text filter (type part of the name)
  - Button to kill the selected process
    - Uses AutoIt's `ProcessClose` first
    - Falls back to `taskkill /F` if needed

- **Network Details window**
  - Uses WMI (`Win32_NetworkAdapterConfiguration`) to show:
    - Description
    - MAC address
    - IP address
    - Subnet
    - Gateway
    - DNS server(s)

- **System Information window**
  - Operating system details:
    - Caption
    - Version
    - Build
    - Install date
    - Last boot time
  - Computer system details:
    - Manufacturer
    - Model
    - Total physical memory
    - Number of physical CPUs
    - Number of logical processors

- **Other goodies**
  - Export a **TXT** or **HTML** report of the main dashboard
  - Dark theme toggle
  - Tray icon with “show/hide” behavior
  - Help + About windows
  - Shortcuts to common Windows tools:
    - Task Manager
    - Device Manager
    - Event Viewer
    - Services
    - Disk Management
    - System Information (msinfo32)
    - Command Prompt

---

## Downloads

You can download pre-built binaries from the **Releases** page:

- GitHub Releases: https://github.com/Gexos/System-Info-Dashboard/releases

Look for the latest version (currently **v5.0.1**) and grab the `.exe` file.

The app is:

- **Portable** (no installer, no drivers)
- **User-mode only** (no kernel hooks)
- Designed for **Windows 10/11**

If you prefer, you can also clone the repo and build your own executable from the source code using AutoIt.

---

## Requirements

- Windows 10 or Windows 11
- No extra dependencies for the main features
- Optional: LibreHardwareMonitor if you want temperature readings

To build from source, you’ll need:

- AutoIt + SciTE4AutoIt3
- The included `.au3` script: `System_Info_Dashboard.au3`

---

## Usage

1. Download the latest `.exe` from the Releases page.
2. Place it in a folder of your choice (e.g. `C:\Tools\SID\`).
3. (Optional) Put `sysinfo.ico` and `logo.png` in the same folder for nicer icons.
4. Run `System_Info_Dashboard.exe`.

The app:

- Shows the main dashboard window.
- Adds a tray icon so you can hide/show the window.
- Refreshes the dashboard every couple of seconds without freezing the UI.

You can:

- Use the **Main** menu to export reports, open the Process/Network/System windows, or exit.
- Use the **Windows Tools** menu to open common admin tools.
- Use the **Help** menu to open the help file or the About window.
- Use **Settings → Toggle Dark Theme** if you want a slightly different background color.

---

## Optional: Temperatures via LibreHardwareMonitor

System Info Dashboard does **not** talk directly to hardware sensors.  
Instead, it can read a simple text file produced by LibreHardwareMonitor.

If you want temperature readings on the main dashboard:

1. Download `LibreHardwareMonitor.exe` and put it next to `System_Info_Dashboard.exe`.
2. (Optional but recommended) Create a file named `lhm_temps.txt` in the same folder with lines like:

   ```text
   CPU=57
   DISK=34
   ```

3. The app will read that file and show:
   - `CPU: 57°C | Disk: 34°C`  
     or whatever values you provide.

If the file is missing or empty, the dashboard will simply show:

```text
N/A (LibreHardwareMonitor)
```

This keeps the app simple and avoids depending directly on specific sensor libraries.

---

## Help file

If there is a `HELP.txt` in the same folder as the EXE:

- **Help → Open Help** will open it in Notepad.

If `HELP.txt` is missing, the app will show a small message telling you where to create it.

---

## Security notes

- The app is **open source**:
  - You can inspect the code in `System_Info_Dashboard.au3`.
  - You can build your own binary with AutoIt.
- No network connections are made by the app itself (beyond standard Windows WMI/COM calls).
- It only uses:
  - WMI queries for system info
  - Standard Windows APIs and tools
- You can verify hashes for any EXE release you download if you like (e.g. with `certutil` on Windows).

Some antivirus products may flag small custom tools like this (especially if built with AutoIt) as suspicious or “generic” detections.  
In most cases this is a **false positive**. Building the binary yourself from the source is a good way to feel comfortable.

---

## Building from source

1. Install AutoIt and SciTE4AutoIt3.
2. Clone the repository:

   ```bash
   git clone https://github.com/Gexos/System-Info-Dashboard.git
   ```

3. Open `System_Info_Dashboard.au3` in SciTE.
4. Make sure `sysinfo.ico` (and optionally `logo.png`) are in the same directory.
5. Use the SciTE “Compile” or “Build” option to produce an `.exe`.

You can also adjust refresh interval, colors, etc. directly in the script if you want to customize it.

---

## Changelog (short)

### v5.0.1 – UI + layout fixes

- Fixed a small UI freeze/stutter when dragging the main window or using the menu.
  - Dashboard refresh no longer runs via `AdlibRegister` while the window is being moved.
  - Now uses a simple timer inside the main loop, so updates happen between GUI events.
- Improved disk usage display:
  - Each fixed drive is shown on its own line.
  - The disk usage label is taller, so text for multiple drives is not collapsed.

### v5.0.0 – Initial public release

- First public release of System Info Dashboard:
  - Main dashboard (CPU, RAM, disk, uptime, OS, time, network, security, temps).
  - Process monitor with filtering and kill support.
  - Network and system info windows (via WMI).
  - Optional temperature support via LibreHardwareMonitor.
  - Tray icon, dark theme toggle, About and Help windows.

---

## License

See the `LICENSE` file in this repository for licensing details.
