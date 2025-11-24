#!/bin/bash
#
# Check if cron service is running (Ubuntu/Debian or RHEL/CentOS/Oracle)
#

# Detect OS
if grep -qi "ubuntu\|debian" /etc/os-release; then
    SERVICE="cron"
elif grep -qi "rhel\|centos\|almalinux\|rocky\|oracle\|ol" /etc/os-release; then
    SERVICE="crond"
else
    echo "Unsupported OS"
    exit 1
fi

# Get the line containing 'Active:'
status_line=$(systemctl status "$SERVICE" | grep "Active:")

# Check if the status contains 'active (running)'
if echo "$status_line" | grep -q "active (running)"; then
    echo "OK"
else
    echo "FAILED"
fi
