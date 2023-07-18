#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BACKUP_FILEPATH="$HOME/theme-manager-dotfiles-copy.tar.gz"
CONFIG_DIR="$HOME/.config"
ALL_DIRS=(eww hypr rofi scripts dunst kitty)

install() {
    mkdir -p "$CONFIG_DIR"
    cd "$CONFIG_DIR"

    selected_dirs=()
    for dir in ${ALL_DIRS[@]}; do
        if [ -d $dir ]; then
            selected_dirs+=( $dir )
        fi
    done

    if [ ${#selected_dirs[@]} -ne 0 ]; then
        if [ ! -f "$BACKUP_FILEPATH" ]; then
            tar -czf "$BACKUP_FILEPATH" ${selected_dirs[@]} -h
            if [ $? -eq 0 ]; then
                echo "Created current dotfiles copy: $BACKUP_FILEPATH"
            else
                echo "Cannot create archive"
                exit 1
            fi
        fi
        rm -rf ${selected_dirs[@]}
    fi

    cd "$SCRIPT_DIR/.config"
    stow . -t "$CONFIG_DIR"
}

uninstall() {
    cd "$CONFIG_DIR"
    if [ ! -f "$BACKUP_FILEPATH" ]; then
        echo "Operation failed. Backup file doesn't exists: $BACKUP_FILEPATH"
        exit 1
    fi
    rm -rf ${ALL_DIRS[@]}
    tar -xzf "$BACKUP_FILEPATH" ${selected_dirs[@]} -h
    if [ $? -eq 0 ]; then
        rm -f "$BACKUP_FILEPATH"
    fi
}

case "$1" in
    install) install ;;
    uninstall) uninstall ;;
    *) echo "Use one of commands: install, uninstall" ;;
esac

if [ $? -eq 0 ]; then
    echo "Operation successful"
else
    echo "Operation failed"
fi
