#!/bin/bash
#Autoscript Created By Rizwan Arif Firmansyah ( acill.sadank@gmail.com ) ( https://wa.me/6283145968517 )
clear

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
fi
#MYIP=$(wget -qO- ipv4.icanhazip.com)

echo "------------------------ MEMBUAT AKUN SSH ------------------------" | lolcat
echo " "
read -p "Isikan username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo "Username [$username] sudah ada!"
	exit 1
else
	read -p "Isikan password akun [$username]: " password
	read -p "Berapa hari akun [$username] aktif: " AKTIF

	today="$(date +"%Y-%m-%d")"
	expire=$(date -d "$AKTIF days" +"%Y-%m-%d")
	useradd -M -N -s /bin/false -e $expire $username
	echo $username:$password | chpasswd
clear

echo -e ""
echo -e "
|       Informasi Akun Baru SSH      |
============[[-SERVER-PREMIUM-]]===========
Host/IP              : $MYIP
Username             : $username
Password             : $password
Port default SSL/TLS : 443
Port default dropbear: 143, 443
Port default openSSH : 22
Port default squid   : 80, 8080, 3128

Auto kill user maximal login 2
-------------------------------------------
Valid s/d: $(date -d "$AKTIF days" +"%d-%m-%Y")
===========================================" | lolcat
echo -e " Mod By Rizwa Arif Firmansyah " | lolcat
echo -e
fi
