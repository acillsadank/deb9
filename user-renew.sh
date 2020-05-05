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
#myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;

flag=0

echo

	#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
	#if [ "$MYIP" = "" ]; then
		#MYIP=$(wget -qO- ipv4.icanhazip.com)
	#fi

	clear
user-list
read -p "Masukkan Username Yang Akan Diperpanjang: " username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "Masukkan Tambahan Masa Aktif Account terhitung dari hari ini(Hari): " masa_aktif

today=`date +%s`
masa_aktif_detik=$(( $masa_aktif * 86400 ))
saat_expired=$(($today + $masa_aktif_detik))
tanggal_expired=$(date -u --date="1970-01-01 $saat_expired sec GMT" +%Y/%m/%d)
tanggal_expired_display=$(date -u --date="1970-01-01 $saat_expired sec GMT" '+%d %B %Y')

passwd -u $username
usermod -e  $tanggal_expired $username
egrep "^$username" /etc/passwd >/dev/null
echo -e "$password\n$password" | passwd $username

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
Valid s/d: $masa_aktif Hari)
===========================================" | lolcat
else
echo -e "Username ${red}$username${NC} tidak ditemukan di VPS anda"
exit 0
fi
