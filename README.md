# Arch Linux image / disk creation tool for Rock 5B / RK3588
This is a script / packages that setup archlinux, currently target for Radxa Rock 5B only.It automatically format,download, and flash an Arch Linux system.

# How to install / get started?

Note: Currently, only installation to a disk (directly on a Rock 5B or any Linux system with the targetted disk to install) is supported. Functionality to create an .img image is still work-in-progress.

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

Currently, using the above script to install Arch Linux, the Kernel is not maintained by Arch Linux. Therefore a full system upgrade like `pacman -Syyu` may break the system from booting. Therefore, it is recommended to re-install the linux kernel which will be maintained by Arch Linux. 

Available kernel options to install are `linux-radxa-rkbsp5-bin`, `linux-radxa-rkbsp5-git`, and `linux-rk3588-midstream`.

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
Currently available tool scripts are:

`install-kernel` - Install / Re-install Kernel that is maintained by Arch Linux.

`post-install`   - Post Install Script, fix bluetooth, ax210 driver, add soc performance profile, installing mesa, gpu accelaration, desktop environment, etc.

# WIP / TODO List / Known Issues
1. Use the script to automatically build image so that can flash using your desired image tool and use multiple times without needing to plug in the nvme drive to a linux pc or the rock 5B to use this script
2. Create image is not yet working
3. When choosing a disk, on some system, the path may not be read properly (/dev/nvme0n1 1024G may become /dev/1024G, temp solution is to manually enter the disk path)
4. post-install is still work-in-progress, not everything is working.


