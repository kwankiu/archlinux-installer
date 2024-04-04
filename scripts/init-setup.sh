#!/bin/bash

add_boot_part_fstab() {
    echo "Updating fstab ..."
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
}

init_setup() {

    echo "Running Initial System Setup ..."

    # Check if the script is being run with root privileges
    if [[ $EUID -ne 0 ]]; then
        echo "Error : Initial System Setup must be run as root"
        exit 1
    fi

    # Get rootfs partition from the current mount point "/"
    rootfs_partition=$(mount | grep "on / " | awk '{print $1}')

    # Get disk path using rootfs partition path
    rootfs_disk=$(echo "$rootfs_partition" | sed 's/[0-9]*$//')
    rootfs_disk="${rootfs_disk%p*}"

    if [ ! -e "/boot/extlinux/extlinux.conf" ]; then 
        add_boot_part_fstab
    fi

    echo "Resizing File System ..."
    growpart $rootfs_disk 2
    resize2fs $rootfs_partition

    if [ -e "/etc/systemd/system/init-setup.service" ]; then 
        systemctl disable init-setup.service
        rm -rf /etc/systemd/system/init-setup.service
    fi

    rm -rf /usr/bin/installer

    echo "System will reboot now."
    if ! reboot --force; then
        echo "Unable to reboot automatically, please reboot your device manually."
    fi 
}

init_setup