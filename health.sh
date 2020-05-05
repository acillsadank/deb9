#!/bin/bash
#Autoscript Created By Rizwan Arif Firmansyah ( acill.sadank@gmail.com ) ( https://wa.me/6283145968517 )
clear

# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
fi


MYIP=$(wget -qO- ipv4.icanhazip.com)
clear
echo -e "***********************************************************************" | lolcat
echo -e "*                          SERVER HEALTHY                             *" | lolcat
echo -e "***********************************************************************" | lolcat
echo ""
date;
echo "====================================================================" | lolcat
echo ""
echo -e "Server Uptime" | lolcat
echo ""
uptime
echo "====================================================================" | lolcat
echo ""
echo -e "Yang Sedang Login: " | lolcat
echo ""
w
echo "====================================================================" | lolcat
echo ""
echo -e "Terakhir Login: " | lolcat
echo ""
last -a |head -3
echo "====================================================================" | lolcat
echo ""
echo -e "Disk and memory usage: " | lolcat
echo ""
df -h | xargs | awk '{print "Free/total disk: " $11 " / " $9}'
free -m | xargs | awk '{print "Free/total memory: " $17 " / " $8 " MB"}'
echo "====================================================================" | lolcat
echo ""
echo -e "vmstat: " | lolcat
echo ""
vmstat 1 5
echo "====================================================================" | lolcat
