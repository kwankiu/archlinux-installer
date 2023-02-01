#!/bin/bash

# Check if parted is installed
if ! [ -x "$(command -v parted)" ]; then
  # Check Linux distribution
  if [ -f /etc/lsb-release ]; then
    # Ubuntu-based
    sudo apt-get update
    sudo apt-get install -y parted
  elif [ -f /etc/redhat-release ]; then
    # Red Hat-based
    sudo yum update
    sudo yum install -y parted
  elif [ -f /etc/arch-release ]; then
    # Arch Linux
    sudo pacman -S parted
  else
    echo "This script only supports Ubuntu, Red Hat, and Arch Linux distributions."
    exit 1
  fi
fi

drive=$1
if [ -z $drive ]; then
  echo "Do you want to create an image (y/n)?"
  read answer
  if [ "$answer" == "y" ]; then
    sudo mkdir -p out
    drive=out/archlinux.img
    sudo dd if=/dev/zero of=$drive bs=1M count=4096
  else
    echo "Please specify a drive (e.g. /dev/sda)"
    exit 1
  fi
fi

boot_image=$2
if [ -z $boot_image ]; then
  if [ -z $drive ]; then
    echo "Specify a boot image (e.g. /path/to/boot.tar.gz or /path/to/boot.img): "
    read answer
    boot_image=answer
   else
    echo "Please specify a boot image (e.g. /path/to/boot.tar.gz or /path/to/boot.img)"
    exit 1
   fi
fi

root_mount_dir=$(mktemp -d)
boot_mount_dir=$(mktemp -d)
boot_img_mount_dir=$(mktemp -d)

# Unmount all partitions of the specified drive
partitions=$(ls ${drive}* 2>/dev/null)
if [ "$partitions" ]; then
  for partition in $partitions; do
    sudo umount $partition 2>/dev/null || true
  done
fi

# Create GPT table and partitions
sudo parted $drive mklabel gpt
sudo parted $drive mkpart primary fat32 0% 500MB
sudo parted $drive mkpart primary ext4 500MB 100%

# Find the partitions
root_partition=$drive"2"
boot_partition=$drive"1"

# Format the partitions
sudo mkfs.ext4 $root_partition
sudo mkfs.fat -F32 $boot_partition

# Mount the partitions
sudo mount $root_partition $root_mount_dir
sudo mount $boot_partition $boot_mount_dir

# Download and extract the latest ArchLinux tarball
curl -LJO http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz
sudo bsdtar -xpf ArchLinuxARM-aarch64-latest.tar.gz -C $root_mount_dir

# Extract the boot image
if [ ${boot_image: -4} == ".img" ]; then
  sudo mount $boot_image $boot_img_mount_dir
  sudo cp -R $boot_img_mount_dir/* $boot_mount_dir
  sudo umount $boot_img_mount_dir
  rm -rf $boot_img_mount_dir
elif [ ${boot_image: -7} == ".tar.gz" ]; then
  # Extract the .tar.gz file to a temporary directory
  boot_tar_dir=$(mktemp -d)
  sudo tar -xf "$boot_image" -C "$boot_tar_dir"

  # Copy contents to boot partition
  sudo cp -r "$boot_tar_dir"/* "$boot_mount_dir"

  # Remove the temporary directory
  sudo rm -rf "$boot_tar_dir"
else
  echo "Unsupported file format. Exiting."
  exit 1
fi

# Find the UUIDs of the root partition
root_uuid=$(sudo blkid $root_partition | awk '{print $2}' | tr -d '"')
root_part_uuid=$(sudo blkid -o export $root_partition | grep PARTUUID | awk -F= '{print $2}')

# Unmount the boot and root partitions
sudo umount $boot_mount_dir $root_mount_dir

# Clean up
rm -rf $boot_mount_dir $root_mount_dir ArchLinuxARM-aarch64-latest.tar.gz

echo "Process completed successfully"
echo "Root partition UUID: $root_uuid"
echo "Root partition PARTUUID: $root_part_uuid"
