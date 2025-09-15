Debian Battery Check Service
This repository contains a shell script and systemd service to monitor battery levels on a Debian 13 system. If the battery level drops to 20% or below and no external power source is connected, the system will enter suspend mode.
Features

Checks battery level and power status every minute.
Automatically suspends the system if the battery is at or below 20% and not charging.
Installs a systemd service for persistent operation.
Checks for existing files to avoid overwriting.

Installation

Clone the repository:git clone https://github.com/lmdeuser/debian-battery-check.git
cd debian-battery-check


Make the installation script executable:chmod +x install_battery_check.sh


Run the installation script with root privileges:sudo ./install_battery_check.sh



Important: Before installation, verify the battery path /sys/class/power_supply/BAT0. This path may vary depending on your laptop model (e.g., BAT1 or another identifier). Check the correct path by listing the directories in /sys/class/power_supply/ (e.g., ls /sys/class/power_supply/). If the path differs, manually update the battery_check.sh script (in /usr/local/sbin/) to use the correct path before running the service.
Files

install_battery_check.sh: Installs the battery check script and systemd service.
battery_check.sh: Monitors battery level and triggers suspend if needed (installed to /usr/local/sbin/).
batterycheck.service: Systemd service file (installed to /etc/systemd/system/).

Requirements

Debian 13
Root privileges for installation
A system with a battery (access to /sys/class/power_supply/BAT*)

License
This project is licensed under the MIT License. See the LICENSE file for details.
Author
Dmitriy Volkov (lmdeuser)
