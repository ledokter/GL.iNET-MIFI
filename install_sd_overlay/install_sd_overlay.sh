#!/bin/sh

# Script to use an SD card (/dev/sda1) as overlay on GL.iNET MiFi
# Run as root

set -e

echo "Updating package list..."
opkg update

echo "Installing required packages..."
opkg install kmod-usb-storage kmod-fs-ext4 block-mount e2fsprogs kmod-scsi-core

# Wait for kernel modules to load
sleep 2

# Format the SD card (WARNING: this erases all data!)
echo "Formatting SD card (/dev/sda1) as ext4..."
mkfs.ext4 /dev/sda1

# Create mount point
mkdir -p /mnt/sda1

# Mount the SD card
mount /dev/sda1 /mnt/sda1

echo "Copying current overlay to SD card..."
tar -C /overlay -cvf - . | tar -C /mnt/sda1 -xvf -

# Configure fstab for overlay
FSTAB=/etc/config/fstab
if ! grep -q "/overlay" "$FSTAB"; then
  echo "Adding overlay configuration to $FSTAB..."
  cat <<EOF >> $FSTAB

config mount
    option target '/overlay'
    option device '/dev/sda1'
    option fstype 'ext4'
    option options 'rw,sync'
    option enabled '1'
    option enabled_fsck '0'
EOF
else
  echo "Overlay configuration already exists in $FSTAB. Please check manually."
fi

echo "Syncing data..."
sync

echo "Rebooting router in 5 seconds..."
sleep 5
reboot 