#!/bin/bash

################################################################
#                                                              #
#   Arch Linux kernel installation tool for Rock 5B / RK3588   #
#                                                              #
################################################################

kernel_repo_dir="kernel-repo-dir"

install_rkbsp5_bin() {
    echo "Downloading linux-radxa-rkbsp5-bin ..."
    git clone https://aur.archlinux.org/linux-radxa-rkbsp5-bin.git
    cd linux-radxa-rkbsp5-bin

    # remove old kernel files, else the package will not install.
    mkdir ~/$kernel_repo_dir/old-kernel-files
    sudo mv /usr/bin/libmali ~/$kernel_repo_dir/old-kernel-files/libmali
    sudo mv /usr/bin/libmaliw ~/$kernel_repo_dir/old-kernel-files/libmaliw
    sudo mv /usr/lib/libmali ~/$kernel_repo_dir/old-kernel-files/libmali_folder
    sudo mv /usr/lib/modules ~/$kernel_repo_dir/old-kernel-files/modules
    sudo mv /usr/lib/firmware/mali_csffw.bin ~/$kernel_repo_dir/old-kernel-files/mali_csffw.bin
    sudo mv /boot/dtbs ~/$kernel_repo_dir/old-kernel-files/dtbs

    makepkg -si
    cd ..
    echo "Installed linux-radxa-rkbsp5"
}

install_rkbsp5_git() {
    echo "Downloading linux-radxa-rkbsp5-git ..."
    git clone https://aur.archlinux.org/linux-radxa-rkbsp5-git.git
    cd linux-radxa-rkbsp5-git

    # remove old kernel files, else the package will not install.
    mkdir ~/$kernel_repo_dir/old-kernel-files
    sudo mv /usr/bin/libmali ~/$kernel_repo_dir/old-kernel-files/libmali
    sudo mv /usr/bin/libmaliw ~/$kernel_repo_dir/old-kernel-files/libmaliw
    sudo mv /usr/lib/libmali ~/$kernel_repo_dir/old-kernel-files/libmali_folder
    sudo mv /usr/lib/modules ~/$kernel_repo_dir/old-kernel-files/modules
    sudo mv /usr/lib/firmware/mali_csffw.bin ~/$kernel_repo_dir/old-kernel-files/mali_csffw.bin
    sudo mv /boot/dtbs ~/$kernel_repo_dir/old-kernel-files/dtbs

    makepkg -si
    cd ..
    echo "Installed linux-radxa-rkbsp5"
}

install_midstream() {    
    echo "Downloading linux-rk3588-midstream ..."
    git clone https://github.com/hbiyik/hw_necromancer.git
    cd hw_necromancer/rock5b/linux-rk3588-midstream

    # remove old kernel files, this helps avoiding errors.
    mkdir ~/$kernel_repo_dir/old-kernel-files/
    sudo mv /usr/lib/modules ~/$kernel_repo_dir/old-kernel-files/modules
    sudo mv /usr/lib/firmware/mali_csffw.bin ~/$kernel_repo_dir/old-kernel-files/mali_csffw.bin
    sudo mv /boot/dtbs ~/$kernel_repo_dir/old-kernel-files/dtbs

    makepkg -si
    cd ..
    cd ..
    cd ..
    echo "Installed linux-rk3588-midstream"

    # apply new extlinux.conf
    sudo mv /boot/extlinux/extlinux.conf ~/$kernel_repo_dir/old-kernel-files/extlinux.conf
    sudo mv /boot/extlinux/extlinux.arch.template /boot/extlinux/extlinux.conf

    # Get rootfs partition from the current mount point "/"
    rootfs_partition=$(mount | grep "on / " | awk '{print $1}')

    # Find the UUIDs of the root partition
    root_uuid=$(sudo blkid $rootfs_partition | awk '{print $2}' | tr -d '"')
    echo "Root partition UUID: $root_uuid"

    # Change UUID for extlinux.conf
    echo "Updating UUID for extlinux.conf ..."
    sudo sed -i "s|UUID=\\*\\*CHANGEME\\*\\*|$root_uuid|" /boot/extlinux/extlinux.conf
    sudo sed -i "s|UUID=CHANGEME|$root_uuid|" /boot/extlinux/extlinux.conf

    # Remove libmali
    sudo rm -rf /usr/lib/libmali
    sudo rm -rf /usr/bin/libmali
    sudo rm -rf /usr/bin/libmaliw

    # Install mali_csffw.bin
    sudo pacman -Sy wget --noconfirm
    sudo wget -P /lib/firmware https://github.com/JeffyCN/mirrors/raw/488f49467f5b4adb8ae944221698e9a4f9acb0ed/firmware/g610/mali_csffw.bin

}

# Display options to the user
echo "---------------------------------------------------------------------"
echo "Install / Reinstall Linux kernel for Rock 5B / RK3588"
echo "---------------------------------------------------------------------"
echo ""
echo "Select a kernel package to install:"
echo "1. linux-radxa-rkbsp5-bin - Install Radxa BSP Kernel (recommended, but may not be up-to-date)"
echo "2. linux-radxa-rkbsp5-git - Install Radxa BSP Kernel from source (more up-to-date, but take a few hours)" 
echo "3. linux-rk3588-midstream - Install Googulator's Midstream kernel (Linux 6.2, but not everything works)"
echo ""
# Get choice
read -p "Enter the number of your choice: " choice

# Install required package
sudo pacman -S git --noconfirm
sudo pacman -S --needed base-devel --noconfirm

# create a directory
cd ~/
mkdir $kernel_repo_dir
cd $kernel_repo_dir

# Choice
case $choice in
    1)
        install_rkbsp5_bin
        ;;
    2)
        install_rkbsp5_git
        ;;
    3)
        install_midstream
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Exit the kernel repo directory
cd ..

echo "Installation completed. Do you want to keep the installation files (only keep the files if you know what you are doing) (y/n)?"
read answer

if [ "$answer" = "y" ]; then
    echo "Installation files are not removed. You may remove them manually."
else 
    sudo rm -rf ~/$kernel_repo_dir
    echo "Cleaned up installation files"
fi

# Prompt user if they want to reboot
read -t 5 -p "Changes have been made. We will reboot your system in 5 seconds. Do you want to reboot now? (y/n): " reboot_choice

if [[ "$reboot_choice" == "n" || "$reboot_choice" == "N" ]]; then
    echo "You can manually reboot later to apply the changes."
else
    echo "Done. Rebooting..."
    sudo reboot
fi