# Bugsnag Whitelist for dnsmasq (OpenWrt/GL.iNET MiFi)

This script adds a whitelist exception for Bugsnag domains in your dnsmasq configuration on OpenWrt/GL.iNET MiFi routers. This allows Bugsnag to work even if you use DNS adblocking.

## Purpose
- Allows Bugsnag (error monitoring) to work even with DNS adblocking enabled.
- Useful to achieve a 100% score on web service testing tools.

## Usage
1. Copy the `whitelist_bugsnag.sh` script to your router.
2. Make it executable:
   ```sh
   chmod +x whitelist_bugsnag.sh
   ```
3. Run it as root:
   ```sh
   sh whitelist_bugsnag.sh
   ```
4. Restart your client devices or clear their DNS cache to apply the changes.

## Details
- The script creates `/etc/dnsmasq.d/whitelist_bugsnag.conf` with the whitelist rules for Bugsnag.
- It automatically restarts dnsmasq.

## Uninstall
Delete the whitelist file and restart dnsmasq:
```sh
rm /etc/dnsmasq.d/whitelist_bugsnag.conf
/etc/init.d/dnsmasq restart
``` 