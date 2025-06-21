#!/bin/sh

# Script: ftth.sh
# Usage: sh ftth.sh
# Description: Backup current network config, apply VLAN 100 DHCP on WAN (for FTTH/Fibre), test for 5 min, and ask user to keep or restore.

set -e

BACKUP_DIR="/root/network_backup_$(date +%Y%m%d_%H%M%S)"

echo "Saving current network configuration to $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"
cp /etc/config/network "$BACKUP_DIR/network"
cp /etc/config/wireless "$BACKUP_DIR/wireless" 2>/dev/null || true
cp /etc/config/dhcp "$BACKUP_DIR/dhcp"

# Apply new config: WAN on VLAN 100, DHCP
echo "Applying new network configuration: WAN on VLAN 100 (eth0.100), DHCP client..."
uci set network.wan.ifname='eth0.100'
uci set network.wan.proto='dhcp'
uci commit network

/etc/init.d/network restart

echo "New configuration applied. You have 5 minutes to test connectivity."
echo "If you lose access, reboot the router to restore the backup manually."
sleep 300

echo
read -p "Do you want to KEEP the new configuration? (y/n): " answer

if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    echo "New configuration kept."
else
    echo "Restoring previous configuration..."
    cp "$BACKUP_DIR/network" /etc/config/network
    [ -f "$BACKUP_DIR/wireless" ] && cp "$BACKUP_DIR/wireless" /etc/config/wireless
    cp "$BACKUP_DIR/dhcp" /etc/config/dhcp
    /etc/init.d/network restart
    echo "Previous configuration restored."
fi 