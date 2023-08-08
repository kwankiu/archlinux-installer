#!/bin/bash

################################################################
#                                                              #
#   Arch Linux kernel installation tool for Rock 5B / RK3588   #
#                                                              #
################################################################

kernel_repo_dir="kernel-repo-dir"

install_rkbsp5_bin() {
    echo "Installing linux-radxa-rkbsp5-bin ..."
    git clone https://aur.archlinux.org/linux-radxa-rkbsp5-bin.git
    cd linux-radxa-rkbsp5-bin
    makepkg -si
    cd ..
}

install_rkbsp5_git() {
    echo "Installing linux-radxa-rkbsp5-git ..."
    git clone https://aur.archlinux.org/linux-radxa-rkbsp5-git.git
    cd linux-radxa-rkbsp5-git
    makepkg -si
    cd ..
}

install_midstream() {    
    echo "Installing linux-rk3588-midstream ..."
    git clone https://github.com/hbiyik/hw_necromancer.git
    cd hw_necromancer/rock5b/linux-rk3588-midstream
    makepkg -si
    cd ..
    cd ..
    cd ..
}

# Display options to the user
echo "---------------------------------------------------------------------"
echo "Install / Reinstall Linux kernel for Rock 5B / RK3588"
echo "---------------------------------------------------------------------"
echo "Select a kernel package to install:"
echo "1. linux-radxa-rkbsp5-bin - Install Radxa BSP Kernel (recommended, but may not be up-to-date)"
echo "2. linux-radxa-rkbsp5-git - Install Radxa BSP Kernel from source (more up-to-date, but take a few hours)" 
echo "3. linux-rk3588-midstream - Install Googulator's Midstream kernel (Linux 6.2, but not everything works)"

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
