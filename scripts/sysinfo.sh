#!/bin/bash
# sysinfo.sh - prints a system information report and writes it to logs/

LOGDIR="$(dirname "$0")/../logs"
LOGFILE="$LOGDIR/sysinfo-$(date +%Y%m%d-%H%M%S).log"

mkdir -p "$LOGDIR"

# Print to screen AND append to the log file
report() {
    echo "$@" | tee -a "$LOGFILE"
}

{
    report "=========================================="
    report "         SYSTEM INFORMATION REPORT        "
    report "=========================================="
    report "Generated : $(date)"
    report

    report "--- Hostname ---"
    report "$(hostname)"

    report
    report "--- Operating System / Kernel ---"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        report "OS      : ${PRETTY_NAME:-Unknown}"
    else
        report "OS      : Unknown"
    fi
    report "Kernel  : $(uname -r)"
    report "Arch    : $(uname -m)"

    report
    report "--- Uptime ---"
    report "Uptime  : $(uptime -p 2>/dev/null || uptime)"

    report
    report "--- CPU Load ---"
    report "Load avg: $(cat /proc/loadavg 2>/dev/null || uptime)"
    report "CPU cores: $(nproc 2>/dev/null || echo unknown)"

    report
    report "--- Memory Usage ---"
    if command -v free >/dev/null 2>&1; then
        free -h | tee -a "$LOGFILE"
    else
        report "free command not available"
    fi

    report
    report "--- Disk Usage ---"
    df -h | tee -a "$LOGFILE"

    report
    report "--- Logged-in Users ---"
    report "$(who)"

    report
    report "=========================================="
    report "              END OF REPORT               "
    report "=========================================="
} 2>&1

echo
echo "Report written to: $LOGFILE"

