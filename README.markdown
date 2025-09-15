# Debian Battery Check Service

This repository contains a shell script and systemd service to monitor battery levels on a Debian 13 system. If the battery level drops to 20% or below and no external power source is connected, the system will enter suspend mode.

## Features
- Checks battery level and power status every minute.
- Automatically suspends the system if the battery is at or below 20% and not charging.
- Installs a systemd service for persistent operation.
- Checks for existing files to avoid overwriting.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/lmdeuser/debian-battery-check.git
   cd debian-battery-check
   ```
2. Make the installation script executable:
   ```bash
   chmod +x install_battery_check.sh
   ```
3. Run the installation script with root privileges:
   ```bash
   sudo ./install_battery_check.sh
   ```

## Files
- `install_battery_check.sh`: Installs the battery check script and systemd service.
- `battery_check.sh`: Monitors battery level and triggers suspend if needed (installed to `/usr/local/sbin/`).
- `batterycheck.service`: Systemd service file (installed to `/etc/systemd/system/`).

## Requirements
- Debian 13
- Root privileges for installation
- A system with a battery (access to `/sys/class/power_supply/BAT0`)

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author
Dmitriy Volkov (lmdeuser)