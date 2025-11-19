# System Information Dashboard

System Information Dashboard is a lightweight Windows utility that gives you a clear, real-time view of your PC’s health and system details.

From a single window you can monitor CPU usage, RAM usage, disk space, system uptime, and basic OS information – without digging through multiple Windows menus.

[![Latest release](https://img.shields.io/github/v/release/gexos/SystemInformationDashboard)](https://github.com/gexos/SystemInformationDashboard/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/gexos/SystemInformationDashboard/total)](https://github.com/gexos/SystemInformationDashboard/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](#license)

---

## Features

- **Live CPU usage**
  - See how busy your processor is in real time.

- **RAM (memory) usage**
  - Check how much memory is in use and how much is available.

- **Disk usage overview**
  - View used and free space on your drives to quickly spot full disks.

- **System uptime**
  - See how long the system has been running since the last reboot.

- **OS & system information**
  - Basic details about Windows version and system info in one place.

- **Report export**
  - Export the system information to a **TXT** or **HTML** report for documentation or support purposes.

- **Portable & lightweight**
  - Single executable, no installation, no services, no bloat.

---

## Installation

System Information Dashboard is portable – there is no installer.

1. **Download the EXE**
   - From the **GitHub Releases** page:  
     [`SystemInformationDashboard.exe`](https://github.com/Gexos/System-Info-Dashboard/releases)
   - Or from the official website: [gexsoft.org](https://gexsoft.org/systeminfodashboard.html) (System Information Dashboard page).

2. **Place it wherever you like**
   - For example: `C:\Tools\SystemInformationDashboard\`
   - Or on a USB stick with your technician tools.

3. **Run the application**
   - Double-click `SystemInformationDashboard.exe`.
   - No installation steps, no extra dependencies required on a standard Windows system.

> Tip: You can create a desktop shortcut or pin it to the taskbar for quick access.

---

## Usage

1. **Start the app**
   - Run `SystemInformationDashboard.exe`.
   - The main dashboard window will appear.

2. **Read the main system overview**
   - CPU usage bar/values show how busy your processor is.
   - RAM usage shows used vs available memory.
   - Disk section shows used/free space on your drives.
   - Uptime shows how long the system has been running.
   - OS info shows the Windows version and basic system details.

3. **Refresh information**
   - Use the **Refresh** button (or automatic refresh interval, if enabled) to update the displayed values.

4. **Export a report**
   - Use the **menu** (for example: `File` → `Save Report`) or the **Export** buttons:
     - **Export to TXT** – saves a plain text report.
     - **Export to HTML** – saves a formatted HTML report.
   - Choose where to save the file when prompted.
   - You can then send this report to a technician, attach it to a ticket, or keep it for your own documentation.

5. **Exit the app**
   - Close the window normally, or use the menu entry (for example: `File` → `Exit`).

---

## Screenshots

### Main Window

![System Information Dashboard – Main Window](screenshots/system-info-dashboard-main.png)

### HTML Report Example

![System Information Dashboard – HTML Report](screenshots/system-info-dashboard-report.png)

---

## System Requirements

- **OS:** Windows (tested on modern Windows versions)
- **Installation:** Not required (portable EXE)
- **Permissions:** Standard user account is usually enough for basic information

---

## Technical details

- **Language:** Written in **AutoIt**.
- **Build:** Compiled as a single **portable `.exe`** (no external DLLs or runtime installers required).
- **Installation footprint:**  
  - Does **not** require an installer.  
  - Does **not** modify system files.  
  - Does **not** add services or scheduled tasks.
- **Registry usage:**  
  - Does **not** rely on permanent registry entries for normal operation.  
  - No configuration is required in the registry.
- **Config & logs (if enabled):**  
  - Any configuration or log files (e.g. reports) are stored in the same folder as the executable or in a user-selected location.
- **Data access:**  
  - Uses standard Windows APIs/WMI/Performance counters to read system information.  
  - Read-only access – it **only reads** system metrics, it does not change system settings.
- **Portability:**  
  - Can be run from a local disk, external drive, or USB stick.  
  - Suitable for inclusion in a technician’s portable tools kit.

---

## License

This project is licensed under the **MIT License** – you’re free to use, modify and distribute it, as long as the license file is included.

See the [`LICENSE`](LICENSE) file for details.
