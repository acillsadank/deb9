#!/bin/bash
#Autoscript Created By M Fauzan Romandhoni (m.fauzan58@yahoo.com) (6281311310405)
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
clear

#Check Curl
if [ ! -e /usr/bin/curl ]; then
	if [[ "$OS" = 'debian' ]]; then
	apt-get -y update && apt-get -y install curl
	else
	yum -y update && yum -y install curl
	fi
fi

#Check OS
if [[ -e /etc/debian_version ]]; then
	OS=debian
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
else
	echo "This script only works on Debian and CentOS system"
	exit
fi

#Remove Temporary Files
rm -f /root/dropbearport

if [[ "$OS" = 'debian' ]]; then
	read -p "Input a Dropbear Port separated by 'spaces': " port
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo ""
	echo -e "\e[34;1mPort Dropbear before editing:\e[0m"

	cat > /root/dropbearport <<-END
	$dropbearport
	END

	exec</root/dropbearport
	while read line
	do
		echo "Port $line"
		#sed "s/Port $line//g" -i /etc/default/dropbear
	done
	rm -f /root/dropbearport

	sed '/DROPBEAR_PORT/d' -i /etc/default/dropbear
	sed '/DROPBEAR_EXTRA_ARGS/d' -i /etc/default/dropbear

	echo ""

	for i in ${port[@]}
	do
		netstat -nlpt | grep -w "$i" > /dev/null
		if [ $? -eq 0 ]; then
			netstat -nlpt | grep -i dropbear | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -n "-p $i " >> /root/dropbearport
				echo -e "\e[032;1mPort $i added successfully\e[0m"
			fi
			
			netstat -nlpt | grep -i sshd | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for OpenSSH\e[0m"
			fi
			
			netstat -nlpt | grep -i squid | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for Squid\e[0m"
			fi
			
			netstat -nlpt | grep -i openvpn | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for OpenVPN\e[0m"
			fi
		else
			echo -n "-p $i " >> /root/dropbearport
			echo -e "\e[032;1mPort $i added successfully\e[0m"
		fi
	done

	DROPBEAR_PORT="$(cat /root/dropbearport | awk '{print $2}')"
	sed -i "5 a\DROPBEAR_PORT=$DROPBEAR_PORT" /etc/default/dropbear

	while read line
	do
		echo "Port $line"
	done < "/root/dropbearport"
	sed -i "8 a\DROPBEAR_EXTRA_ARGS=\"$line\"" /etc/default/dropbear

	echo ""
	service dropbear restart > /dev/null
	sleep 0.5
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo ""
	echo -e "\e[34;1mPort Dropbear after editing:\e[0m"

	cat > /root/dropbearport <<-END
	$dropbearport
	END

	exec</root/dropbearport
	while read line
	do
		echo "Port $line"
	done
	rm -f /root/dropbearport
else
	read -p "Enter Dropbear Ports separated by 'spaces': " port
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo ""
	echo -e "\e[34;1mPort Dropbear before editing:\e[0m"

	cat > /root/dropbearport <<-END
	$dropbearport
	END

	exec</root/dropbearport
	while read line
	do
		echo "Port $line"
		#sed "s/Port $line//g" -i -i /etc/sysconfig/dropbear
	done
	rm -f /root/dropbearport
	sed '/OPTIONS=/d' -i /etc/sysconfig/dropbear
	echo ""

	for i in ${port[@]}
	do
		netstat -nlpt | grep -w "$i" > /dev/null
		if [ $? -eq 0 ]; then
			netstat -nlpt | grep -i dropbear | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -n "-p $i " >> /root/dropbearport
				echo -e "\e[032;1mPort $i added successfully\e[0m"
			fi
			
			netstat -nlpt | grep -i sshd | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for OpenSSH\e[0m"
			fi
			
			netstat -nlpt | grep -i squid | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for Squid\e[0m"
			fi
			
			netstat -nlpt | grep -i openvpn | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for OpenVPN\e[0m"
			fi
		else
			echo -n "-p $i " >> /root/dropbearport
			echo -e "\e[032;1mPort $i added successfully\e[0m"
		fi
	done

	DROPBEAR_PORT="$(cat /root/dropbearport)"
	echo "OPTIONS=\"$DROPBEAR_PORT\"" > /etc/sysconfig/dropbear
	echo ""
	service dropbear restart > /dev/null
	sleep 0.5
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo ""
	echo -e "\e[34;1mPort Dropbear after editing:\e[0m"

	cat > /root/dropbearport <<-END
	$dropbearport
	END

	exec</root/dropbearport
	while read line
	do
		echo "Port $line"
	done
	rm -f /root/dropbearport
fi
cd
