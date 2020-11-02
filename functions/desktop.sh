#!/bin/sh
choices="Anaconda Navigator\nQQ\nWeChat\nBaiduNetdisk\nGentoo\nShutdownGentoo\nDDraceNetwork\nemu8086\nBurpSuiteCommunity\nDavinci Resolve"

chosen=$(echo -e $choices | dmenu -p "Enter the application：")

#For special characters, use '\' to transform
case $chosen in
    QQ)
        # env LANG=zh_CN.UTF-8 WINEDEBUG=-all,+fps wine "/home/dylan/.wine/drive_c/Program Files/Tencent/QQ/Bin/QQ.exe" ;;
        if [ $(pgrep -x gsd-xsettings | wc -l) -eq 0 ]; then
            /usr/lib/gsd-xsettings &
        elif [ $(pgrep -x gsd-xsettings | wc -l) -eq 1 ]; then
            echo ''
        fi
        #/opt/deepinwine/apps/Deepin-QQ/run.sh ;;
        /opt/deepinwine/apps/Deepin-TIM/run.sh ;;
    WeChat)
        env LANG=zh_CN.UTF-8 WINEDEBUG=-all,+fps wine "/home/dylan/.wine/drive_c/Program Files/Tencent/WeChat/WeChat.exe" ;;
    BaiduNetdisk)
        /usr/lib/baidunetdisk/baidunetdisk --no-sandbox %U ;;
    Anaconda\ Navigator)
        /opt/anaconda/bin/anaconda-navigator ;;
    Gentoo)
        vboxmanage startvm gentoo ;;
    ShutdownGentoo)
        kill $(pidof VirtualBoxVM) ;;
    DDraceNetwork)
		~/SteamLibrary/steamapps/common/DDraceNetwork/ddnet/DDNet ;;
        #steam steam://rungameid/412220 ;;
    emu8086)
        wine ~/.wine/drive_c/emu8086/emu8086.exe ;;
	BurpSuiteCommunity)
		/opt/BurpSuiteCommunity/BurpSuiteCommunity ;;
	Davinci\ Resolve)
		/opt/resolve/bin/resolve ;;
esac
