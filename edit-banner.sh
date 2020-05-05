 echo  "-----------------------------------------------------------------"
 echo -e " Mod By Rizwan Arif Firmansyah "
 echo "-----------------------------------------------------------------"
  echo -e "1.) Simpan text (CTRL + X, lalu ketik Y dan tekan Enter) "
  echo -e "2.) Membatalkan edit text (CTRL + X, lalu ketik N dan tekan Enter)"
  echo  "-----------------------------------------------------------------"
  read -p "Tekan ENTER untuk melanjutkan........................ "
  nano /etc/banner
  service dropbear restart && service ssh restart
