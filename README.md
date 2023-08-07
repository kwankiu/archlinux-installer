# Arch Linux image / disk creation tool for Rock 5B / RK3588
This is a script / packages that setup archlinux, currently target for Radxa Rock 5B only.It automatically format,download, and flash an Arch Linux system.

# Quick Start

NOTE: Currently, only installation to a disk (directly on a Rock 5B or any Linux system with the targetted disk to install) is supported. Functionality to create an .img image is still work-in-progress.

Download and run the script below:
 ```bash
 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/arch-rock5b.sh)"
```

# Post Install

This script gets you a bootable Arch Linux on your Disk. The default login is alarm/alarm and root login is root/root.

1. Login as root/root
2. After booting, initialize the pacman keyring and populate the Arch Linux ARM package signing keys
```
pacman-key --init
pacman-key --populate archlinuxarm
```
3. Add `alarm` to sudo (or u can create your own user account and replace `alarm` with your user)

Edit the sudoers file
```
nano /etc/sudoers
```

Uncomment the line :
```
%wheel ALL=(ALL) ALL
```

Then save and exit by Ctrl+O then Enter then Ctrl+X.

Add the user to sudo :
```
usermod -aG wheel alarm
```

4. Mount your first boot partition to /boot folder in rootfs. This allow Arch to manage the kernels. 

Edit /etc/fstab
```
nano /etc/fstab
```

Add this line (Make sure to adapt your device if you are not using NVME (mmcblk for sdcard etc).)
```
/dev/nvme0n1p1 /boot vfat dmask=000,fmask=0111,user 0 0
```
Then save and exit by Ctrl+O then Enter then Ctrl+X.

5. Logout from root
```
exit
```

6.  Login to alarm/alarm (or the user account you created).

7. Install your favourite Desktop Environment or use it as CLI.

# Installing Graphics driver, Desktop Environment, Video Decoder Accelaration, etc.

To be updated.
Read [https://forum.radxa.com/t/archlinux-on-rock5b/13851](https://forum.radxa.com/t/archlinux-on-rock5b/13851) for reference.

# Usage

```
./arch-rock5b.sh <disk_path> <boot_img_path>
```


Example 1 : on a Linux PC/VM, flash to external disk (this will format the disk in /dev/sdb, then download arch linux roofs and use boot.img as boot partition to the disk): 

```
./arch-rock5b.sh /dev/sdb boot.img
```

Example 2 : on Rock 5B booted on SD card, flash to NVMe Drive (this will format the disk in /dev/nvme0n1, then download arch linux roofs and use boot.img as boot partition to the disk): 

```
./arch-rock5b.sh /dev/nvme0n1 boot.img
```

# WIP / TODO List / Known Issues
1. Make a pre-install and post-install script to setup UUID, create user account and add sudoers, add pacman-key, install gpu and rkmpp, etc.
2. Use the script to automatically build image so that can flash using your desired image tool and use multiple times without needing to plug in the nvme drive to a linux pc or the rock 5B to use this script
3. Create image is not yet working
4. When choosing a disk, on some system, the path may not be read properly (/dev/nvme0n1 1024G may become /dev/1024G, temp solution is to manually enter the disk path)


