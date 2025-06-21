#!/bin/sh

# Script to completely remove AdGuard Home from GL.iNET MiFi
# Run as root

set -e

echo "Stopping AdGuard Home (if running)..."
killall AdGuardHome 2>/dev/null || true

# Remove opkg-installed files (if any)
echo "Removing opkg files..."
rm -f /mnt/sda1/upper/usr/lib/opkg/info/AdGuardHome.*

# Remove AdGuard Home directory (binary and config)
echo "Removing AdGuard Home directory..."
rm -rf /mnt/sda1/upper/etc/AdGuardHome
rm -rf /mnt/sda1/AdGuardHome

# Optional: clean up on internal flash
echo "Cleaning up on internal flash (if needed)..."
rm -rf /etc/AdGuardHome
rm -rf /root/AdGuardHome

# Optionally: remove DNS config if modified
# echo "Check /etc/config/dhcp if you changed DNS for AdGuard Home."

echo "AdGuard Home has been removed. A reboot is recommended." 