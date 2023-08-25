# Arch Linux Installer for Rock 5 / RK3588
![alt archlinux logo](https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Archlinux-logo-inverted-version.png/500px-Archlinux-logo-inverted-version.png)

This is an installation script that gets you through an installation of Arch Linux on Rockchip RK3588 SoC.

### Currently only works with Radxa Rock 5B.

![alt neofetch screenshot](https://i.imgur.com/3ynZCthl.png)

# How to install?
Download and run the script below:
 ```bash
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer)
```

This will get you a bootable Arch Linux rootfs on your Disk. The default login is alarm/alarm and root login is root/root.

# Installation

1. To continue the installation, now boot to Arch Linux and login as root/root
2. Run the command
```
arch-rock-installer
```
3. The script will reboot after creating a user account and updating a root password. 

To continue the installation, log back to root/root and re-run the command
```
arch-rock-installer
```
Tips :
If it says that the linux package have a conflict, this is normal, confirm and let the script install the kernel.
If you want a Desktop Environment, pick a Desktop Environment to install.

4. Once it's done, the script should automatically reboot your system. Enjoy!

# Usage

```
archlinux-installer <options/disk_path> <kernel>
```

### Options

| Options | Additional Arguments | Description |
| ------------- | ------------- | ------------- |
| `-h` or `--help` | N/A | Usage and Infomation of this installer. |
| `-d` or `--dev` | N/A | Use latest dev installation script. |

### Optional arguments
| Argument | Description |
| ------------- | ------------- |
| `<disk_path>` | Specify the installation path, this should be a disk path not a partition path. On the Rock 5B, it is /dev/nvme0n1 for NVMe SSD, /dev/mmcblk0 for uSD Card, and /dev/mmcblk1 for eMMC. For SATA or External disk, they are usually on /dev/sdX, which X is usually starting from a-z. |
| `<kernel>` | Currently available options for kernel are `rkbsp` and `midstream`. You may optionally specifiy a custom kernel by specifying the path to the file. This can be a tar (.tar.gz or .tar.xz) or image (.img). |

## Examples

#### Typical Usage (Same as [How to install?](https://github.com/kwankiu/archlinux-installer-rock5#how-to-install) section)

This command will prompt for picking installation options.

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer)
```

#### Using  `<disk_path>`
#### (e.g. /dev/sdb)

This command will let you pick a kernel and install Arch Linux to your disk path.

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer) /dev/sdb
```

#### Using both `<disk_path>` and`<kernel>`
#### (e.g. /dev/nvme0n1 for `<disk_path>` and rkbsp for `<kernel>`)

This command will install Arch Linux with Radxa BSP Kernel to your disk path.

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer) /dev/nvme0n1 rkbsp
```

#### Using dev branch version
#### (WARNING: dev branch are not tested and may be broken.)

This command will use the script from dev branch and prompt for picking installation options.

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer) --dev
```

