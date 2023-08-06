# archlinux-installer-rock5
This is a script / packages that setup archlinux, currently target for Radxa Rock 5B only.

This script automatically format,download, and flash an Arch Linux system, it requires an input of a boot partition image (a /boot packed as .img or .tar.gz)

the boot image is now available in this repo, you may now just clone the repo.

Usage :

`git clone https://github.com/kwankiu/archlinux-installer-rock5.git`

`chmod +x ./arch-rock5b.sh`

`./arch-rock5b.sh <target_drive_path> <boot_image_path>`

Example 1 : on a Linux PC/VM, flash to external disk (this will format the disk in /dev/sdb, then download arch linux roofs and use boot-arch-rkbsp-latest.tar.gz as boot partition to the disk): 

`./arch-rock5b.sh /dev/sdb boot-arch-rkbsp-latest.tar.gz`

Example 2 : on Rock 5B booted on SD card, flash to NVMe Drive (this will format the disk in /dev/nvme0n1, then download arch linux roofs and use boot-arch-rkbsp-latest.tar.gz as boot partition to the disk): 

`./arch-rock5b.sh /dev/nvme0n1 boot-arch-rkbsp-latest.tar.gz`



If it success, you should see a UUID and a PARTUUID. Your disk's rootfs and boot partition (500MB) should be mounted.

In boot partition :
Open /extlinux/extlinux.conf with your prefered text editor, replace the UUID with the one the script output.

In rootfs partition :
Open /etc/fstab with your prefered text editor, add this line :
`/dev/nvme0n1p1 /boot vfat dmask=000,fmask=0111,user 0 0`



WIP / TODO List :
1. Run the script automatically without cloning git repo for example `wget https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/arch-rock5b.sh | bash`
2. Make a pre-install and post-install script to setup UUID, create user account and add sudoers, add pacman-key, install gpu and rkmpp, etc.
3. Use the script to automatically build image so that can flash using your desired image tool and use multiple times without needing to plug in the nvme drive to a linux pc or the rock 5B to use this script
4. idk



