  clear
  echo "Sebelum..." | lolcat
        free -h
	echo 1 > /proc/sys/vm/drop_caches
	sleep 1
	echo 2 > /proc/sys/vm/drop_caches
	sleep 1
	echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a
	sleep 1
	echo ""
	echo "Sesudah..." | lolcat
	free -h
	echo "SUKSES..!!!Cache ram anda sudah di bersihkan." | boxes -d boy | lolcat
