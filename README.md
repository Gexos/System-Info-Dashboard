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

**System Information Dashboard (SID)** is a lightweight, portable Windows utility that shows you the essentials at a glance:

- CPU load  
- RAM usage  
- Disk usage  
- OS details  
- System uptime  

It’s built for technicians and power users who want quick diagnostics without the bloat of full monitoring suites.  
For advanced temperatures and sensors, SID can open **LibreHardwareMonitor** directly from the Tools menu.

---

## Features

- **CPU overview**
  - Current CPU usage
  - Basic processor information

- **Memory usage**
  - Used vs available RAM
  - Great for quick “is this RAM-starved?” checks

- **Disk usage**
  - Usage percentage of the main drive
  - Helps spot systems running low on storage

- **OS & system info**
  - Windows version, build, architecture
  - System uptime (how long the machine has been running)

- **Portable**
  - Single `.exe`  
  - No installer, no services, no scheduled tasks

- **Technician-friendly**
  - Ideal for USB sticks and on-site work
  - Simple enough for non-technical users to run and read basic values

- **LibreHardwareMonitor integration**
  - Menu entry to open **LibreHardwareMonitor** for advanced hardware sensors:
    - CPU / GPU temperatures  
    - HDD / SSD / NVMe temps  
    - Fans, voltages, and more (depending on hardware)

---

## Screenshots

_Add screenshots here when available, for example:_

- Main dashboard view  
- Tools menu with “Open LibreHardwareMonitor (temperatures & sensors)”  

```text
[ screenshot placeholder ]
```

---

## Downloads

Get the latest release from GitHub Releases:

- 👉 **[Download System Information Dashboard](https://github.com/your-user/your-repo/releases)**  
  _(Replace this link with your actual repository URL.)_

Steps:

1. Download the latest `.zip` from the Releases page.
2. Extract it to a folder of your choice.
3. Run `SystemInformationDashboard.exe`.

Optional (for advanced temperatures and sensors):

- Download **LibreHardwareMonitor** from its official project page.
- Place `LibreHardwareMonitor.exe` in the **same folder** as `SystemInformationDashboard.exe`.

---

## Usage

1. **Run the app**

   Double-click `SystemInformationDashboard.exe`.  
   No installation required.

2. **View system overview**

   The main window shows:

   - CPU usage  
   - RAM usage  
   - Disk usage  
   - OS details  
   - System uptime  

3. **Export a report** (if available in your version)

   Use the menu option to export a simple system report.  
   You can save it and attach it to emails, tickets, or your documentation.

4. **Open LibreHardwareMonitor (optional)**

   If `LibreHardwareMonitor.exe` is in the same folder:

   - Go to the **Tools** menu  
   - Click **“Open LibreHardwareMonitor (temperatures & sensors)”**

   This launches LibreHardwareMonitor for full sensor details:
   CPU/GPU temps, drive temps, fan speeds, voltages, etc.

---

## LibreHardwareMonitor Integration

System Information Dashboard focuses on being small and fast.  
Instead of re-implementing full hardware sensor support, it works together with **LibreHardwareMonitor**:

- **SID:** quick overview (CPU, RAM, disk, OS, uptime)  
- **LibreHardwareMonitor:** detailed sensors (temps, fans, voltages, more)

**How it works:**

1. You download LibreHardwareMonitor separately.  
2. Place `LibreHardwareMonitor.exe` next to `SystemInformationDashboard.exe`.  
3. Use the Tools menu in SID to open it with a single click.

If LibreHardwareMonitor isn’t present, SID still works normally. Only the “Open LibreHardwareMonitor” action will show a warning instead of launching it.

---

## Requirements

- **OS:** Windows (tested on modern Windows 10/11)  
- **Architecture:** x64 recommended  
- **Permissions:** Standard user is usually enough  
- **Optional:** LibreHardwareMonitor for advanced sensor details

---

## Security Notes

- No installer, no drivers, no kernel tricks  
- No telemetry, no analytics, no background services  
- System information is collected using standard Windows APIs  
- Everything runs locally on your machine

---

## Roadmap / Planned Ideas

Some planned / possible improvements:

- Slightly richer report exports  
- Additional basic health checks (e.g. simple security/firewall indicators)  
- Minor UI polish and quality-of-life tweaks

If you have suggestions or feature requests, feel free to open an issue.

---

## Contributing

Contributions and feedback are welcome.

You can:

- Open an **Issue** for bugs or feature requests  
- Open a **Pull Request** with code improvements or fixes  

Please keep changes focused and documented in the PR description.

---

## License

This project is licensed under the **MIT License**.  
See the [`LICENSE`](LICENSE) file for details.

---

## Contact

If you use System Information Dashboard and have feedback, ideas, or issues:

- Open an issue on GitHub in this repository  
- Or reach out via the project’s homepage / contact info linked in the repo description
