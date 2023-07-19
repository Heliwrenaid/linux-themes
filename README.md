## About

Just a repo containing collection of my Hyprland themes. 
Currently only one [theme](themes/my-first-theme/README.md) is available. 


## Managing themes

For managing themes a `theme-manager.sh` script was created, which provides following functionalities:
- installing themes
- listing themes
- creating proper dotfiles backups
- restoring selected backup
- listing backups
- deleting backups

### Usage


```sh
$ chmod +x theme-manager.sh
$ ./theme-manager.sh <COMMAND>
```

Available commands are: 
- list-themes
- restore-backup
- create-backup
- list-backups
- delete-backups

#### Theme installation

Before applying theme check proper theme's [requirements](themes/my-first-theme/README.md#requirements). Then run command:

```sh
$ ./theme-manager.sh install
```

The script will ask you which theme to install and then apply selected theme. 
When directories in `~/.config` directory must be overwritten then backup of overwritten directories will be created, which can be restored later.

#### Restoring backup

```sh
$ ./theme-manager.sh restore-backup
```

Next select a backup version you want to restore.


> **Note**
> Backups are saved as archives in `~/.theme-manager` directory. Please do not remove directory content manually.

