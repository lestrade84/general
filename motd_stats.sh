#!/bin/bash
#
# Server Status Script
# Version 1.0
# Updated: Nov 3rd 2015

CPUTIME=$(ps -eo pcpu | awk 'NR>1' | awk '{tot=tot+$1} END {print tot}')
CPUCORES=$(cat /proc/cpuinfo | grep -c processor)
UP=$(echo `uptime` | awk '{ print $3 " " $4 }')
echo "
System Status
Updated: `date`

- Server Name               = `hostname`
- Public IP                 = `dig +short myip.opendns.com @resolver1.opendns.com`
- OS Version                = `cat /etc/redhat-release`
- Load Averages             = `cat /proc/loadavg`
- System Uptime             = `echo $UP`
- Platform Data             = `uname -orpi`
- CPU Usage (average)       = `echo $CPUTIME / $CPUCORES | bc`%
- Memory free               = `free -m | head -n 2 | tail -n 1 | awk {'print $4'}` MB
- Memory cached             = `free -m | head -n 2 | tail -n 1 | awk {'print $6'}` MB
- Swap in use               = `free -m | tail -n 1 | awk {'print $3'}` MB
- Disk Space Used           = `df -h / | awk '{ a = $5 } END { print a }'`
" > /etc/motd