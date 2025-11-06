
LOGFILE="$HOME/system_health.log"

{
	echo "-----------------------------------------"
	echo "      SYSTEM HEALTH MONITORING REPORT"
	echo " Date & Time: $(date)"
	echo "----------------------------------------"
	echo ""
	echo " CPU usage:"
	top -bn1 | grep "Cpu(s)" || echo "Error running top"
	echo ""
	echo " Memory usage:"
	free -h || echo "Error running free"
	echo ""
	echo " Disk usage:"
	df -h --output=source,size,used,avail,target | sed -n '1,6p'
	echo ""
	echo "Network Status:"
	if command -v nmcli >/dev/null 2>&1; then
		nmclli device status
	else
	        ip -brief addr
	fi
        echo ""
	echo "Top 5 CPU - consuming processes:"
	ps aux --sort=-%cpu | head -n 6
	echo ""
	echo "Top 5 Memory consuming processes:"
	ps aux --sort=-%mem |head -n 6
	echo ""
	echo " System Uptime:"
	uptime -p
	echo ""
	echo "-----------------------------------------"
	eco ""
} | tee -a "$LOGFILE"	
