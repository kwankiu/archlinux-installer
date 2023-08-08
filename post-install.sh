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

# TODO: Add support for pwm fan control?

echo "Fixing bluetooth ..."
# The fix for some Bluetooth Modules (A8, AX210, etc.)
sudo echo "blacklist pgdrv" >> /etc/modprobe.d/blacklist.conf
sudo echo "blacklist btusb" >> /etc/modprobe.d/blacklist.conf
sudo echo "blacklist btrtl" >> /etc/modprobe.d/blacklist.conf
sudo echo "blacklist btbcm" >> /etc/modprobe.d/blacklist.conf
sudo echo "#blacklist btintel" >> /etc/modprobe.d/blacklist.conf

#For AX210 Wifi and BT to Work
echo "Installing WiFi driver for AX210 ..."
sudo wget -P /lib/firmware https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/iwlwifi-ty-a0-gf-a0-59.ucode
sudo mv /lib/firmware/iwlwifi-ty-a0-gf-a0.pnvm /lib/firmware/iwlwifi-ty-a0-gf-a0.pnvm.bak

echo "Installing Bluetooth driver for AX210 ..."
sudo wget -P /lib/firmware/intel https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/intel/ibt-0041-0041.sfi
sudo wget -P /lib/firmware/intel https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/intel/ibt-0041-0041.ddc

# Enable Bluetooth
sudo systemctl start bluetooth

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

echo "---------------------------------------------------------------------"
echo "Install desktop environment"
echo "---------------------------------------------------------------------"

echo "Select a desktop environment to install :"
echo "1. Gnome"
echo "2. KDE Plasma" 
echo "3. Budgie"
echo "4. XFCE"
echo "5. LXQt"
echo "6. Cinnamon"
echo "7. Cutefish"
echo "8. Deepin"
echo "9. MATE"
echo "10. Sway"
echo "11. Install GPU acceleration only"

echo "Pick an option to install :"
read answer
echo "This script is WIP"


echo "---------------------------------------------------------------------"
echo "Install additional packages"
echo "---------------------------------------------------------------------"
echo "Select a package to install :"
echo "1. Browser / Media"
echo "2. Gaming / Virtualization" 
echo "3. Misc / Tools"
echo "4. Others"

echo "Pick an option (Enter 'done' when you finish) :"
read answer
echo "This script is WIP"

echo "Setting up Video Decoder Accelaration with FFMpeg & RKMPP ..."
echo "Setting up Browser Acceleration"

