#!/bin/bash

set_random_wall() {
	ls "$1" | sort -R | tail -$N | while read image; do
		if [ ! `get_actual_wallpaper` = "$image" ]; then
			swww img "${1%/}/$image"
			break
		fi
	done
}

get_actual_wallpaper() {
	echo `swww query | cut -d ',' -f3 | cut -d ':' -f3 | head -n 1 | tr -d ' " '`
}

if [[ $# -lt 1 ]] || [[ ! -d $1 ]]; then
	echo "Usage:
	$0 <dir containg images>"
	exit 1
fi

# Edit bellow to control the images transition
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=2
export SWWW_TRANSITION_ANGLE=30
export SWWW_TRANSITION_DURATION=5
export SWWW_TRANSITION=random

if [ "$2" = "change" ]; then
	set_random_wall "$1"
	exit
fi

# This controls (in seconds) when to switch to the next image
interval=30

while true; do
	set_random_wall "$1"
	sleep $interval
done
