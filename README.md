# Arch Linux Installer for Rock 5B / RK3588
![alt archlinux logo](https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Archlinux-logo-inverted-version.png/500px-Archlinux-logo-inverted-version.png)

This is an installation script that gets you through an installation of Arch Linux on Rockchip RK3588 SoC.

### Currently only works with Radxa Rock 5B.

![alt neofetch screenshot](https://i.imgur.com/3ynZCthl.png)

## Warning : This is a dev branch, they are not being tested and may not work.

# How to install?
Download and run the script below:
 ```bash
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/dev/archlinux-installer)
```

This will get you a bootable Arch Linux rootfs on your Disk. The default login is alarm/alarm and root login is root/root.

# Installation

1. To continue our installation, now boot to Arch Linux and login as root/root
2. Run the command
```
arch-rock-installer
```
3. The script may reboot after creating a user account and updating a root password, you may need to log back to root/root and run the script again
```
arch-rock-installer
```
4. When it saids the linux package have a conflict, this is normal, confirm and let the script install the kernel.
5. If you want a Desktop Environment, pick a Desktop Environment to install.
6. Once it's done, the script should automatically reboot your system. Enjoy!

# Usage

```
archlinux-installer <disk_path> <kernel>
```

### 1. You can simply run the script without any arguments (Same as the "How to install?" section above), the script will prompt for picking installation options.
```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer)
```

### 2. You can pass only the first argument <disk_path> (e.g. /dev/sdb), the script will let you pick a kernel and install Arch Linux to your disk path.

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer) /dev/sdb
```

### 3. You can pass both argument <disk_path> <kernel> (e.g. /dev/nvme0n1 for <disk_path> and rkbsp for <kernel>), the script will install Arch Linux with Radxa BSP Kernel to your disk path.

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer) /dev/nvme0n1 rkbsp
```

### 4. Advanced usage

| Argument | Description |
| ------------- | ------------- |
| `<disk_path>` | Specify the installation path, this should be a disk path not a partition path. On the Rock 5B, it is /dev/nvme0n1 for NVMe SSD, /dev/mmcblk0 for uSD Card, and /dev/mmcblk1 for eMMC. For SATA or External disk, they are usually on /dev/sdX, which X is usually starting from a-z. |
| `<kernel>` | Currently available options for kernel are `rkbsp` and `midstream`. You may optionally specifiy a custom kernel by specifying the path to the file. This can be a tar (.tar.gz or .tar.xz) or image (.img). |

# More Info

## The `arch-rock-config` Configuration Utility (experimental)
We have created a configuration utility just like `armbian-config` or `raspi-config` but for Arch Linux running on Rock 5B / RK3588.
Note that this configuration utility is work-in-progress.
Available tool scripts are in the tool folder.

| Script | Description |
| ------------- | ------------- |
| arch-rock-config | Arch Linux Configuration Utility for Rock 5B / RK3588. |
| arch-rock-installer | Arch Linux Installer for Rock 5B / RK3588 (for first-time booting). |
| first-boot-setup | Apply necessary configuration for first-time boot. |
| install-kernel | Install / Re-install Kernel that is maintained by Arch Linux. |
| post-install | Post Install Script, fix bluetooth, ax210 driver, add soc performance profile, installing mesa, gpu accelaration, desktop environment, etc. |

## Installing / Reinstalling Kernel

Available kernel options to install : 
| Kernel Package  | Linux Kernel | Notes |
| ------------- | ------------- | ------------- |
| linux-radxa-rkbsp5-bin | Radxa's Rockchip BSP (Linux-5.10.x) | Install Radxa BSP Kernel from Binary Package (fastest, but may not be up-to-date) |
| linux-radxa-rkbsp5-git | Radxa's Rockchip BSP (Linux-5.10.x) | Install Radxa BSP Kernel from Source Code (latest, but takes a few hours) |
| linux-rk3588-midstream | Googulator's 'Midstream' (Linux-6.2.x) | Install Linux Midstream Kernel from Source Code (based on linux mainline 6.2, not everything works, takes a few hours) |

To run this :
```
arch-rock-config install-kernel
```

## Post Installation 
Note that this Post Installation Tools is work-in-progress.

This tool is intended to apply patches such as bluetooth fix, AX210 driver, add SoC performance profile, Then install Graphics driver, Desktop Environment, Video Decoder Accelaration, etc.

To Run this :
```
arch-rock-config post-install
```

# WIP / TODO List / Known Issues
1. Functionality to create an .img image is still work-in-progress.
2. When choosing a disk, on some system, the path may not be read properly (/dev/nvme0n1 1024G may become /dev/1024G, temp solution is to manually enter the disk path)
3. post-install is still work-in-progress, not everything is working.


