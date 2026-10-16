#!/bin/bash
# sysinfo.sh - prints a basic system information report

echo "=========================================="
echo "         SYSTEM INFORMATION REPORT        "
echo "=========================================="
echo "Generated : $(date)"
echo

echo "--- Hostname ---"
hostname

echo
echo "--- Operating System / Kernel ---"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "OS      : ${PRETTY_NAME:-Unknown}"
else
    echo "OS      : Unknown"
fi
echo "Kernel  : $(uname -r)"
echo "Arch    : $(uname -m)"
echo "Uptime  : $(uptime -p 2>/dev/null || uptime)"

echo
echo "--- Memory Usage ---"
if command -v free >/dev/null 2>&1; then
    free -h
else
    echo "free command not available"
fi

echo
echo "--- Disk Usage ---"
df -h

echo
echo "--- Logged-in Users ---"
who

echo
echo "=========================================="
echo "              END OF REPORT               "
echo "=========================================="
