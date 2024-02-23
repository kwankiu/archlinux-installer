# Arch Linux Installer for ARM (Aarch64)
### With main focus on the Radxa Rock 5 and RK3588

![alt archlinux-arm logo](https://archlinuxarm.org/public/images/alarm.png)

a community-built Arch Linux Installer for ARM (Aarch64) based devices.

### Supported devices:
- Radxa Rock 5 series (Rock 5A and Rock 5B)
- Orange Pi 5 series ([Needs Testing](https://github.com/kwankiu/archlinux-installer-rock5/discussions))
- Khadas Edge 2 ([Known Issues](https://github.com/kwankiu/archlinux-installer-rock5/wiki/General#known-issues))

![alt neofetch screenshot](https://i.imgur.com/3ynZCthl.png)

# Get the installer

## Flashing images (Recommended)

### Radxa Rock 5 series

Images for Radxa Rock 5 series are available on the [RPI Imager repository](https://forum.radxa.com/t/i-made-a-community-images-repository-for-rpi-imager/20080).

### Khadas Edge 2

Images for Khadas Edge 2 are available on [OOWOW](https://docs.khadas.com/software/oowow/getting-started) (coming soon).

### For all devices
You may also download our [prebuilt image](https://github.com/kwankiu/archlinux-installer-rock5/releases/latest) and flash it (using [RPI Imager](https://www.raspberrypi.com/software/), [balenaEtcher](https://etcher.balena.io/), etc) to your storage device.

  More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer-rock5/wiki/Get-the-installer).

## Running the script (Advanced)

You can build your own image or flash our Installer to your disk directly by executing the following command:

```bash

bash  <(curl  -fsSL https://raw.githubusercontent.com/kwankiu/archlinux-installer-rock5/main/archlinux-installer)

```

  More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer-rock5/wiki/Advanced).

# Installation

1. Power ON your Device with the **Storage Device** and **Ethernet Cable (or WiFi Adapter)** plugged in .  
- If your first boot shows a user login screen instead, login to root/root and run `installer`.

2. The installer will run some setups and you should be prompted to create a user account. Follow the instructions and it should automatically reboot and login to the newly created user account.
- If it does not log in automatically, log in to your newly created user account. 
- If the installer does not start automatically, run `installer` to start it.

3. The installer will guide you through the installation of Arch Linux with your desired Settings, Kernel, Desktop Environment, and Software, Enjoy!

More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer-rock5/wiki/Installation).

# Troubleshooting

1. If you get stuck while rebooting, unplug the power and power it on manually.

2. WiFi support is experimental. This is only tested on RTL8852BE, other WiFi adapter may not work properly, refer to armbian firmware for supported WiFi adapter.

3. After the inital setup, the device will reboot, and you will need to connect to WiFi again after a reboot.

4. After the installation, you will need to connect to WiFi again.

  More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer-rock5/wiki/General#troubleshooting).

# Arch Rock Configuration Utility (experimental)

We have created a configuration utility `arch-rock-config` just like [armbian-config](https://github.com/armbian/config), [rsetup](https://docs.radxa.com/en/radxa-os/rsetup/rsetup-tool), or [raspi-config](https://www.raspberrypi.com/documentation/computers/configuration.html) but for Arch Linux running on Rock 5 / RK3588.

Note: I am creating a new configuration utility called [acu](https://github.com/kwankiu/acu) which is based on this utility. This utility will be replaced by [acu](https://github.com/kwankiu/acu) once it is ready for use.

![alt Arch Rock Configuration Utility](https://i.imgur.com/bccc10d.png)

### Note that this configuration utility is work-in-progress.

  To launch the configuration utility:

```
arch-rock-config
```

More details can be found at our [wiki](https://github.com/kwankiu/archlinux-installer-rock5/wiki/General#troubleshooting).
