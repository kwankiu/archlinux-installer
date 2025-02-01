## Useful additional scripts for the installer / tools
### WIP

- `asahi` contains  the necessary files to create an asahi installer script, as m1n1 may not be easily installed by flashing a prebuilt image
- `get-installer` this script automatically fetch, download and flash the latest prebuilt image for your device
- `arch-bootstrap-chroot` this script creates an Arch Linux ARM chroot at your working directory, works with both x86 and ARM64 host
- `init-setup.sh` this script performs initial setup (update fstab, expand the system partition & filesystem and perform installation clean up), used at first boot