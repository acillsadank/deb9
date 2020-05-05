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

Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=`</dev/urandom tr -dc a-f0-9 | head -c9`

useradd -e `date -d "$hari days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo ""
echo "
|       Informasi Akun Baru SSH      |
============[[-SERVER-PREMIUM-]]===========
Host/IP              : $MYIP
Username             : $Login
Password             : $Pass\n
Port default SSL/TLS : 443
Port default dropbear: 143, 443
Port default openSSH : 22
Port default squid   : 80, 8080, 3128

Auto kill user maximal login 2
-------------------------------------------
Valid s/d: 1 Hari
===========================================" | lolcat