# Arch Rock Configuration Utility (experimental)
We have created a configuration utility `arch-rock-config` just like [armbian-config](https://github.com/armbian/config), [rsetup](https://docs.radxa.com/en/radxa-os/rsetup/rsetup-tool), or [raspi-config](https://www.raspberrypi.com/documentation/computers/configuration.html) but for Arch Linux running on Rock 5 / RK3588.

![alt Arch Rock Configuration Utility](https://i.imgur.com/bccc10d.png)

### Note that this configuration utility is work-in-progress.

## Installation

The configuration utility should be already installed during the installation using `archlinux-installer`.

If you want to use this configuration utility from a copy of Arch Linux that is not installed using `archlinux-installer`, it can be installed by running :

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/tools/arch-rock-config)
```

## Usage

To launch the configuration utility:
```
arch-rock-config
```
## Optional arguments

```
arch-rock-config <options/features> <additional-arguments (optional)>
```

### Options

| Options | Additional Arguments | Description |
| ------------- | ------------- | ------------- |
| `-h` or `--help` | N/A | Usage and Infomation of this configuration utility. |
| `-r` or `--run` | N/A | Run without installing this configuration utility to PATH (/usr/bin). |
| `-u` or `--update` | `<channel>` | Install latest configuration utility without checking updates. channel options: main, dev. |

### Features

#### System Maintenance
| Features | Additional Arguments | Description |
| ------------- | ------------- | ------------- |
| `package-updates` |  N/A |  Check & Perform Selective / Full System Upgrade. |
| `install-kernel` |  `<kernel>` |  Re-install / Replace Linux Kernel. kernel options: rkbsp, rkbsp-git, midstream. |
| `flash-bootloader` |  `<bootloader>` |  Flash Latest SPI Bootloader. bootloader options: radxa, radxa-debug, edk2-rock5a, edk2-rock5b, armbian. |

#### Manage Packages
| Features | Additional Arguments | Description |
| ------------- | ------------- | ------------- |
| `install-software` |  `<package>` |  Install Basic Software / RK3588 Specified / Customized Packages. |
| `install-kernel` |  `<package>` |  Install / Downgrade any Arch Linux Packages from Archive. |

#### Performance & Features
| Features | Additional Arguments | Description |
| ------------- | ------------- | ------------- |
| `soc` |  `<option>` | Manage SoC Settings. options: `performance`, `ondemand`, `powersave` (and `status` for SoC Monitor). |
| `fan` |  `<option>` |  Configure PWM Fan-control. options: `install`, `enable`, `disable` and `status`. |


# More Information
## Linux Kernel

Kernel package options for Rock 5 / RK3588 : 
| Kernel Package  | Linux Kernel | Notes |
| ------------- | ------------- | ------------- |
| [linux-radxa-rkbsp5-bin](https://aur.archlinux.org/packages/linux-radxa-rkbsp5-bin) | Radxa Rockchip BSP (Linux-5.10.x) | Radxa BSP Kernel from Binary Package (fastest to install, but may not be up-to-date) |
| [linux-radxa-rkbsp5-git](https://aur.archlinux.org/packages/linux-radxa-rkbsp5-git) | Radxa Rockchip BSP (Linux-5.10.x) | Radxa BSP Kernel from Source Code (latest, but takes a few hours to compile and install) |
| [linux-rockchip-rk3588-bin](https://aur.archlinux.org/packages/linux-rockchip-rk3588-bin) | Armbian Rockchip BSP (Linux-5.10.x) | Armbian Kernel from Binary Package (fast to install, but may not work as well as Radxa BSP Kernel for the Rock 5) |
| [linux-rk3588-midstream](https://github.com/hbiyik/hw_necromancer/tree/master/rock5b/linux-rk3588-midstream) | Googulator's 'Midstream' (Linux-6.2.x) (experimental) | Midstream Kernel from Source Code (based on Linux-6.2, only [basic hardware support](https://github.com/Googulator/linux-rk3588-midstream/wiki), but takes a few hours to compile and install) |
| Unavailable / [Only on Armbian](https://monka.systemonachip.net/rock5b/edge/deb/) | Linux Mainline Kernel (Linux-6.5) (experimental) | Collabora is currently working on Linux Mainline Kernel for RK3588, [most of the stuff](https://gitlab.collabora.com/hardware-enablement/rockchip-3588/notes-for-rockchip-3588/-/blob/main/mainline-status.md) appears on Midstream is now on Mainline, but things like USB-PD, USB-C, HDMI, are still work-in-progress. |

You can reinstall/replace the Linux Kernel using `arch-rock-config` :
```
# replace <kernel> with rkbsp, rkbsp-git or midstream

arch-rock-config install-kernel <kernel>
```

# Known Issues / Troubleshooting
1. Functionality to create an .img image is still work-in-progress.
2. Installation Script is known to run on Debian / Ubuntu / Arch Linux / WSL (Experiemental)
3. macOS is not supported. You may use Docker or VM and mount your disk to it.
