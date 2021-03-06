#!/bin/sh
choices="Anaconda Navigator\nQQ\nWeChat\nBaiduNetdisk\nDDraceNetwork\nemu8086\nBurpSuiteCommunity\nDavinci Resolve\nalbion_online\nBattle_Net\nHearthstone\nRemoveQQCache\nShutdownNow\nGTA_ViceCity\nFortressEscape\nQQMusic\nMaimWindow\nGentoo\nArch\npvz\npyftpd\nDunst\nNotion"

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
    Anaconda\ Navigator)
        /opt/anaconda/bin/anaconda-navigator ;;
    emu8086)
        WINEARCH=win32 WINEPREFIX=~/.wine32 wine ~/.wine32/drive_c/emu8086/emu8086.exe ;;
	BurpSuiteCommunity)
		/opt/BurpSuiteCommunity/BurpSuiteCommunity ;;
	Davinci\ Resolve)
		/opt/resolve/bin/resolve ;;
	albion_online)
		~/Games/albion_online/Albion-Online ;;
		#~/Games/albion_online/launcher/Albion-Online ;;
	Battle_Net)
		wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Battle.net/Battle.net.exe ;;
	Hearthstone)
		wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Hearthstone/Hearthstone.exe ;;
	RemoveQQCache)
		rm -r ~/.config/tencent-qq/ ;;
	ShutdownNow)
		shutdown now ;;
	GTA_ViceCity)
		cd ~/SteamLibrary/steamapps/common/Grand\ Theft\ Auto\ Vice\ City && ./reVC ;;
	FortressEscape)
		~/Games/FortressEscape/FortressEscape.x86 ;;
	QQMusic)
		~/prog/QQmusic-1.0.6.AppImage ;;
	MaimWindow)
		maim -s | convert - \( +clone -background black -shadow 80x3+5+5 \) +swap -background none -layers merge +repage ~/Pictures/screenshots/$(date +%F_%H-%M).png ;;
	Gentoo)
		qemu-system-x86_64 -enable-kvm \
			-m 2G \
			~/qemu_kvm/gentoo_image
			-device VGA,edid=on,xres=1920,yres=1080
			;;
	Arch)
		qemu-system-x86_64 -enable-kvm \
			-m 2G \
			~/qemu_kvm/arch_image ;;
	pvz)
		cd ~/Games/pvz_goty/ && wine ./PlantsVsZombies.exe ;;
	pyftpd)
		/usr/bin/python $HOME/scripts/ftp/ftp_exec.py ;;
	Dunst)
		dunst -config $HOME/.config/dunst/dunstrc_dracula > /dev/null 2>&1 ;;
	Notion)
		/opt/Notion/notion-app > /dev/null 2>&1 ;;
esac
