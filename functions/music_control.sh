#!/bin/bash
if [ $(pgrep cmus) ]; then
	case $1 in
		pause)
			cmus-remote --pause ;;
		next)
			cmus-remote --next ;;
		prev)
			cmus-remote --prev ;;
	esac
elif [ $(pgrep mpd) ]; then
	case $1 in
		pause)
			mpc toggle ;;
		next)
			mpc next ;;
		prev)
			mpc prev ;;
	esac
fi
