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
rm -f /root/squidport

if [[ "$OS" = 'debian' ]]; then
	read -p "Insert Squid Port separated by 'space': " port
	squidport="$(cat /etc/squid3/squid.conf | grep -i http_port | awk '{print $2}')"
	echo ""
	echo -e "\e[34;1mPort Squid before editing:\e[0m"

	cat > /root/squidport <<-END
	$squidport
	END

	exec</root/squidport
	while read line
	do
		echo "Port $line"
		sed "/http_port $line/d" -i /etc/squid3/squid.conf
		#sed "s/Port $line//g" -i /etc/squid3/squid.conf
	done
	rm -f /root/squidport

	echo ""

	for i in ${port[@]}
	do
		netstat -nlpt | grep -w "$i" > /dev/null
		if [ $? -eq 0 ]; then
			netstat -nlpt | grep -i squid | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				sed -i "21 a\http_port $i" /etc/squid3/squid.conf
				echo -e "\e[032;1mPort $i added successfully\e[0m"
			fi
			
			netstat -nlpt | grep -i ssh | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for OpenSSH\e[0m"
			fi
			
			netstat -nlpt | grep -i dropbear | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for Dropbear\e[0m"
			fi
			
			netstat -nlpt | grep -i openvpn | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for OpenVPN\e[0m"
			fi
		else
			sed -i "21 a\http_port $i" /etc/squid3/squid.conf
			echo -e "\e[032;1mPort $i added successfully\e[0m"
		fi
	done

	echo ""
	echo "Mohon Tunggu..."
	echo ""
	service squid3 restart > /dev/null
	sleep 0.5
	rm -f /root/squidport
	squidport="$(cat /etc/squid3/squid.conf | grep -i http_port | awk '{print $2}')"
	echo -e "\e[34;1mPort Squid after editing:\e[0m"

	cat > /root/squidport <<-END
	$squidport
	END

	exec</root/squidport
	while read line
	do
		echo "Port $line"
	done
	rm -f /root/squidport
else
	read -p "Insert Squid Port separated by 'space': " port
	squidport="$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}')"
	echo ""
	echo -e "\e[34;1mPort Squid before editing:\e[0m"
	cat > /root/squidport <<-END
	$squidport
	END
	exec</root/squidport
	while read line
	do
		echo "Port $line"
		sed "/http_port $line/d" -i /etc/squid/squid.conf
		#sed "s/Port $line//g" -i /etc/squid/squid.conf
	done
	rm -f /root/squidport
	echo ""
	for i in ${port[@]}
	do
		netstat -nlpt | grep -w "$i" > /dev/null
		if [ $? -eq 0 ]; then
			netstat -nlpt | grep -i squid | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				sed -i "27 a\http_port $i" /etc/squid/squid.conf
				echo -e "\e[032;1mPort $i added successfully\e[0m"
			fi
			
			netstat -nlpt | grep -i ssh | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for OpenSSH\e[0m"
			fi
			
			netstat -nlpt | grep -i dropbear | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for Dropbear\e[0m"
			fi
			
			netstat -nlpt | grep -i openvpn | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i failed to add. Port $i already used for OpenVPN\e[0m"
			fi
		else
			sed -i "27 a\http_port $i" /etc/squid/squid.conf
			echo -e "\e[032;1mPort $i added successfully\e[0m"
		fi
	done
	echo ""
	echo "Mohon Tunggu..."
	echo ""
	service squid restart > /dev/null
	sleep 0.5
	rm -f /root/squidport
	squidport="$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}')"
	echo -e "\e[34;1mPort Squid after editing:\e[0m"

	cat > /root/squidport <<-END
	$squidport
	END

	exec</root/squidport
	while read line
	do
		echo "Port $line"
	done
	rm -f /root/squidport
fi
cd
