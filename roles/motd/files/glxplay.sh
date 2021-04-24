#!/bin/sh
# Text Color Variables http://misc.flogisoft.com/bash/tip_colors_and_formatting
tcLtG="\033[00;37m"    # LIGHT GRAY
tcDkG="\033[01;30m"    # DARK GRAY
tcLtR="\033[01;31m"    # LIGHT RED
tcLtGRN="\033[01;32m"  # LIGHT GREEN
tcLtBL="\033[01;34m"   # LIGHT BLUE
tcLtP="\033[01;35m"    # LIGHT PURPLE
tcLtC="\033[01;36m"    # LIGHT CYAN
tcW="\033[01;37m"      # WHITE
tcRESET="\033[0m"
tcORANGE="\033[38;5;209m"
#
# Time of day
HOUR=$(date +"%H")
if [ $HOUR -lt 12  -a $HOUR -ge 0 ]; then TIME="morning"
elif [ $HOUR -lt 17 -a $HOUR -ge 12 ]; then TIME="afternoon"
else TIME="evening"
fi
#
# System uptime
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
#
# System + Memory
SYS_LOADS=`cat /proc/loadavg | awk '{print $1}'`
MEMORY_TOTAL=`free -h | grep Mem | awk '{print $2}'`
MEMORY_USED=`free -h | grep Mem | awk '{print $3}'`
NUM_PROCS=`ps aux | wc -l`
#NUM_CPU = `getconf _NPROCESSORS_ONLN`
IPADDRESS=`hostname --all-ip-addresses`
RELEASE=`cat /etc/redhat-release`
#
echo -e $tcLtGRN "================================================================"
echo -e $tcW " Good $TIME, `whoami` !      $tcORANGE by GLXPlay System Infrastructure"
echo -e $tcLtGRN "================================================================"
echo -e $tcW " - Time            : `date +"%A, %e %B %Y, %r"`"
echo -e $tcW " - Hostname        : `hostname -f`"
echo -e $tcW " - IP Address      : $IPADDRESS"
echo -e $tcW " - OS Release      : $RELEASE"
echo -e $tcW " - Kernel          : `uname -a | awk '{print $1" "$3" "$12}'`"
echo -e $tcW " - Users           : Currently `users | wc -w` user(s) logged on"
echo -e $tcW " - System load     : $SYS_LOADS"
echo -e $tcW " - Processor Cores : $(getconf _NPROCESSORS_ONLN)"
echo -e $tcW " - Memory used %   : $MEMORY_USED/$MEMORY_TOTAL"
echo -e $tcW " - Process running : $NUM_PROCS processes running"
echo -e $tcW " - System uptime   : $upDays days $upHours hours $upMins minutes"
echo -e $tcLtGRN "================================================================"
echo -e $tcRESET ""
#
