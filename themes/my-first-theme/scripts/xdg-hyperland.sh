#!/bin/sh
# sleep 1
# killall -q xdg-desktop-portal-hyprland
# killall -q xdg-desktop-portal-wlr
# killall xdg-desktop-portal
/nix/store/$(ls -la /nix/store | grep xdg-desktop-portal-hyprland | grep '^d' | awk '{print $9}')/libexec/xdg-desktop-portal-hyprland  &
# sleep 2
# /usr/lib/xdg-desktop-portal &