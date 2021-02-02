#!/bin/sh
choices="Anaconda Navigator\nQQ\nWeChat\nBaiduNetdisk\nDDraceNetwork\nemu8086\nBurpSuiteCommunity\nDavinci Resolve\nalbion_online\nBattle_Net\nHearthstone\nRemoveQQCache\nShutdownNow"

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
esac
