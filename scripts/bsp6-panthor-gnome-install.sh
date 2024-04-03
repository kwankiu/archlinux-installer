#!/bin/bash
# Installs a Gnome (Full) System with Boogie's 6.1 Panthor Kernel

    echo "Enabling and Updating Time Sync ..."
    systemctl enable systemd-timesyncd
    sleep 1
    timedatectl set-ntp false
    timedatectl set-ntp true

    echo "Adding root to wheel group ..."
    echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
    usermod -aG wheel root

    echo "Installing required packages ..."
    pacman -U --overwrite \* /usr/lib/compiled-packages/*.pkg.tar.* --needed --noconfirm

    echo "Setting up alarm pacman key ..."
    pacman-key --init
    pacman-key --populate archlinuxarm

    echo "Installing sudo ..."
    sed -i "s|CheckSpace|#CheckSpace|" /etc/pacman.conf
    pacman -Sy sudo --noconfirm

    echo "Installing ACU (Configuration Utility) ..."
    curl -o /usr/bin/acu -L "https://raw.githubusercontent.com/kwankiu/acu/0.0.6-dev/acu"
    chmod +x /usr/bin/acu
    
    echo "Removing default user account (alarm) ..."
    acu user remove alarm

    echo "Add pacman repo"
    echo -e "[experimental]\nSigLevel = Never\nServer = https://github.com/kwankiu/PKGBUILDs/releases/download/experimental" | tee -a /etc/pacman.conf
    acu rem add pacman "7Ji"

    echo "Install new kernel"
    yes y|pacman -R linux-aarch64
    rm -rf /etc/mkinitcpio.d/*
    rm -rf /boot/*
    kernelpkg="linux-aarch64-rockchip-bsp6.1-joshua-panthor-git"
    yes y|pacman -S --overwrite \* $kernelpkg $kernelpkg-headers linux-firmware-joshua-git

    # Update extlinux.conf
    echo "Updating extlinux.conf ..."
    sed -i "s|linux-rockchip-joshua-git|$kernelpkg|" /boot/extlinux/extlinux.conf
    echo "Done"
    cat /boot/extlinux/extlinux.conf

    echo "Install hw acc driver"
    pacman -Sy mesa-panfrost-git mpp-git ffmpeg-mpp-git --noconfirm

    echo "Upgrade system"
    pacman -Syyu --noconfirm

    echo "Install DE"
    pacman -Sy gnome --noconfirm
    systemctl enable gdm

    echo "Finishing ..."
    sed -i "s|#CheckSpace|CheckSpace|" /etc/pacman.conf
    rm -rf /usr/bin/installer /usr/lib/compiled-packages /usr/bin/script.sh