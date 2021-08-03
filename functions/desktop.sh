#!/bin/sh
choices="BaiduNetdisk\nBurpSuiteCommunity\nRemoveQQCache\nShutdownNow\nGTA_ViceCity\nFortressEscape\nMaimWindow\nGentoo\npvz\npyftpd\nDunst\nNotion\nAnimated_Wallpaper\nHibernate"

chosen=$(echo -e $choices | dmenu -p "Enter the application：")

#For special characters, use '\' to transform
case $chosen in
    QQ)
		/opt/tencent-qq/qq ;;
        #env LANG=zh_CN.UTF-8 WINEDEBUG=-all,+fps wine "/home/dylan/.wine/drive_c/Program Files/Tencent/QQ/Bin/QQ.exe" ;;
        #if [ $(pgrep -x gsd-xsettings | wc -l) -eq 0 ]; then
            #/usr/lib/gsd-xsettings &
        #elif [ $(pgrep -x gsd-xsettings | wc -l) -eq 1 ]; then
            #echo ''
        #fi
        #/opt/deepinwine/apps/Deepin-QQ/run.sh ;;
        #/opt/deepinwine/apps/Deepin-TIM/run.sh ;;
    #WeChat)
        #env LANG=zh_CN.UTF-8 WINEDEBUG=-all,+fps wine "/home/dylan/.wine/drive_c/Program Files/Tencent/WeChat/WeChat.exe" ;;
        #env LANG=zh_CN.UTF-8 WINEDEBUG=-all,+fps wine "~/.wine/drive_c/Program Files/Tencent/WeChat/WeChat.exe" ;;
    BaiduNetdisk)
        /usr/lib/baidunetdisk/baidunetdisk --no-sandbox %U ;;
	BurpSuiteCommunity)
		/opt/BurpSuiteCommunity/BurpSuiteCommunity ;;
	RemoveQQCache)
		rm -r ~/.config/tencent-qq/ ;;
	ShutdownNow)
		shutdown now ;;
	GTA_ViceCity)
		cd ~/SteamLibrary/steamapps/common/Grand\ Theft\ Auto\ Vice\ City && ./reVC ;;
	FortressEscape)
		~/Games/FortressEscape/FortressEscape.x86 ;;
	MaimWindow)
		maim -s | convert - \( +clone -background black -shadow 80x3+5+5 \) +swap -background none -layers merge +repage ~/Pictures/screenshots/$(date +%F_%H-%M).png ;;
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
		cd ~/Games/pvz_goty/ && wine ./PlantsVsZombies.exe ;;
	pyftpd)
		/usr/bin/python $HOME/scripts/ftp/ftp_exec.py ;;
	Dunst)
		dunst -config $HOME/.config/dunst/dunstrc_dracula > /dev/null 2>&1 ;;
	Notion)
		/opt/Notion/notion-app > /dev/null 2>&1 ;;
	Animated_Wallpaper)
		$HOME/scripts/backgrounds/anime_wall.sh > /dev/null 2>&1 & ;;
	Hibernate)
		pkexec systemctl hibernate ;;
		# $HOME/scripts
esac
