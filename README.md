# Arch Linux image / disk creation tool for Rock 5B / RK3588
This is a script / packages that setup archlinux, currently target for Radxa Rock 5B only.It automatically format,download, and flash an Arch Linux system.

# Quick Start

Note: Currently, only installation to a disk (directly on a Rock 5B or any Linux system with the targetted disk to install) is supported. Functionality to create an .img image is still work-in-progress.

Download and run the script below:
 ```bash
 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/arch-rock5b.sh)"
```

This will get you a bootable Arch Linux on your Disk. The default login is alarm/alarm and root login is root/root.

# First Boot Setup / Post Install

Note : If you have installed your copy of Arch Linux using the script above, there is a `firstbootsetup.sh` script already added to your root directory. 

IF ONLY YOU DONT ALREADY HAVE THE SCRIPT, you may download it using (skip this unless you do not have it):
 ```bash
 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/firstbootsetup.sh)"
```

1. Login as root/root
2. Now run the script
```
./firstbootsetup.sh
```
3. Once it's done, the script should automatically reboot your system. Now, login to your newly created user account and enjoy!

# Installing Graphics driver, Desktop Environment, Video Decoder Accelaration, etc.

To be updated.
Read [https://forum.radxa.com/t/archlinux-on-rock5b/13851](https://forum.radxa.com/t/archlinux-on-rock5b/13851) for reference.

# Usage

```
./arch-rock5b.sh <disk_path> <boot_img_path>
```

You can simply run the script without any parameters, the script will prompt and ask you.

You can pass only the first parameter <disk_path> (e.g. /dev/nvme0n1 for Rock 5B's NVme Slot), this will install Arch Linux to your disk path using the boot partition file from github release.

You can pass both parameters which you can use your own boot partition file path (which can be .img or .tar.gz).



Example 1 : on a Linux PC/VM, flash to external disk (this will format the disk in /dev/sdb, then download arch linux roofs and the boot partition from github release to the disk): 

```
curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/arch-rock5b.sh | bash -s /dev/sdb
```

Example 2 : on Rock 5B booted on SD card, flash to NVMe Drive (this will format the disk in /dev/nvme0n1, then download arch linux roofs and use your own boot.img as boot partition to the disk): 

```
curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/arch-rock5b.sh | bash -s /dev/nvme0n1 boot.img
```

# WIP / TODO List / Known Issues
1. Make a pre-install and post-install script to setup UUID, create user account and add sudoers, add pacman-key, install gpu and rkmpp, etc.
2. Use the script to automatically build image so that can flash using your desired image tool and use multiple times without needing to plug in the nvme drive to a linux pc or the rock 5B to use this script
3. Create image is not yet working
4. When choosing a disk, on some system, the path may not be read properly (/dev/nvme0n1 1024G may become /dev/1024G, temp solution is to manually enter the disk path)


