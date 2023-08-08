#!/bin/bash

################################################################
#                                                              #
#    Arch Linux post installation tool for Rock 5B / RK3588    #
#                                                              #
################################################################

# Check if the script is being run with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Check internet connection
echo "Checking internet connection..."
servers=("8.8.8.8" "1.1.1.1" "114.114.114.114") # ping Google, Cloudflare and China Mobile (for China users)
internet_available=false

for server in "${servers[@]}"; do
    if ping -q -c 3 "$server" >/dev/null; then
        echo "Internet is available via $server."
        internet_available=true
        break
    fi
done

if ! "$internet_available"; then
    echo "No internet connection. We might not be able to set you up if you dont have internet connection. Are you sure to continue (y/n)?"
    read answer
    if [ "$answer" = "n" ]; then
        echo "Aborted because no internet connection. Exiting ..."
        exit 1
    fi
fi

#initialize the pacman keyring and populate the Arch Linux ARM package signing keys
pacman-key --init
pacman-key --populate archlinuxarm

#wheel group
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Prompt user to enter a new username
read -p "Enter a new username : " new_username

# Check if the username is not empty
if [ -z "$new_username" ]; then
    echo "Username cannot be empty"
    exit 1
fi

# Create the user account
useradd -m -G wheel -s /bin/bash "$new_username"

# Check if the useradd command was successful
if [ $? -eq 0 ]; then
    echo "User $new_username created successfully"
    # Remove the default "alarm" account
    userdel -r alarm
    if [ $? -eq 0 ]; then
        echo "Default 'alarm' account removed successfully"
    else
        echo "Error removing default 'alarm' account"
    fi
else
    echo "Error creating user $new_username"
    exit 1
fi

# Prompt user to set a password for the new user
echo "Set a password for user $new_username"
passwd "$new_username"

# Check if the passwd command was successful
if [ $? -eq 0 ]; then
    echo "Password set for user $new_username"
else
    echo "Error setting password for user $new_username"
    exit 1
fi

# Add the user to the sudoers group using usermod
usermod -aG wheel "$new_username"

# Check if the usermod command was successful
if [ $? -eq 0 ]; then
    echo "User $new_username added to sudoers successfully"
else
    echo "Error adding user $new_username to sudoers"
fi

# Prompt user to change the root password
echo "Please set a root password : "
passwd

# Get boot partition from the current mount point "/"
rootfs_partition=$(mount | grep "on / " | awk '{print $1}')
rootfs_disk=$(echo "$rootfs_partition" | sed 's/[0-9]*$//')
boot_partition=$(fdisk -l "$rootfs_disk" | grep "$rootfs_disk" | awk 'NR==2{print $1}')

# Check if the boot_partition is not empty
if [ -z "$boot_partition" ]; then
    echo "Unable to determine boot partition on $rootfs_disk"
    exit 1
fi

# Add the line to /etc/fstab
new_line="$boot_partition /boot vfat dmask=000,fmask=0111,user 0 0"

# Check if the line already exists in /etc/fstab
if grep -qF "/boot vfat dmask=000,fmask=0111,user 0 0" /etc/fstab; then
    echo "boot partition seems already configured in /etc/fstab to manage by system."
else
    # Add the line to /etc/fstab
    echo "$new_line" >> /etc/fstab
    # Check if the addition was successful
    if [ $? -eq 0 ]; then
        cat /etc/fstab
        echo "Line added to /etc/fstab successfully"
    else
        echo "Error adding line to /etc/fstab"
    fi
fi

# Install sudo
echo "Installing sudo"
pacman -Sy sudo --noconfirm

# TODO: Download postinstall.sh to user home directory

echo "Done, you may login to your newly created user account $new_username after the reboot."

# Prompt user if they want to reboot
read -t 5 -p "Changes have been made. We will reboot your system in 5 seconds. Do you want to reboot now? (y/n): " reboot_choice

if [[ "$reboot_choice" == "n" || "$reboot_choice" == "N" ]]; then
    echo "You can manually reboot later to apply the changes."
else
    echo "Removing this script ..."
    rm -rf firstbootsetup.sh
    echo "Done. Rebooting..."
    reboot
fi
