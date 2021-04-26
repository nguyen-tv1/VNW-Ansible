#!/bin/bash

PROCCOUNT=`ps -Afl | wc -l`
PROCCOUNT=`expr $PROCCOUNT - 5`
GROUPZ=`groups`

if [[ $GROUPZ == irc ]]; then
ENDSESSION=`cat /etc/security/limits.conf | grep "@irc" | grep maxlogins | awk {'print $4'}`
else
ENDSESSION="Unlimited"
fi

echo -e "
System Status
Updated: `date`
\033[0;35m+++++++++++++++++: \033[0;37mSystem Data\033[0;35m :+++++++++++++++++++
+\033[0;37m  Hostname \033[0;35m= \033[1;32m`hostname -f`
\033[0;35m+  \033[0;37mAddress \033[0;35m= \033[1;32m`hostname -I`
\033[0;35m+  \033[0;37mKernel \033[0;35m= \033[1;32m`uname -r`
\033[0;35m+  \033[0;37mUptime \033[0;35m= \033[1;32m`uptime | sed 's/.*up ([^,]), ./1/'`
\033[0;35m+  \033[0;37mCPU Core \033[0;35m= \033[1;32m$(cat /proc/cpuinfo | grep -c processor)
\033[0;35m+  \033[0;37mMemory \033[0;35m= \033[1;32m$(cat /proc/meminfo | grep MemTotal | awk {'print $2'}) kB
\033[0;35m+  \033[0;37mMemory Free(Cached) \033[0;35m= \033[1;32m`free -m | head -n 2 | tail -n 1 | awk {'print $4'}` Mb
\033[0;35m+  \033[0;37mMemory Free(Physis)\033[0;35m= \033[1;32m`free -m | head -n 3 | tail -n 1 | awk {'print $4'}` Mb
\033[0;35m+  \033[0;37mSwap in use\033[0;35m= \033[1;32m$(free -m | tail -n 1 | awk {'print $3'}) Mb
\033[0;35m+  \033[0;37mDisk Space Available\033[0;35m= \033[1;32m$(df -h / | awk '{ a = $4 } END { print a }')
\033[0;35m++++++++++++++++++: \033[0;37mUser Data\033[0;35m :++++++++++++++++++++
+\033[0;37m  Username \033[0;35m= \033[1;32m`whoami`
\033[0;35m+  \033[0;37mSessions \033[0;35m= \033[1;32m`who | grep $USER | wc -l` of $ENDSESSION MAX
\033[0;35m+  \033[0;37mProcesses \033[0;35m= \033[1;32m$PROCCOUNT of `ulimit -u` MAX
\033[0;35m+++++++++++: \033[0;31mMaintenance Information\033[0;35m :+++++++++++++
+\033[0;31m `cat /etc/motd-maint`
\033[0;35m+++++++++++++++++++++++++++++++++++++++++++++++++++\033[0;37m
" > /etc/motd
