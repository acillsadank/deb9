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

 echo "" 
        echo ""
        echo "<=------------- Selamat Datang di Server - IP: $MYIP -------------=>" | lolcat
        echo "<============================================================================>" | lolcat
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	tram=$( free -m | awk 'NR==2 {print $2}' )
	swap=$( free -m | awk 'NR==4 {print $2}' )
	up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')

	echo -e "\e[032;1mCPU model:\e[0m $cname"
	echo -e "\e[032;1mNumber of cores:\e[0m $cores"
	echo -e "\e[032;1mCPU frequency:\e[0m $freq MHz"
	echo -e "\e[032;1mTotal amount of ram:\e[0m $tram MB"
	echo -e "\e[032;1mTotal amount of swap:\e[0m $swap MB"
	echo -e "\e[032;1mSystem uptime:\e[0m $up"
	echo "<============================================================================>" | lolcat
	echo ""
  echo -e "\e[036m-----=[ Seputar SSH SSL/TLS ]=-----\e[0m"
	echo -e "  \e[032;1m 1\e[0m\e[037;1m)\e[0m \e[031;1mCreate Akun \e[0m (\e[37;1muser-add\e[0m)"
	echo -e "  \e[032;1m 2\e[0m\e[037;1m)\e[0m \e[031;1mGenerate Akun Trial \e[0m (\e[37;1muser-trial\e[0m)"
	echo -e "  \e[032;1m 3\e[0m\e[037;1m)\e[0m \e[031;1mTambah Masa Aktif Akun \e[0m (\e[37;1muser-renew\e[0m)"
  echo -e "  \e[032;1m 4\e[0m\e[037;1m)\e[0m \e[031;1mUser List Akun \e[0m (\e[37;1muser-list\e[0m)"
	echo -e "  \e[032;1m 5\e[0m\e[037;1m)\e[0m \e[031;1mUser Login Akun \e[0m (\e[37;1muser-login\e[0m)"
  echo -e "  \e[032;1m 6\e[0m\e[037;1m)\e[0m \e[031;1mGanti Password Akun \e[0m (\e[37;1muser-pass\e[0m)"
	echo -e "  \e[032;1m 7\e[0m\e[037;1m)\e[0m \e[031;1mBanned User \e[0m (\e[37;1muser-ban\e[0m)"
	echo -e "  \e[032;1m 8\e[0m\e[037;1m)\e[0m \e[031;1mUnbanned User \e[0m (\e[37;1muser-unban\e[0m)"
	echo -e "  \e[032;1m 9\e[0m\e[037;1m)\e[0m \e[031;1mUser Lock \e[0m (\e[37;1muser-lock\e[0m)"
	echo -e "  \e[032;1m10\e[0m\e[037;1m)\e[0m \e[031;1mUser Unlock \e[0m (\e[37;1muser-unlock\e[0m)"
	echo -e "  \e[032;1m11\e[0m\e[037;1m)\e[0m \e[031;1mHapus Akun \e[0m (\e[37;1muser-del\e[0m)"
	echo -e "  \e[032;1m12\e[0m\e[037;1m)\e[0m \e[031;1mCek Banned User \e[0m (\e[37;1mlog-ban\e[0m)"
	echo -e "  \e[032;1m13\e[0m\e[037;1m)\e[0m \e[031;1mCek User Aktif \e[0m (\e[37;1muser-active-list\e[0m)"
	echo -e "  \e[032;1m14\e[0m\e[037;1m)\e[0m \e[031;1mCek User Expire \e[0m (\e[37;1muser-expire-list\e[0m)"
	echo -e "  \e[032;1m15\e[0m\e[037;1m)\e[0m \e[031;1mDelete User Expire \e[0m (\e[37;1mdelete-user-expire\e[0m)"
	echo -e "  \e[032;1m16\e[0m\e[037;1m)\e[0m \e[031;1m[ON] Kill Multi Login\e[0m (\e[37;1mkill-on\e[0m)"
	echo -e "  \e[032;1m17\e[0m\e[037;1m)\e[0m \e[031;1m[OFF] Kill Multi Login\e[0m (\e[37;1mkill-off\e[0m)"
  echo ""
	echo -e "\e[036m-----=[ Seputar VPS ]=-----\e[0m"
	echo -e "  \e[032;1m18\e[0m\e[037;1m)\e[0m \e[034;1mSpeedtest Server \e[0m (\e[37;1speedtest.py\e[0m)"
	echo -e "  \e[032;1m19\e[0m\e[037;1m)\e[0m \e[034;1mBenchmark \e[0m (\e[37;1mbenchmark\e[0m)"
	echo -e "  \e[032;1m20\e[0m\e[037;1m)\e[0m \e[034;1mMemory Usage \e[0m (\e[37;1mps-mem\e[0m)"
	echo -e "  \e[032;1m21\e[0m\e[037;1m)\e[0m \e[034;1mClean Cache RAM \e[0m (\e[37;1mcache\e[0m)"
	echo -e "  \e[032;1m22\e[0m\e[037;1m)\e[0m \e[034;1mEdit Banner Login \e[0m (\e[37;1medit-banner\e[0m)"
	echo -e "  \e[032;1m23\e[0m\e[037;1m)\e[0m \e[034;1mRestart All Service \e[0m (\e[37;1mresvis\e[0m)"
	echo -e "  \e[032;1m24\e[0m\e[037;1m)\e[0m \e[034;1mMenu Edit Port \e[0m (\e[37;1medit-port\e[0m)"
	echo -e "  \e[032;1m25\e[0m\e[037;1m)\e[0m \e[034;1mReboot VPS \e[0m (\e[37;1mreboot\e[0m)"
	echo -e "  \e[032;1m26\e[0m\e[037;1m)\e[0m \e[034;1mChange Password VPS \e[0m (\e[37;1mpasswd\e[0m)"
  echo -e "  \e[032;1m27\e[0m\e[037;1m)\e[0m \e[034;1mUbah Hostname VPS \e[0m (\e[37;1mhostname\e[0m)"
	echo -e "  \e[032;1m28\e[0m\e[037;1m)\e[0m \e[034;1mCek Health Server \e[0m (\e[37;1mhealth\e[0m)"
	echo -e "  \e[032;1m29\e[0m\e[037;1m)\e[0m \e[034;1mLihat Lokasi \e[0m (\e[37;1mlokasi\e[0m)"
	echo ""
	echo -e "\e[036m-----=[ Others Menu ]=-----\e[0m"
	echo -e "  \e[032;1m30\e[0m\e[037;1m)\e[0m \e[035;1mView Log Install\e[0m (\e[37;1mlog-install\e[0m)"
  echo ""
	echo -e "    \e[032;1m x\e[0m\e[037;1m)\e[0m Exit"
	read -p "Masukkan pilihan anda, kemudian tekan tombol ENTER: " option1
  case $option1 in
	1)
	clear
	user-add
	;;
	2)
	clear
	user-trial
	;;
	3)
	clear
	user-renew
	;;
	4)
	clear
	user-list
	;;
	5)
	clear
	user-login
  ;;
  6)
  clear
  user-pass
	;;
	7)
	clear
	user-ban
	;;
	8)
	clear
	user-unban
	;;
	9)
	clear
	user-lock
	;;
	10)
	clear
	user-unlock
	;;
	11)
	clear
	user-del
	;;
	12)
	clear
	log-ban
	;;
	13)
	clear
	user-active-list
	;;
	14)
	clear
	user-expire-list
	;;
	15)
	clear
	delete-user-expire
	;;
	16)
	clear
	read -p "Isikan Maximal User Login (1-2): " MULTILOGIN2
	#echo "@reboot root /root/userlimit.sh" > /etc/cron.d/userlimitreboot
	echo "* * * * * root /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit1
	echo "* * * * * root sleep 10; /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit2
	echo "* * * * * root sleep 20; /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit3
	echo "* * * * * root sleep 30; /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit4
	echo "* * * * * root sleep 40; /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit5
	echo "* * * * * root sleep 50; /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit6
	#echo "@reboot root /root/userlimitssh.sh" >> /etc/cron.d/userlimitreboot
	echo "* * * * * root /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit1
	echo "* * * * * root sleep 11; /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit2
	echo "* * * * * root sleep 21; /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit3
	echo "* * * * * root sleep 31; /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit4
	echo "* * * * * root sleep 41; /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit5
	echo "* * * * * root sleep 51; /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit6
	service cron restart
	service ssh restart
	service dropbear restart
	echo "------------+ AUTO KILL SUDAH DI AKTIFKAN BOSS +--------------" | lolcat
	;;
	17)
	clear
	rm -rf /etc/cron.d/userlimit1
	rm -rf /etc/cron.d/userlimit2
	rm -rf /etc/cron.d/userlimit3
	rm -rf /etc/cron.d/userlimit4
	rm -rf /etc/cron.d/userlimit5
	rm -rf /etc/cron.d/userlimit6
	rm -rf /etc/cron.d/userlimitreboot
	service cron restart
	service ssh restart
	service dropbear restart
	;;
	18)
	clear
	echo "SPEEDTEST SERVER" | boxes -d peek | lolcat
	echo "-----------------------------------------"
	speedtest --share | lolcat
	echo "-----------------------------------------"
	;;
	19)
	clear
	benchmark | lolcat
	;;
	20)
	clear
	ps-mem | boxes -d dog | lolcat
	;;
	21)
	clear
	cache-ram
	;;
	22)
	clear
	edit-banner
	;;
	23)
	clear
	service ssh restart
	service dropbear restart
	service squid restart
  service stunnel4 restart
	echo "Semua sudah Berhasil di restart boss!!!" | boxes -d boy | lolcat
	;;
	24)
	clear
	edit-port
	;;
	25)
	clear
	reboot
	;;
	26)
	read -p "Silahkan isi password baru untuk VPS anda: " pass	
        echo "root:$pass" | chpasswd
	echo "Ciieeee.. Ciieeeeeee.. Abis Ganti Password VPS Nie Yeeee...!!!"| boxes -d boy | lolcat
	echo ""
	;;
	27)
	clear
	echo "Masukan HOSTNAME VPS, yang mau diganti :"
	echo "  contoh : " hostname Orang-Ganteng "
	;;
	28)
	clear
	health
	;;
	29)
	clear
	user-login
	echo "Contoh: 207.123.35.126 lalu Enter" | lolcat
  read -p "Ketik Salah Satu Alamat IP User: " userip
  curl ipinfo.io/$userip
	echo "-----------------------------------" | lolcat
	;;
	30)
	clear
	cat log-install.txt
	;;
	x)
            ;;
        *) menu;;
    esac
