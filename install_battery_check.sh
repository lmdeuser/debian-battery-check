#!/bin/bash

# Exit on any error
set -e

# Define paths for the files
SCRIPT_PATH="/usr/local/sbin/battery_check.sh"
SERVICE_PATH="/etc/systemd/system/batterycheck.service"

# Check if both files already exist
if [ -f "$SCRIPT_PATH" ] && [ -f "$SERVICE_PATH" ]; then
    echo "Files already exist:"
    echo "Script: $SCRIPT_PATH"
    echo "Service: $SERVICE_PATH"
    exit 0
fi

# Create battery_check.sh
cat << 'EOF' > $SCRIPT_PATH
#!/bin/bash
# Function to check battery level and power status
check_battery() {
    # Get the current battery level
    battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
    # Get the power supply status (Charging/Discharging/Not charging)
    power_status=$(cat /sys/class/power_supply/BAT0/status)

    # Check if battery level is 20% or lower and no external power is connected
    if [ "$battery_level" -le 20 ] && [ "$power_status" != "Charging" ]; then
        echo "Battery level is $battery_level%. No external power connected. Entering suspend..."
        systemctl suspend -i
    else
        if [ "$power_status" == "Charging" ]; then
            echo "Battery level is $battery_level%. External power connected. Suspend not required."
        else
            echo "Battery level is $battery_level%. Everything is fine."
        fi
    fi
}

# Infinite loop to check battery level every minute
while true; do
    check_battery
    sleep 60
done
EOF

# Set permissions for the script
chmod +x $SCRIPT_PATH
chown root:root $SCRIPT_PATH

# Create batterycheck.service
cat << 'EOF' > $SERVICE_PATH
[Unit]
Description=Battery check
After=default.target

[Service]
User=root
ExecStart=/bin/bash '/usr/local/sbin/battery_check.sh'
Restart=on-failure
Type=simple

[Install]
WantedBy=default.target
EOF

# Set permissions for the service file
chmod 644 $SERVICE_PATH
chown root:root $SERVICE_PATH

# Reload systemd, enable and start the service
systemctl daemon-reload
systemctl enable batterycheck.service
systemctl start batterycheck.service

echo "Battery check service installed and started successfully."