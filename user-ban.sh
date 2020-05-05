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
MAX=2
               if [ -e "/var/log/auth.log" ]; then
               OS=1;
               LOG="/var/log/auth.log";
               fi
               if [ -e "/var/log/secure" ]; then
               OS=2;
               LOG="/var/log/secure";
               fi
               if [[ ${1+x} ]]; then
               MAX=$1;
               fi 
               echo "-----------------------------------------------------------"
               echo "User yang login lebih dari Batas Multi login Anda ($MAX) :"
               echo "-----------------------------------------------------------"
               while :
               do
               cat /etc/passwd | grep "/home/" | cut -d":" -f1 > /root/user.txt
               username1=( `cat "/root/user.txt" `);
               i="0";
               for user in "${username1[@]}"
		   	   do
               username[$i]=`echo $user | sed 's/'\''//g'`;
               jumlah[$i]=0;
               i=$i+1;
			   done
               cat $LOG | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/log-db.txt
               proc=( `ps aux | grep -i dropbear | awk '{print $2}'`);
               for PID in "${proc[@]}"
		       do
               cat /tmp/log-db.txt | grep "dropbear\[$PID\]" > /tmp/log-db-pid.txt
               NUM=`cat /tmp/log-db-pid.txt | wc -l`;
               USER=`cat /tmp/log-db-pid.txt | awk '{print $10}' | sed 's/'\''//g'`;
               IP=`cat /tmp/log-db-pid.txt | awk '{print $12}'`;
               if [ $NUM -eq 1 ]; then
               i=0;
               for user1 in "${username[@]}"
			   do
               if [ "$USER" == "$user1" ]; then
               jumlah[$i]=`expr ${jumlah[$i]} + 1`;
               pid[$i]="${pid[$i]} $PID"
               fi
               i=$i+1;
			   done
               fi
			   done
               cat $LOG | grep -i sshd | grep -i "Accepted password for" > /tmp/log-db.txt
               data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
               for PID in "${data[@]}"
		       do
               cat /tmp/log-db.txt | grep "sshd\[$PID\]" > /tmp/log-db-pid.txt;
               NUM=`cat /tmp/log-db-pid.txt | wc -l`;
               USER=`cat /tmp/log-db-pid.txt | awk '{print $9}'`;
               IP=`cat /tmp/log-db-pid.txt | awk '{print $11}'`;
               if [ $NUM -eq 1 ]; then
               i=0;
               for user1 in "${username[@]}"
			   do
               if [ "$USER" == "$user1" ]; then
               jumlah[$i]=`expr ${jumlah[$i]} + 1`;
               pid[$i]="${pid[$i]} $PID"
               fi
               i=$i+1;
			   done
               fi
               done
               j="0";
               for i in ${!username[*]}
		       do
               if [ ${jumlah[$i]} -gt $MAX ]; then
               date=`date +"%Y-%m-%d %X"`;
               echo "sshinjector.net - $date - ${username[$i]} - ${jumlah[$i]}";
               echo "sshinjector.net - $date - ${username[$i]} - ${jumlah[$i]}" >> /root/log-ban.txt;
               passwd -l ${username[$i]}
			   kill ${pid[$i]};
               pid[$i]="";
               j=`expr $j + 1`;
               fi
		       done
               if [ $j -gt 0 ]; then
               if [ $OS -eq 1 ]; then
               service ssh restart > /dev/null 2>&1;
               fi
               if [ $OS -eq 2 ]; then
               service sshd restart > /dev/null 2>&1;
               fi
               service dropbear restart > /dev/null 2>&1;
               j=0;
		       fi
               sleep 1;
               done
