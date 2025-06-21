#!/bin/sh

# Script to clean AdGuard Home, enable dnsmasq ad blocking, automate updates, and whitelist Bugsnag
# Run as root

set -e

# 1. Completely remove AdGuard Home
sh remove_adguardhome.sh

# 2. Enable ad blocking via dnsmasq
sh adblock_dnsmasq.sh

# 3. Install the cron job for automatic updates
sh install_adblock_cron.sh

# 4. Whitelist Bugsnag for 100% score on web service tests
sh whitelist_bugsnag.sh

echo "\nSetup complete:\n- AdGuard Home removed\n- dnsmasq ad blocking enabled\n- Automatic update scheduled every night at 3am\n- Bugsnag whitelisted for 100% score on tests.\n" 