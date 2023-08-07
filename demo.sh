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

# Get the rootfs partition from the current mount point "/"
rootfs_partition=$(mount | grep "on / " | awk '{print $1}')

# Check if the rootfs_partition is not empty
if [ -z "$rootfs_partition" ]; then
    echo "Unable to determine rootfs partition"
    exit 1
fi

# Add the line to /etc/fstab
new_line="$rootfs_partition /boot vfat dmask=000,fmask=0111,user 0 0"
echo "$new_line" >> /etc/fstab

# Check if the addition was successful
if [ $? -eq 0 ]; then
    echo "Line added to /etc/fstab successfully"
else
    echo "Error adding line to /etc/fstab"
fi

echo "done, you may now logout and login to your newly created user account $new_username."