## Useful Scripts for the Installer and Tools

This directory contains various scripts that enhance the functionality of the Arch Linux Installer. Below is a description of each script:

### Scripts Overview

- **`asahi/`**  
  Contains a customized Asahi Installer specifically for setting up the Arch Linux Installer on Apple Silicon Macs. 
  This is essential for users who do not already have Asahi Linux installed.

- **`get-installer`**  
  A utility script that automatically fetches, downloads, and flashes the latest prebuilt image or setup the installer for your device. Simplifies the setup process for supported devices.

- **`arch-bootstrap-chroot`**  
  This script enables the creation of an Arch Linux chroot environment in your working directory. It works seamlessly across both x86 and ARM64 hosts, making it highly versatile.

- **`init-setup.sh`**  
  A script designed to perform initial setup tasks during the first boot. It updates the `fstab`, expands the system partition and filesystem, and performs any necessary installation cleanup.

Feel free to suggest improvements or contribute additional scripts to enhance installer functionality!