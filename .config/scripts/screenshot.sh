#!/bin/bash
cd ~/Pictures
filepath="screenshot_$(date +'%Y-%m-%d')_$(echo $RANDOM$RANDOM).png"
touch "$filepath"
grim -g "$(slurp)" $filepath
copyq copy image/png - < $filepath
