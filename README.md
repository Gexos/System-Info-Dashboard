# System Info Dashboard

**System Info Dashboard** is a lightweight system monitoring and diagnostics tool for Windows, written in [AutoIt](https://www.autoitscript.com/).

It gives you a real-time view of:

- CPU usage and temperature  
- RAM usage (percent and MB)  
- Disk usage for all fixed drives  
- Network status and basic diagnostics  
- System & hardware information  
- Running processes, with options to kill/force-kill them  

> Open source project by **gexos (Giorgos Xanthopoulos)**

---

## Features

### Main Dashboard

- Live **CPU usage** via WMI, with color-coded load (green → orange → red).
- **CPU temperature** (when sensors are available):
  - Uses **LibreHardwareMonitor** WMI if available.
  - Falls back to **OpenHardwareMonitor** WMI if available.
  - Optionally falls back to ACPI (`MSAcpi_ThermalZoneTemperature`).
- **RAM usage**:
  - Displayed as a percentage.
  - Also shown as **integer MB**: `used MB / total MB`.
- **Disk usage**:
  - Automatically detects all **fixed drives** (C:, D:, etc.).
  - Shows percentage and GB used/total for each drive.
- **System info**:
  - Windows version & architecture.
  - System uptime.
  - Current system time.
- **Battery & power** (on laptops):
  - Battery level.
  - Charging/discharging/AC/critical status.
- Status bar with a compact summary:  
  `CPU: x%   RAM: y%   Processes: N`

---

### Network

- **Network summary** in the main window:
  - Computer name and active IP address.
- **Network Details** window:
  - WMI-based adapter details:
    - Description, MAC address, IP, subnet, gateway, DNS, etc.
- **Network Diagnostics** window:
  - Pings:
    - Default gateway
    - Google DNS (`8.8.8.8`)
    - `www.gexos.org`
  - Helps quickly identify whether the issue is local, DNS-related, or an overall connectivity problem.

---

### System & Hardware Information

- **System Information** window:
  - OS caption, version, build number.
  - Install date and last boot time.
  - Manufacturer and model.
  - Total physical RAM.
  - Physical and logical CPU counts.
- **Hardware Panel**:
  - CPU details (name, cores, threads, max clock).
  - GPU / video controller details (name, VRAM, driver version).
  - Physical disk details (model, interface type, media type, size).

---

### Process Monitor

- Dedicated **Process Monitor** window:
  - Shows process **Name** and **PID**.
- Filter bar:
  - Filter by process name (e.g. `chrome`, `notepad`, `steam`).
- Context menu actions:
  - **Refresh**
  - **Kill Process** (standard `ProcessClose`).
  - **Force Kill** (`taskkill /F`).
  - **End Process Tree** (`taskkill /T /F`).
- Export options:
  - Export the process list to **TXT** or **CSV**.
- UX details:
  - Hover tooltip showing `ProcessName (PID 1234)` over each row.
  - Option to show/hide system processes (PID 0 and 4) via Settings.

> ⚠️ Killing processes can cause system instability or data loss. Use these features carefully.

---

### Logging & Support

- Log file stored at:

  ```text
  %TEMP%\SystemInfoDashboard\SystemInfoDashboard.log
  
Built-in View Log window for quick inspection.

Support Bundle Export:

Creates a folder on your Desktop with:

System report (TXT)

JSON snapshot

Network details

Application log

This makes it easy to share diagnostic information when troubleshooting issues.

### Quality-of-Life Features

Tray icon + minimize to tray:

The main window can be hidden to the tray and restored from there.

Settings window:

Refresh interval (milliseconds).

Show/hide system processes in the Process Monitor.

Start minimized to tray.

Run at Windows startup (via HKCU Run key).

Export options:

Text report (TXT)

HTML report

JSON system snapshot

Performance history CSV (CPU% and RAM% over time)

Requirements

Windows 10 or later (32-bit or 64-bit).

WMI enabled and functioning.

To build from source:

AutoIt

Optional (recommended for temperature readings):

LibreHardwareMonitor
Used as a sensor backend for CPU temperature via WMI.

### Downloads
Source code
GitHub: https://github.com/Gexos/System-Info-Dashboard

Windows binary (.exe)

GitHub Releases: https://github.com/Gexos/System-Info-Dashboard/releases

Or direct download from: https://gexsoft.org/systeminfodashboard.html

### Installation

The application is portable:

It does not require installation.

It does not modify your system, except:

An optional autostart key under
HKCU\Software\Microsoft\Windows\CurrentVersion\Run
(only if you enable “Run at startup” in Settings).

A small .ini configuration file in the same folder as the EXE.

A log file under %TEMP%\SystemInfoDashboard\.


### Temperatures & LibreHardwareMonitor Integration

System Info Dashboard tries to read CPU temperature in the following order:

LibreHardwareMonitor (WMI namespace root\LibreHardwareMonitor, Sensor class)

OpenHardwareMonitor (WMI namespace root\OpenHardwareMonitor, Sensor class)

ACPI fallback (via MSAcpi_ThermalZoneTemperature), if available

If none of these sources are accessible or supported by your hardware/BIOS, CPU temperature will be displayed as N/A.

How to enable LibreHardwareMonitor

Download the latest LibreHardwareMonitor portable ZIP from its official GitHub repository.

Extract LibreHardwareMonitor.exe into the same folder as SystemInfoDashboard.exe.

Start System Info Dashboard.

When the app needs temperature values:

It checks whether LibreHardwareMonitor.exe is running.

If not, it tries to start it (minimized) from the same folder.

Once LibreHardwareMonitor is running and its WMI provider is active:

The app queries root\LibreHardwareMonitor for Sensor instances with SensorType = 'Temperature'.

It looks for sensors whose Name contains "CPU" (e.g. CPU Package, CPU Core #1).

The first valid temperature value is used as the CPU temperature.

Some systems (especially certain laptops or OEM configurations) do not expose CPU temperature sensors to WMI at all. In those cases, CPU temperature will remain N/A regardless of LibreHardwareMonitor.

### Security & Verification

System Info Dashboard is intended to be transparent and safe, especially for users who care about what runs on their machine.

What the app does not do

No telemetry:
It does not send any data to remote servers or third-party services.

No hidden installation:
It does not install services, drivers, or hidden background components.

No unsolicited registry changes:
It only writes:
An optional startup entry in HKCU\Software\Microsoft\Windows\CurrentVersion\Run (if enabled in Settings).

A configuration .ini file next to the EXE.

A log file under %TEMP%\SystemInfoDashboard\.

All other access is read-only via Windows APIs and WMI.