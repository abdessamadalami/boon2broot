#!/bin/bash
wall "	#Architecture: $(uname -a)
	#CPU physical: $(cat /proc/cpuinfo | grep "physical id" | cut -d: -f2 | wc -l)
	#vCPU : $(nproc --all)
	$(free -m | awk NR==2'{printf "#Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
	$(df -h | awk NR==4'{printf "#Disk Usage: %d/%dGB (%s) \n", $3,$2,$5 }')
	$(top -bn1 | grep "Cpu(s)" | tr -d ',ni' | awk '{printf"#CPU load: %.1f%% \n", 100 - $7}')
	$(who -b | sed 's/         system boot /#Last boot:/ig')
  #LVM use: $(lsblk | grep lvm | awk '{if ($1) {print "yes";exit;} else {print "no"} }')
	#Connexions TCP :$(netstat -an | grep ESTABLISHED |  wc -l) ESTABLISHED
	#User log: $(who | cut -d " " -f 1 | sort -u | wc -l)
	`printf "#Network: IP %s (%s)\n" "$(ip route list | grep link | awk '{print $NF}')" "$(ip link | grep "link/ether" | tr -s ' ' | cut -d ' ' -f3)"`
	`printf "#Sudo : %d cmd" "$(cat /var/log/sudo/sudo.log| grep -a COMMAND | wc -l)"`
	"
