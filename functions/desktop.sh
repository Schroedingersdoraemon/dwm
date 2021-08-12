#!/bin/sh
choices="BaiduNetdisk\nBurpSuiteCommunity\nRemoveQQCache\nShutdownNow\nGTA_ViceCity\nFortressEscape\nMaimWindow\nGentoo\npvz\npyftpd\npyftpd_ip\nDunst\nNotion\nAnimated_Wallpaper\nHibernate\nX11VNCServer"

chosen=$(echo -e $choices | dmenu -p "Enter the application：")

#For special characters, use '\' to transform
case $chosen in
    QQ)
		/opt/tencent-qq/qq ;;
    BaiduNetdisk)
        /usr/lib/baidunetdisk/baidunetdisk --no-sandbox %U ;;
	BurpSuiteCommunity)
		/opt/BurpSuiteCommunity/BurpSuiteCommunity ;;
	RemoveQQCache)
		rm -r $HOME/.config/tencent-qq/ ;;
	ShutdownNow)
		shutdown now ;;
	GTA_ViceCity)
		cd $HOME/SteamLibrary/steamapps/common/Grand\ Theft\ Auto\ Vice\ City && ./reVC ;;
	FortressEscape)
		$HOME/Games/FortressEscape/FortressEscape.x86 ;;
	MaimWindow)
		maim -s | convert - \( +clone -background black -shadow 80x3+5+5 \) +swap -background none -layers merge +repage $HOME/Pictures/screenshots/$(date +%F_%H-%M).png ;;
	Gentoo)
		qemu-system-x86_64\
			-m 2G \
			-enable-kvm \
			-cpu host \
			-smp 4 \
			$HOME/workspace/qemus/gentoo_image \
			# -netdev user \
			#-device virtio-net,netdev=vmnic -netdev user,id=vmnic \
			-device VGA,edid=on,xres=1920,yres=1080 \
			#-device VGA,edid=on,xres=1280,yres=720 \
			> /dev/null 2>&1
			;;
	pvz)
		cd $HOME/Games/pvz_goty/ && wine ./PlantsVsZombies.exe ;;
	pyftpd)
		/usr/bin/python $HOME/scripts/ftp/ftp_exec.py ;;
	pyftpd_ip)
		/usr/bin/python $HOME/scripts/ftp/ftp_exec.py ip ;;
	Dunst)
		dunst -config $HOME/.config/dunst/dunstrc_dracula > /dev/null 2>&1 ;;
	Notion)
		/opt/Notion/notion-app > /dev/null 2>&1 ;;
	Animated_Wallpaper)
		$HOME/scripts/backgrounds/anime_wall.sh > /dev/null 2>&1 & ;;
	Hibernate)
		pkexec systemctl hibernate ;;
	X11VNCServer)
		x11vnc -rfbauth $HOME/.config/vnc_pass -forever > /dev/null 2>&1 &;;

esac
