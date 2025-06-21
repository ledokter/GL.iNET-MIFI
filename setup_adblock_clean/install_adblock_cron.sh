#!/bin/sh

# Script to install a cron job that updates the adblock list every day at 3am
# Run as root

set -e

# Path to the adblock script
ADBLOCK_SCRIPT="/root/adblock_dnsmasq.sh"

# Copy the adblock script to the expected location if needed
if [ ! -f "$ADBLOCK_SCRIPT" ]; then
    echo "Copying adblock_dnsmasq.sh to /root..."
    cp adblock_dnsmasq.sh "$ADBLOCK_SCRIPT"
    chmod +x "$ADBLOCK_SCRIPT"
fi

# Add the crontab line if it doesn't already exist
CRON_LINE="0 3 * * * /bin/sh /root/adblock_dnsmasq.sh >> /root/adblock_update.log 2>&1"
CRON_FILE="/etc/crontabs/root"

grep -F "$CRON_LINE" "$CRON_FILE" 2>/dev/null || echo "$CRON_LINE" >> "$CRON_FILE"

# Restart the cron service to apply the change
/etc/init.d/cron restart

echo "Cron job installed to update the adblock list every day at 3am." 