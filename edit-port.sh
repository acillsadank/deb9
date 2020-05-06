#!/bin/bash
# Autoscript Created By M Fauzan Romandhoni (m.fauzan58@yahoo.com) (6281311310405)
clear

if [[ $USER != 'root' ]]; then
	echo "Oops! root privileges needed"
	exit
fi
while :
do
	clear
	echo " "
	echo " "
	echo "-----------------------------------------"
	echo "            Edit Port Options            "
	echo "-----------------------------------------"
	echo -e "\e[031;1m 1\e[0m) Edit Port Dropbear (\e[34;1medit-port-dropbear\e[0m)"
	echo -e "\e[031;1m 2\e[0m) Edit Port Squid Proxy (\e[34;1medit-port-squid\e[0m)"
  echo ""
	echo -e "\e[031;1m x\e[0m) Exit"
	echo ""
	read -p "Select options : " option2
	case $option2 in
		1)
		clear
		edit-dropbear
		exit
		;;
		2)
		clear
		edit-squid
		exit
		;;
		x)
		clear
		exit
		;;
	esac
done
cd
