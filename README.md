# Arch Linux Installer for Rock 5B / RK3588
![alt archlinux logo](https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Archlinux-logo-inverted-version.png/500px-Archlinux-logo-inverted-version.png)

This is an installation script that gets you through an installation of Arch Linux on Rockchip RK3588 SoC.

### Currently only works with Radxa Rock 5B.

![alt neofetch screenshot](https://i.imgur.com/3ynZCthl.png)

# How to Install / Get Started?

Download and run the script below:
 ```bash
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer)
```

This will get you a bootable Arch Linux on your Disk. The default login is alarm/alarm and root login is root/root.

# First Boot Setup / Post Install

## First Boot
Note : If you have installed your copy of Arch Linux using the script above, there is a `first-boot-setup` command already added to your /usr/bin. 

1. Login as root/root
2. Now run the command
```
first-boot-setup
```
3. Once it's done, the script should automatically reboot your system.
4. Now, login to your newly created user account and enjoy!

## Installing / Reinstalling Kernel

Currently, using the above script to install Arch Linux, the Kernel is not maintained by Arch Linux. A full system upgrade such as `pacman -Syyu` is likely to break the system from booting. Therefore, it is recommended to re-install the linux kernel which will be maintained by Arch Linux. 

Available kernel options to install : 
| Kernel Package  | Linux Kernel | Notes |
| ------------- | ------------- | ------------- |
| linux-radxa-rkbsp5-bin | Radxa's Rockchip BSP (Linux-5.10.x) | Install Radxa BSP Kernel from Binary Package (fastest, but may not be up-to-date) |
| linux-radxa-rkbsp5-git | Radxa's Rockchip BSP (Linux-5.10.x) | Install Radxa BSP Kernel from Source Code (latest, but takes a few hours) |
| linux-rk3588-midstream | Googulator's 'Midstream' (Linux-6.2.x) | Install Linux Midstream Kernel from Source Code (based on linux mainline 6.2, not everything works, takes a few hours) |

To run this :
```
./tools/install-kernel
```

## Post Installation 

This will Fix Bluetooth, AX210 driver, Add SoC performance profile, Installing Graphics driver, Desktop Environment, Video Decoder Accelaration, etc.

To Run this :
```
./tools/post-install
```

# Usage

```
archlinux-installer <disk_path> <boot_img_path>
```

You can simply run the script without any parameters, the script will prompt and ask you.

You can pass only the first parameter <disk_path> (e.g. /dev/nvme0n1 for Rock 5B's NVme Slot), this will install Arch Linux to your disk path using the boot partition file from github release.

You can pass both parameters which you can use your own boot partition file path (which can be .img or .tar.gz).

Example 1 : on a Linux PC/VM, flash to external disk (this will format the disk in /dev/sdb, then download arch linux roofs and the boot partition from github release to the disk): 

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer) /dev/sdb
```

Example 2 : on Rock 5B booted on SD card, flash to NVMe Drive (this will format the disk in /dev/nvme0n1, then download arch linux roofs and use your own boot.img as boot partition to the disk): 

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer) /dev/nvme0n1 boot.img
```

## The tools folder
Currently available tool scripts are :

| Script | Description |
| ------------- | ------------- |
| install-kernel | Install / Re-install Kernel that is maintained by Arch Linux. |
| post-install | Post Install Script, fix bluetooth, ax210 driver, add soc performance profile, installing mesa, gpu accelaration, desktop environment, etc. |

# WIP / TODO List / Known Issues
1. Functionality to create an .img image is still work-in-progress.
2. When choosing a disk, on some system, the path may not be read properly (/dev/nvme0n1 1024G may become /dev/1024G, temp solution is to manually enter the disk path)
3. post-install is still work-in-progress, not everything is working.


