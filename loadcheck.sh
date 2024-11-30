#!/bin/bash

# Add this line in crontab */1 * * * * /root/script/loadcheck.sh >> /root/script/output_file.log 2>&1

# Date and time
echo "===== $(date '+%Y-%m-%d %H:%M:%S') ====="

# Top 5 CPU-consuming processes
echo "Top 5 CPU-consuming processes:"
ps -eo pid,user,comm,%cpu --sort=-%cpu | head -n 6 | tail -n 5 | while read PID USER COMM CPU; do
    CMD_PATH=$(readlink -f /proc/$PID/exe 2>/dev/null || echo "N/A")
    echo "PID: $PID | USER: $USER | CPU: $CPU% | PATH: $CMD_PATH"
done

# Top 5 Memory-consuming processes
echo "Top 5 Memory-consuming processes:"
ps -eo pid,user,comm,%mem --sort=-%mem | head -n 6 | tail -n 5 | while read PID USER COMM MEM; do
    CMD_PATH=$(readlink -f /proc/$PID/exe 2>/dev/null || echo "N/A")
    echo "PID: $PID | USER: $USER | MEM: $MEM% | PATH: $CMD_PATH"
done

# Get the first three columns from /proc/loadavg
LOAD_AVG=$(cat /proc/loadavg | awk '{print $1, $2, $3}')

# Print the filtered load average
echo "Load Averages (1 min, 5 min, 15 min): $LOAD_AVG"

echo "-------------------------------------------"

