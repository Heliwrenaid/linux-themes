#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CONFIG_DIR="$HOME/.config"
ALL_DIRS=(eww hypr rofi scripts dunst kitty)

THEME_MANAGER_DIR="$HOME/.theme-manager"
BACKUP_FILENAME="$THEME_MANAGER_DIR/dotfiles-copy"

get_new_backup_filepath() {
    echo "${BACKUP_FILENAME}-v$(get_new_backup_version).tar.gz"
}

get_new_backup_version() {
    declare -i i=1
    declare backup_file="${BACKUP_FILENAME}-v${i}.tar.gz"
    while [ -f $backup_file ]; do
        i=$((i+1))
        backup_file="${BACKUP_FILENAME}-v${i}.tar.gz"
    done
    echo $i
}

get_last_backup_version() {
    declare -i version=`get_new_backup_version`
    version=$((version-1))
    echo $version
}

get_backup_filepath() {
    echo "${BACKUP_FILENAME}-v${1}.tar.gz"
}

create_backup() {
    cd "$CONFIG_DIR"

    declare -a selected_dirs
    for dir in ${ALL_DIRS[@]}; do
        if [ -d $dir ]; then
            selected_dirs+=( $dir )
        fi
    done

    if [ ${#selected_dirs[@]} -ne 0 ]; then
        declare backup_file=`get_new_backup_filepath`
        tar -czf "$backup_file" ${selected_dirs[@]} -h
        if [ $? -eq 0 ]; then
            echo "Created backup of dotfiles: $backup_file"
        else
            echo "Operation failed. Cannot create backup"
            exit 1
        fi
    else 
        echo "There aren't any directories conflicts. Skipping backup creation"
    fi
}

install() {
    create_backup
    rm -rf ${ALL_DIRS[@]}
    cd "$SCRIPT_DIR/.config"
    stow . -t "$CONFIG_DIR"
    if [ $? -eq 0 ]; then
        echo "Successfuly installed theme"
    else
        echo "Operation failed. Cannot create symlinks"
        exit 1
    fi
}

rollback() {
    declare -i last_version=`get_last_backup_version`
    if [ $last_version -eq 0 ]; then
        echo "Operation failed. There is no backups in: $THEME_MANAGER_DIR"
        exit 1
    elif [ $last_version -eq 1 ]; then
        echo "Existing backup versions: 1"
    else
        echo "Existing backup versions: [1 - OLDEST, $last_version - NEWEST]"
    fi

    read -p "Choose version: " version
    backup_file=`get_backup_filepath $version`
    if [ ! -f $backup_file ]; then
        echo "Operation failed. Backup file: $backup_file doesn't exist"
        exit 1
    fi

    cd "$CONFIG_DIR"
    
    rm -rf ${ALL_DIRS[@]}
    tar -xzf "$backup_file" -h
    if [ $? -ne 0 ]; then
        echo "Operation failed. Cannot unpack backup"
        exit 1
    fi
}

mkdir -p "$CONFIG_DIR"
mkdir -p "$THEME_MANAGER_DIR"

case "$1" in
    install) install ;;
    rollback) rollback ;;
    delete-backups) rm -rf $THEME_MANAGER_DIR ;;
    create-backup) create_backup ;;
    list-backups) ls -l $THEME_MANAGER_DIR | grep .tar.gz | cut -d " " -f6-9 ;;
    *) echo "Use one of commands: install, rollback, create-backup, delete-backups, list-backups" && exit 0 ;;
esac
