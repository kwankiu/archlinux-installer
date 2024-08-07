# Arch Linux Installer for ARM (Aarch64)

![alt archlinux-arm logo](https://archlinuxarm.org/public/images/alarm.png)

a community-built Arch Linux Installer for ARM (Aarch64) based devices.

[![Total Github Downloads](https://img.shields.io/github/downloads/kwankiu/archlinux-installer/total.svg?&color=E95420&label=Total%20Downloads)](https://github.com/kwankiu/archlinux-installer/releases)

<img src="https://i.imgur.com/hHD6wKi.jpeg" width="850">
<img src="https://i.imgur.com/3ynZCthl.png" width="850">

## Supported devices:
### Rockchip
- Radxa Rock 5 series (Rock 5A/5B/5B Plus/5C/5D/ITX/CM5/NX5)
- Radxa Zero 3 Series (Zero 3W/3E)
![Testers Needed](https://img.shields.io/badge/Testers%20Needed-F44336)

- Orange Pi 5 series (Orange Pi 5/5B/5 Plus/5 Pro)
- Khadas Edge Series (Edge 1/2)
- NanoPi R6 Series (NanoPi R6C/R6S/NanoPC T6)
![Testers Needed](https://img.shields.io/badge/Testers%20Needed-F44336)

### Raspberry Pi (boardcom)
- Raspberry Pi (4B/5B/Zero 2W & other aarch64 model)
![Testers Needed](https://img.shields.io/badge/Testers%20Needed-F44336)
### Asahi (apple silicon)
- Asahi (Apple Silicon Macs)
![Coming Soon](https://img.shields.io/badge/Coming%20Soon-4CAF50)

# Get the installer

## Flashing images (Recommended)

### Radxa Rock 5 series

Images for Radxa Rock 5 series are available on the [RPI Imager repository](https://forum.radxa.com/t/i-made-a-community-images-repository-for-rpi-imager/20080).

### Khadas Edge 2

~~Images for Khadas Edge 2 are available on [OOWOW](https://docs.khadas.com/software/oowow/getting-started).~~

![Coming Soon](https://img.shields.io/badge/Coming%20Soon-4CAF50)

### Asahi (apple silicon)

There are no images available for Asahi.

~~However, you can install Arch Linux ARM using the dev version of Asahi Installer. After that, you can download and run this installer.~~

![Coming Soon](https://img.shields.io/badge/Coming%20Soon-4CAF50)

### For other devices
Our [prebuilt image](https://github.com/kwankiu/archlinux-installer/releases/latest) are available for downloads, you can flash it (using [RPI Imager](https://www.raspberrypi.com/software/), [balenaEtcher](https://etcher.balena.io/), etc) to your storage device.

  More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer/wiki/Get-the-installer).

## The `create-installation-media` tool (Advanced)

You can build your own image or flash the Installer to your disk directly by executing the following command:

```bash

bash  <(curl  -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer/main/create-installation-media)

```

  More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer/wiki/Advanced).

# Installation

1. Power ON your Device with the **Storage Device** and **Ethernet Cable (or WiFi Adapter)** plugged in.

2. The installer may install some required packages and perform some inital setup at its first boot, then it will reboot.

3. Network setup will be shown, if you have a wired connection, kindy wait for 5-15 seconds, and it should get connected. If you want to use wireless connection, press 'w' key to setup a WiFi.

4. Now, choose 'Install Arch Linux (CLI/TUI)' to launch the installer.

5. The installer will guide you through the installation of Arch Linux with your desired Settings, Kernel, Desktop Environment, and Software, Enjoy!

More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer/wiki/Installation).

# Troubleshooting

1. If your first boot shows a user login screen instead, login to root/root and run `installer`.

2. If you get stuck while rebooting, unplug the power and power it on manually.

3. For WiFi support, please refer to [linux-firmware](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/), [USB WiFi Support](https://github.com/morrownr/USB-WiFi/blob/main/home/USB_WiFi_Adapters_that_are_supported_with_Linux_in-kernel_drivers.md) & [Joshua's firmware](https://github.com/Joshua-Riek/firmware) (for rockchip SBCs) for supported WiFi adapter.

4. During the installation, your system may reboot serveral times.

5. Sometimes you may need to connect to WiFi again after a reboot.

6. After the installation finishes, you will need to connect to WiFi again.

More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer/wiki/General#troubleshooting).

# ACU - A Configuration Utility for Arch Linux ARM
### Warning: ACU is still experimental.

ACU is a community-built tool designed for managing configurations and packages on Arch Linux ARM (Aarch64).

We have created this configuration utility just like [armbian-config](https://github.com/armbian/config), [rsetup](https://docs.radxa.com/en/radxa-os/rsetup/rsetup-tool), or [raspi-config](https://www.raspberrypi.com/documentation/computers/configuration.html) but for Arch Linux ARM.

![alt ACU Screenshot](https://i.imgur.com/DyaNIfv.png)

This utility is included with our archlinux-installer.

  To launch this configuration utility:

```
acu
```

Note that if you do not want this utility, it can be  uninstalled by simply running `acu remove acu`.

More details can be found at [ACU](https://github.com/kwankiu/acu).
