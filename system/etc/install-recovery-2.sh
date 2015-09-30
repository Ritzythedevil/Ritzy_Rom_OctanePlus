#!/system/bin/sh
  echo 1 > /sys/module/sec/parameters/recovery_done		#tony
if ! applypatch -c EMMC:recovery:6252544:b59587db13016cb4cd8b6dd8f3ec6285b1e9feff; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:boot:5867520:0431e17ac9385bb8c4bdcc7c1480cff4b9ccf0ba EMMC:recovery b59587db13016cb4cd8b6dd8f3ec6285b1e9feff 6252544 0431e17ac9385bb8c4bdcc7c1480cff4b9ccf0ba:/system/recovery-from-boot.p
  if applypatch -c EMMC:recovery:6252544:b59587db13016cb4cd8b6dd8f3ec6285b1e9feff; then		#tony
	echo 0 > /sys/module/sec/parameters/recovery_done		#tony
        log -t recovery "Install new recovery image completed"
  else
	echo 2 > /sys/module/sec/parameters/recovery_done		#tony
        log -t recovery "Install new recovery image not completed"
  fi
else
  echo 0 > /sys/module/sec/parameters/recovery_done              #tony
  log -t recovery "Recovery image already installed"
fi
