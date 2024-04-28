# Arch Linux Installer for ARM (Aarch64)

![alt archlinux-arm logo](https://archlinuxarm.org/public/images/alarm.png)

a community-built Arch Linux Installer for ARM (Aarch64) based devices.

### Supported devices:
- Radxa Rock 5 series (Rock 5A and Rock 5B)
- (Testing) Radxa Zero 3 Series (Zero 3E and Zero 3W)
- Orange Pi 5 series (Orange Pi 5, 5 Plus and 5B)
- Khadas Edge 2
- (Testing) Raspberry Pi (Pi 4B, 5B, Zero 2W, and other aarch64 model)
- (Testing) Asahi (Apple Silicon Macs)

![alt neofetch screenshot](https://i.imgur.com/3ynZCthl.png)

# Get the installer

## Flashing images (Recommended)

### Radxa Rock 5 series

Images for Radxa Rock 5 series are available on the [RPI Imager repository](https://forum.radxa.com/t/i-made-a-community-images-repository-for-rpi-imager/20080).

### Khadas Edge 2

Images for Khadas Edge 2 are available on [OOWOW](https://docs.khadas.com/software/oowow/getting-started) (coming soon).

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

1. Power ON your Device with the **Storage Device** and **Ethernet Cable (or WiFi Adapter)** plugged in .  
- If your first boot shows a user login screen instead, login to root/root and run `installer`.

2. The installer will run some setups and you should be prompted to create a user account. Follow the instructions and it should automatically reboot and login to the newly created user account.
- If it does not log in automatically, log in to your newly created user account. 
- If the installer does not start automatically, run `installer` to start it.

3. The installer will guide you through the installation of Arch Linux with your desired Settings, Kernel, Desktop Environment, and Software, Enjoy!

More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer/wiki/Installation).

# Troubleshooting

1. If you get stuck while rebooting, unplug the power and power it on manually.

2. For WiFi support, please refer to mainline linux firmware and armbian firmware (for rockchip SBCs) for supported WiFi adapter.

3. After the inital setup, the device will reboot, and you may need to connect to WiFi again after a reboot.

4. After the installation, you will need to connect to WiFi again.

  More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer/wiki/General#troubleshooting).

# Arch Rock Configuration Utility (experimental)

We have created a configuration utility `arch-rock-config` just like [armbian-config](https://github.com/armbian/config), [rsetup](https://docs.radxa.com/en/radxa-os/rsetup/rsetup-tool), or [raspi-config](https://www.raspberrypi.com/documentation/computers/configuration.html) but for Arch Linux running on Rock 5 / RK3588.

Note: I am creating a new configuration utility called [acu](https://github.com/kwankiu/acu) which is based on this utility. This utility will be replaced by [acu](https://github.com/kwankiu/acu) once it is ready for use.

![alt Arch Rock Configuration Utility](https://i.imgur.com/bccc10d.png)

### Note that this configuration utility is work-in-progress.

  To launch the configuration utility:

```
arch-rock-config
```

More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer/wiki/General#troubleshooting).
