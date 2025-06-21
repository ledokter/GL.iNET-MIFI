#!/bin/sh

# Script to enable ad blocking via dnsmasq on OpenWrt/GL.iNET MiFi
# Supports multiple Pi-hole/hosts blocklists
# Run as root

set -e

# dnsmasq config directory
DNSMASQ_DIR="/etc/dnsmasq.d"
BLOCKLIST_FILE="$DNSMASQ_DIR/adblock.conf"
DHCP_CONFIG="/etc/config/dhcp"

# List of blocklists (Pi-hole/hosts format)
BLOCKLISTS="
https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt
"

TMP_FILE="/tmp/all_hosts.txt"
> "$TMP_FILE"

# Create directory if needed
mkdir -p "$DNSMASQ_DIR"

# Ensure /etc/config/dhcp contains the confdir option
if ! grep -q "option confdir '/etc/dnsmasq.d'" "$DHCP_CONFIG"; then
    echo "Adding 'option confdir /etc/dnsmasq.d' to $DHCP_CONFIG..."
    uci add_list dhcp.@dnsmasq[0].confdir='/etc/dnsmasq.d'
    uci commit dhcp
fi

# Download and merge all blocklists
for url in $BLOCKLISTS; do
    echo "Downloading $url..."
    curl -fsSL "$url" >> "$TMP_FILE"
done

# Convert to dnsmasq format, remove comments, blank lines, and invalid entries
awk '($1=="0.0.0.0" && $2 ~ /^[a-zA-Z0-9.-]+$/) {print "address=/"$2"/0.0.0.0"}' "$TMP_FILE" | sort | uniq > "$BLOCKLIST_FILE"

# Show number of blocked domains
echo "Number of blocked domains: $(wc -l < "$BLOCKLIST_FILE")"

# Check if doubleclick.net is present in the blocklist
if grep -q "address=/doubleclick.net/0.0.0.0" "$BLOCKLIST_FILE"; then
    echo "doubleclick.net is present in the blocklist."
else
    echo "WARNING: doubleclick.net is NOT present in the blocklist!"
fi

# Restart dnsmasq to apply the list
echo "Restarting dnsmasq..."
/etc/init.d/dnsmasq restart

echo "Ad blocking enabled via dnsmasq with multiple Pi-hole blocklists!" 