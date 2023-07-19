#!/bin/bash

set_random_wall() {
	find "$1" \
		| while read -r img; do
			echo "$((RANDOM % 1000)):$img"
		done \
		| sort -n | cut -d':' -f2- \
		| while read -r img; do
			swww img "$img"
		done
}

if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
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
INTERVAL=30

while true; do
	set_random_wall "$1"
	sleep $INTERVAL
done
