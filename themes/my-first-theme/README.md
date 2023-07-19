## Specification
- Window manager: hyprland
- Terminal: kitty
- Shell: bash
- Panel: eww
- Launcher: rofi
- Notification daemon: dunst
- Wallpaper daemon: swww

## Screenshots


## Requirements

In order to run configuration properly install following packages:

### Arch Linux

Hyprland:

```
$ sudo pacman -S hyprland xdg-desktop-portal-hyprland
```
Other packages:

```sh
$ sudo pacman -S stow dunst kitty grim slurp swayidle swaylock bluez bluez-utils python socat jq alsa-utils pipewire wireplumber polkit-kde-agent networkmanager ttf-nerd-fonts-symbols-common ttf-fira-code
```

And compile needed stuff from source: [eww (wayland)](https://github.com/elkowar/eww), [swww](https://github.com/Horus645/swww)

### NixOS

Installation steps will be added in the future.

### Other

Hyprland is [unofficialy supported](https://wiki.hyprland.org/Getting-Started/Installation/#packages) in other distros. After configuring hyprland you need to install equivalent packages (but names can vary).