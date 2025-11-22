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

# System Information Dashboard

System Information Dashboard is a lightweight, portable Windows utility that shows you the essentials at a glance:  
**CPU load, RAM usage, disk usage, OS details, and system uptime** in a clean, single window.

It’s built for technicians and power users who want quick diagnostics without the bloat of full monitoring suites.

---

## Features

- **CPU overview**
  - Current CPU usage
  - Basic processor information

- **Memory usage**
  - Used vs available RAM
  - Ideal for quick “is this RAM-starved?” checks

- **Disk usage**
  - Usage percentage of the main drive
  - Helps spot systems running dangerously low on space

- **OS & system info**
  - Windows version, build, architecture
  - System uptime (how long the machine has been running)

- **Portable by design**
  - Single `.exe` – no installer
  - No services, no scheduled tasks, no junk left behind

- **Technician-friendly**
  - Perfect for USB sticks and on-site work
  - Simple enough for non-technical users to run and read back basic numbers

- **LibreHardwareMonitor integration**
  - Menu entry to open **LibreHardwareMonitor** for advanced temperatures and sensor data  
    (CPU/GPU temps, fan speeds, voltages, etc.)

---

## Screenshots

*(Add your screenshots here once you have them, for example:)*

- Main dashboard view  
- Tools menu with “Open LibreHardwareMonitor” entry  

```text
[ screenshot placeholder ]

Downloads

You can find the latest release here:

👉 Download System Information Dashboard

Just download the .zip, extract it, and run:

SystemInformationDashboard.exe

Optional (for temperatures and sensors):

Place LibreHardwareMonitor.exe in the same folder if you want one-click access to full hardware sensor details.

Usage

Run the EXE

Double-click SystemInformationDashboard.exe.
No installation, no UAC wizard, nothing fancy.

Read the essentials

The main window shows:

CPU usage

RAM usage

Disk usage

OS information

System uptime

Export a report (if available in your version)

Use the menu option to export a simple system report.
You can save it to a file and attach it to a support ticket, email, or your own notes.

Open LibreHardwareMonitor (optional)

If LibreHardwareMonitor.exe is in the same folder:

Open the Tools menu

Click “Open LibreHardwareMonitor (temperatures & sensors)”

That launches LibreHardwareMonitor for detailed temps and hardware sensors.

LibreHardwareMonitor Integration

System Information Dashboard focuses on being lightweight and fast.
Instead of reinventing full sensor monitoring, it works alongside LibreHardwareMonitor:

SID: quick overview (CPU, RAM, disk, OS, uptime)

LibreHardwareMonitor: deep-dive sensors (temps, fans, voltages, etc.)

How it works in practice:

You download LibreHardwareMonitor separately

Place LibreHardwareMonitor.exe next to SystemInformationDashboard.exe

Use the Tools menu in SID to launch it when you need more detail

If LibreHardwareMonitor isn’t present, SID still works normally—only the menu entry will show a warning instead of launching it.

Requirements

OS: Windows (tested on modern versions of Windows 10/11)

Architecture: x64 recommended

Permissions: Standard user is usually enough

Optional: LibreHardwareMonitor for advanced temperature and sensor details

Security Notes

No installer, no drivers, no kernel tricks

No telemetry, no analytics, no background services

All data is gathered locally using standard Windows APIs

Roadmap / Ideas

Planned / possible future improvements:

Slightly richer reports

Extra basic health checks (e.g. simple security/firewall indicators)

Minor UI tweaks and polish

Feedback from real use is what drives changes, so if you have ideas, open an issue.

Contributing

If you:

Found a bug

Have a suggestion

Want to help clean up or improve the code

…feel free to open an Issue or a Pull Request.

License

(Choose what you want here, for example:)

This project is licensed under the MIT License – see the LICENSE file for details.

Contact

If you’re using System Information Dashboard in your daily work and have feedback, feel free to open an issue on GitHub or reach out through the project page.