#!/bin/sh
lock_timeout=$1
screen_off_interval=$2
screen_off_timeout=$((lock_timeout + screen_off_interval))
swayidle -w timeout $lock_timeout '~/.config/scripts/swaylock.sh' timeout $screen_off_timeout 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep '~/.config/scripts/swaylock.sh'