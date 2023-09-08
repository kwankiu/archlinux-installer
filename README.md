# Arch Linux Installer for Rock 5 / RK3588
![alt archlinux logo](https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Archlinux-logo-inverted-version.png/500px-Archlinux-logo-inverted-version.png)

a community-built Arch Linux Installer for Radxa Rock 5 / Rockchip RK3588 SoC.

### Currently only works with Radxa Rock 5B.

![alt neofetch screenshot](https://i.imgur.com/3ynZCthl.png)

# Get the installer

## Method 1
Download our [prebuilt image](https://github.com/kwankiu/archlinux-installer-rock5/releases/latest) and flash it (using [RPI Imager](https://www.raspberrypi.com/software/), [balenaEtcher](https://etcher.balena.io/), etc) to your storage device.

## Method 2
Download and run the script below:
 ```bash
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer)
```

This will set up a bootable Arch Linux Installer on your Disk.

# Installation

1. Power ON your Rock 5 / RK3588 Device with the **Storage Device** and **Ethernet Cable** plugged in.

    Notes:
    1. If your first boot shows a user login screen instead, login to root/root and run `installer`.

2. The installer will run some setups and you should be prompted to create a user account. Follow the instructions and it should automatically reboot and login to the newly created user account. 

    Notes:
    1. If you get stuck while rebooting, you may unplug the power and power it on manually.
    2. If it does not log in automatically, log in to your newly created user account.
    3. If the installer does not start automatically, run `installer` to start it.

3. At this point, you should be able to install Arch Linux with your desired Settings, Desktop Environment, and Software with the Installer, Enjoy!

# Usage

```
archlinux-installer -OPTIONS or --OPTIONS=<arguments> ...
```

### Options

| Options | Arguments | Description |
| ------------- | ------------- | ------------- |
| `-h` or `--help` | N/A | Usage and Infomation of this Installation Tool. |
| `-d` or `--dev` | N/A | Use latest dev version of this Installation Tool. |
| `-k` or `--kernel` | `<kernel_name>` | Create Arch Linux using default kernel option or specify a kernel option with the `<kernel_name>` argument. Currently available kernel options is `rkbsp` only. |
| `-i` or `--image` | `<image_name>` | Create a disk image with default image name at `out` folder or specify an image name with the `<image_name>` argument. |
| `-b` or `--bootpart` | N/A | Create Arch Linux with a seperated boot partition. |
| `-c` or `--compress` | N/A | Compress the Disk Image to .img.xz |
| `--size` | `<image_size>` | Set disk image size (default is 4G). |
| `--disk` | `<disk_path>` | Create Arch Linux on the specified disk path (or the image mount point when used with -i or --image which is /dev/loop1 by default). |
| `--bootpartstart` | `<size>` | Set Boot/Config Partition Start Sector (default is 16MiB). |
| `--bootpartend` | `<size>` | Set Boot/Config Partition End Sector (default is 500MiB for Config or 32MiB for Boot). |

## Examples

#### Install on a disk

Prompt for picking installation options (Same as [Get the installer](https://github.com/kwankiu/archlinux-installer-rock5#how-to-install) section).

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer)
```
OR

Install on a disk (replace /dev/nvme0n1 with yours) with default Kernel option.
```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer) --disk=/dev/nvme0n1 -k
```

#### Create an image

Create an Arch Linux Installer image (.img) with default Kernel option.

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer) -i -k
```
OR

Create an Arch Linux Installer image (.img) with custom image name and size with default Kernel option.

```
bash <(curl -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer) --image=myarchinstaller.img --size=4G -k
```

#### Using the dev branch version
#### (WARNING: dev branch are not tested and may be broken.)

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

#or simply just (if ailas added)
arcu
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
| `--add-arcu` | N/A | Add ailas command `arcu` to PATH (/usr/bin). |
| `--remove-arcu` | N/A | Remove ailas command `arcu` to PATH (/usr/bin). |
| `-u` or `--update` | `<channel>` | Install latest configuration utility without checking updates. channel options: main, dev. |


### Features

#### System Maintenance
| Features | Additional Arguments | Description |
| ------------- | ------------- | ------------- |
| `upgrade` |  N/A | Check & Perform Selective / Full System Upgrade. |
| `install-kernel` |  `<kernel>` | Re-install / Replace Linux Kernel. kernel options: rkbsp, rkbsp-git, midstream. |
| `flash-bootloader` |  `<bootloader>` | Flash Latest SPI Bootloader. bootloader options: radxa, radxa-debug, edk2-rock5a, edk2-rock5b, armbian. |

#### Manage Packages
| Features | Additional Arguments | Description |
| ------------- | ------------- | ------------- |
| `install` |  `<package>` | Package Manager (Install only), Includes RK3588 Specified and Customized Packages. You can use it like: `arch-rock-config install chromium neofetch git` |
| `downgrade` |  `<package> <index>` | Install / Downgrade any Arch Linux ARM Packages from Archive (alaa). You can use it like: `arch-rock-config downgrade chromium`. By default only 15 archives shown, you may optionally add `<index>` to show more/less.  |

#### Performance & Features
| Features | Additional Arguments | Description |
| ------------- | ------------- | ------------- |
| `soc` |  `<option>` | Manage SoC Settings. options: `performance`, `ondemand`, `powersave` (and `status` for SoC Monitor). |
| `fan` |  `<option>` | Configure PWM Fan-control. options: `install`, `enable`, `disable` and `status`. |

#### User & Localization
| Features | Additional Arguments | Description |
| ------------- | ------------- | ------------- |
| `user` | `<option>` | Add, Remove and Change User Account Settings. options: `add <user>` `remove <user>` `manage <user>` |
| `locale` |  N/A | Generate Locale Settings. |
| `font` |  N/A | Install Fonts, TTF, Non-English Characters, Special Characters / Emoji. |
| `time` | `<option>` | Change Time Zone, Current Date and Time. options: `set-time-zone <time-zone> or 'sync'` `set-time-date <YYYY-MM-DD HH:MM:SS>` `network-time-zone` `system-time-zone`|
| `keyboard` |  N/A | Change Keyboard Layout. |
| `wifi` |  N/A | Change WiFi Country Settings. |

# More Information
## Linux Kernel

Kernel package options for Rock 5 / RK3588 : 
| Kernel Package  | Linux Kernel | Notes |
| ------------- | ------------- | ------------- |
| [linux-radxa-rkbsp5-bin](https://aur.archlinux.org/packages/linux-radxa-rkbsp5-bin) | Radxa Rockchip BSP (Linux-5.10.x) | Radxa BSP Kernel from Binary Package |
| [linux-radxa-rkbsp5-git](https://aur.archlinux.org/packages/linux-radxa-rkbsp5-git) | Radxa Rockchip BSP (Linux-5.10.x) | Radxa BSP Kernel from Source Code (binary package now available on [7Ji arch repo](https://github.com/7Ji/archrepo)) |
| [linux-rockchip-rk3588-bin](https://aur.archlinux.org/packages/linux-rockchip-rk3588-bin) | Armbian Rockchip BSP (Linux-5.10.x) | Armbian Kernel from Binary Package (fast to install, but may not work as well as Radxa BSP Kernel for the Rock 5) |
| [linux-rk3588-midstream](https://github.com/hbiyik/hw_necromancer/tree/master/rock5b/linux-rk3588-midstream) | Googulator's 'Midstream' (Linux-6.2.x) (experimental) | Midstream Kernel from Source Code (based on Linux-6.2, only [basic hardware support](https://github.com/Googulator/linux-rk3588-midstream/wiki), but takes a few hours to compile and install) |
| Unavailable / [Only on Armbian](https://monka.systemonachip.net/rock5b/edge/deb/) | Linux Mainline Kernel (Linux-6.5) (experimental) | Collabora is currently working on Linux Mainline Kernel for RK3588, [most of the stuff](https://gitlab.collabora.com/hardware-enablement/rockchip-3588/notes-for-rockchip-3588/-/blob/main/mainline-status.md) appears on Midstream is now on Mainline, but things like USB-PD, USB-C, HDMI, are still work-in-progress. |

You can Build & Install other Linux Kernel from source using `arch-rock-config` :
```
# replace <kernel> with rkbsp-bin, rkbsp-git or midstream-git

arch-rock-config install-kernel <kernel>
```

# Known Issues / Troubleshooting
1. Installation Script is known to run on Debian / Ubuntu / Arch Linux
2. Support for Ubuntu/Debian running on Windows WSL2 is Experimental, for other WSL2 distros, you can only create disk images.
3. For other distro, you may consider downloading our [prebuilt image](https://github.com/kwankiu/archlinux-installer-rock5/releases/latest).
