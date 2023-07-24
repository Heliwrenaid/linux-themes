#!/bin/bash
CONFIG_DIR="$1"
spotify_tui_path='spotify-tui/config.yml'
spotify_tui_config="$CONFIG_DIR/$spotify_tui_path"
if [ -f "$spotify_tui_config" ] && [ ! -f "$spotify_tui_config.bak" ]; then
    cp -f "$spotify_tui_config" "$spotify_tui_config.bak"
fi
rm -f "$spotify_tui_config"
cp -f "$spotify_tui_path" "$spotify_tui_config"