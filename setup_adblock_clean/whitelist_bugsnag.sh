#!/bin/sh

# Script to whitelist Bugsnag in dnsmasq on OpenWrt/GL.iNET MiFi
# Run as root

set -e

WHITELIST_FILE="/etc/dnsmasq.d/whitelist_bugsnag.conf"

# Add Bugsnag domains to the whitelist
cat > "$WHITELIST_FILE" <<EOF
server=/bugsnag.com/8.8.8.8
server=/notify.bugsnag.com/8.8.8.8
server=/app.bugsnag.com/8.8.8.8
EOF

echo "Bugsnag whitelist rules added to $WHITELIST_FILE."

# Restart dnsmasq
/etc/init.d/dnsmasq restart

echo "dnsmasq restarted. Please clear the DNS cache on your client devices." 