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
 read -p "Masukkan Username yang ingin anda unban: " username
               egrep "^$username" /etc/passwd >/dev/null
               if [ $? -eq 0 ]; then
               # proses mengganti passwordnya
               passwd -u $username
               echo " "
               echo " "
               echo "-----------------------------------------------"
               echo -e "Username ${blue}$username${NC} Sudah berhasil di ${green}UNBAN${NC}."
               echo -e "Password untuk Username ${blue}$username${NC} sudah dikembalikan"
               echo "seperti semula"
               echo "-----------------------------------------------"
               else
               echo "Username tidak ditemukan di server anda"
               exit 1
               fi
