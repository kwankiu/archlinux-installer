#!/bin/bash

################################################################
#                                                              #
#    Arch Linux post installation tool for Rock 5B / RK3588    #
#                                                              #
################################################################

echo "---------------------------------------------------------------------"
echo "Arch Linux Post Install for Rock 5B / RK3588"
echo "---------------------------------------------------------------------"
echo "Starting post installation ..."

# The fix for some Bluetooth Modules (A8, AX210, etc.)
echo "Applying bluetooth fix for some Bluetooth Modules (A8, AX210, etc.) ..."
echo "blacklist pgdrv" >> sudo /etc/modprobe.d/blacklist.conf
echo "blacklist btusb" >> sudo /etc/modprobe.d/blacklist.conf
echo "blacklist btrtl" >> sudo /etc/modprobe.d/blacklist.conf
echo "blacklist btbcm" >> sudo /etc/modprobe.d/blacklist.conf
echo "#blacklist btintel" >> sudo /etc/modprobe.d/blacklist.conf

#For AX210 Wifi and BT to Work
sudo pacman -Sy wget --noconfirm
echo "Installing WiFi driver for AX210 ..."
sudo wget -P /lib/firmware https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/iwlwifi-ty-a0-gf-a0-59.ucode
sudo mv /lib/firmware/iwlwifi-ty-a0-gf-a0.pnvm /lib/firmware/iwlwifi-ty-a0-gf-a0.pnvm.bak

echo "Installing Bluetooth driver for AX210 ..."
sudo wget -P /lib/firmware/intel https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/intel/ibt-0041-0041.sfi
sudo wget -P /lib/firmware/intel https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/intel/ibt-0041-0041.ddc

# Install Bluetooth
sudo pacman -Sy bluez

# RK3588 Profile
# Define the alias lines
performance_alias="alias performance=\"echo performance | sudo tee /sys/bus/cpu/devices/cpu[046]/cpufreq/scaling_governor /sys/class/devfreq/dmc/governor /sys/class/devfreq/fb000000.gpu/governor\""
ondemand_alias="alias ondemand=\"echo ondemand | sudo tee /sys/bus/cpu/devices/cpu[046]/cpufreq/scaling_governor && echo dmc_ondemand | sudo tee /sys/class/devfreq/dmc/governor && echo simple_ondemand | sudo tee /sys/class/devfreq/fb000000.gpu/governor\""
powersave_alias="alias powersave=\"echo powersave | sudo tee /sys/bus/cpu/devices/cpu[046]/cpufreq/scaling_governor /sys/class/devfreq/dmc/governor /sys/class/devfreq/fb000000.gpu/governor\""

# Append alias lines to ~/.bash_aliases
echo "$performance_alias" >> ~/.bash_aliases
echo "$ondemand_alias" >> ~/.bash_aliases
echo "$powersave_alias" >> ~/.bash_aliases

# Source the updated ~/.bash_aliases
source ~/.bash_aliases
echo "SoC Performance Profile Added. You may change your SoC Performance Profile by running performance, ondemand or powersave."

# TODO: Add support for pwm fan control?
# echo "Do you want to install and enable pwm fan control?"

# Install Mesa and Desktop Environment
echo "---------------------------------------------------------------------"
echo "Install desktop environment"
echo "---------------------------------------------------------------------"
echo ""
echo "Select a desktop environment to install :"
echo "1. Gnome"

# TODO
#echo "2. KDE Plasma" 
#echo "3. Budgie"
#echo "4. XFCE"
#echo "5. LXQt"
#echo "6. Cinnamon"
#echo "7. Cutefish"
#echo "8. Deepin"
#echo "9. MATE"
#echo "10. Sway"

echo "2. Install GPU acceleration only"
echo ""
echo "Pick an option to install :"
read de_options

echo "---------------------------------------------------------------------"
echo "Install Mesa / GPU acceleration"
echo "---------------------------------------------------------------------"
echo ""
echo "Select a package to install :"
echo "1. mesa-panfork-git - for Radxa BSP Kernel (rkbsp5) (linux 5.10.x)"
echo "2. mesa-pancsf-git - for Googulator's Midstream kernel (linux-rk3588-midstream) (linux 6.2.x)"
echo ""
echo "Pick an option to install :"
read answer

# tmp dir folder name
tmp_repo_dir="tmp-repo-dir"

# Install required package
sudo pacman -S git --noconfirm
sudo pacman -S --needed base-devel --noconfirm

# create and cd to a directory
cd ~/
mkdir $tmp_repo_dir
cd $tmp_repo_dir

if [ "$answer" = 1 ]; then
    #Install mesa-panfork-git
    echo "Downloading mesa-panfork-git ..."
    git clone https://aur.archlinux.org/mesa-panfork-git.git
    cd mesa-panfork-git
    makepkg -si
    cd ..
    echo "Installed mesa-panfork-git"

elif [ "$answer" = 2 ]; then
    #Install mesa-pancsf-git
    echo "Downloading mesa-pancsf-git ..."
    git clone https://github.com/hbiyik/hw_necromancer.git
    cd hw_necromancer/rock5b/mesa-pancsf-git
    makepkg -si
    cd ..
    cd ..
    cd ..
    echo "Installed mesa-pancsf-git"
else
    echo "invalid option, exiting .."
    sudo rm -rf ~/$tmp_repo_dir
    exit 1
fi

# Remove temp dir folder
echo "Installed successfully. Cleaning up installation files ..."
sudo rm -rf ~/$tmp_repo_dir

# Install desktop environment
if [ "$de_options" = 1 ]; then
    # Install Gnome
    sudo pacman -Sy gnome
    sudo systemctl enable gdm
fi

echo "---------------------------------------------------------------------"
echo "Install additional packages"
echo "---------------------------------------------------------------------"
echo ""
echo "Select a package to install :"
echo "1. Browser / Media"
echo "2. Gaming / Virtualization" 
echo "3. Misc / Tools"
echo "4. Others"
echo ""
echo "Pick an option (Enter 'done' when you finish) :"
#read answer
echo "This feature is not implemented / WIP, skipping ..."

echo "Setting up Video Decoder Accelaration with FFMpeg & RKMPP ..."
echo "This feature is not implemented / WIP, skipping ..."

echo "Setting up Browser Acceleration"
echo "This feature is not implemented / WIP, skipping ..."

# Prompt user if they want to reboot
read -t 5 -p "Changes have been made. We will reboot your system in 5 seconds. Do you want to reboot now? (y/n): " reboot_choice

if [[ "$reboot_choice" == "n" || "$reboot_choice" == "N" ]]; then
    echo "You can manually reboot later to apply the changes."
else
    echo "Done. Rebooting..."
    sudo reboot
fi