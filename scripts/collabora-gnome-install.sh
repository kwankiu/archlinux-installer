#!/bin/bash

    install_target=$1

    echo "Remove the created init setup service as we are installing directly ..."
    systemctl disable init-setup.service
    rm -rf /etc/systemd/system/init-setup.service

    echo "Enabling and Updating Time Sync ..."
    systemctl enable systemd-timesyncd
    sleep 1
    timedatectl set-ntp false
    timedatectl set-ntp true

    echo "Adding root to wheel group ..."
    echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
    usermod -aG wheel root

    echo "Setting up alarm pacman key ..."
    pacman-key --init
    pacman-key --populate archlinuxarm

    echo "set pacman config for chroot and faster downloads ..."
    sed -i "s|CheckSpace|#CheckSpace|" /etc/pacman.conf
    sed -i "s/^#ParallelDownloads\\s*=\\s*\\([0-9]\\{1,3\\}\\)\\?$/ParallelDownloads = 500/" /etc/pacman.conf

    echo "Installing sudo ..."
    pacman -Sy sudo --noconfirm

    echo "Installing ACU (Configuration Utility) ..."
    curl -o /usr/bin/acu -L "https://raw.githubusercontent.com/kwankiu/acu/dev/acu"
    chmod +x /usr/bin/acu
    
    echo "Removing default user account (alarm) ..."
    acu user remove alarm

    echo "Add pacman repo"
    echo -e "[experimental]\nSigLevel = Never\nServer = https://github.com/kwankiu/PKGBUILDs/releases/download/experimental" | tee -a /etc/pacman.conf
    acu rem add pacman "7Ji"

    echo "Remove all kernels"
    yes y|pacman -R linux-aarch64
    rm -rf /boot/vmlinu* 
    rm -rf /boot/initr*
    rm -rf /boot/dtbs
    rm -rf /usr/lib/modules/*
    rm -rf /etc/mkinitcpio.d/*

    echo "Install new kernel"
    yes y|acu install linux-aarch64-rk3588-collabora-git --usepm=pacman
    yes y|pacman -Sy linux-firmware-joshua-git

    echo "Debug: extlinux.conf"
    cat /boot/extlinux/extlinux.conf

    echo "Install hw acc driver"
    pacman -Sy mesa-panfrost-git mpp-git ffmpeg-mpp-git --noconfirm

    echo "Upgrade system"
    pacman -Syyu --noconfirm

    echo "Installing network and fonts"
    pacman -Sy networkmanager iw iwd bluez --noconfirm
    pacman -Sy noto-fonts noto-fonts-cjk noto-fonts-emoji --noconfirm

    if [ "$install_target" = "edge2" ] || [ "$install_target" = "orangepi5" ]; then
        echo "Fix: Set iwd to default"
        mkdir -p /etc/NetworkManager/conf.d
        echo -e "[device]\nwifi.backend=iwd" | tee /etc/NetworkManager/conf.d/wifi_backend.conf
        echo "Post Install: AP6275P Bluetooth"
        curl -LJO https://github.com/kwankiu/archlinux-installer-rock5/releases/download/kernel/brcm_patchram_plus
        chmod +x brcm_patchram_plus
        mv brcm_patchram_plus /usr/bin/brcm_patchram_plus
        echo -e '#!/bin/bash\nbt_status=$(cat /proc/device-tree/wireless-bluetooth/status | tr -d "\\0")\nwifi_chip=$(cat /proc/device-tree/wireless-wlan/wifi_chip_type | tr -d "\\0")\nif [[ ${wifi_chip} == "ap6275p" && ${bt_status} == "okay" ]]; then\n    echo "Enabling BT from ap6275p..."\n    rfkill unblock all\n    brcm_patchram_plus --enable_hci --no2bytes --use_baudrate_for_download --tosleep 200000 \\\n    --baudrate 1500000 --patchram /lib/firmware/ap6275p/BCM4362A2.hcd /dev/ttyS9 &\n    echo $! > /var/run/brcm_patchram_plus.pid\nelse\n    echo "Error: Your BT ap6275p firmware is probably not loaded"\n    echo "WiFi Chip Info: ${wifi_chip}"\n    echo "BT Status: ${bt_status}"\nfi' | tee /usr/local/bin/bt_ap6275p.sh >/dev/null 
        chmod +x /usr/local/bin/bt_ap6275p.sh
        echo -e '[Unit]\nDescription=AP6275P Bluetooth service\nAfter=bluetooth.target\n\n[Service]\nType=simple\nExecStart=/usr/bin/sudo /usr/local/bin/bt_ap6275p.sh\nTimeoutSec=0\nRemainAfterExit=yes\n[Install]\nWantedBy=multi-user.target' | tee /usr/lib/systemd/system/bt_ap6275p.service
        systemctl enable bt_ap6275p.service
    fi

    echo "Install DE"
    pacman -Sy gnome-shell gdm gnome-keyring gnome-control-center gnome-initial-setup gnome-console gnome-disk-utility gnome-tweaks gnome-backgrounds nautilus xdg-desktop-portal xdg-desktop-portal-gnome xdg-user-dirs librsvg --noconfirm

    echo "Enable services"
    systemctl enable gdm
    systemctl enable NetworkManager.service
    systemctl start NetworkManager.service
    systemctl enable bluetooth.service
    systemctl start bluetooth.service

    echo "Finishing ..."
    sed -i "s|#CheckSpace|CheckSpace|" /etc/pacman.conf
    rm -rf /usr/bin/installer /usr/lib/compiled-packages /usr/bin/script.sh