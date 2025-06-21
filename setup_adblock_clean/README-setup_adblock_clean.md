# Lightweight Ad Blocking for GL.iNET MiFi (OpenWrt)

This repository provides a simple and lightweight solution to block DNS-based ads on a GL.iNET MiFi router running OpenWrt, without AdGuard Home.

## Features
- Complete removal of AdGuard Home
- Ad blocking via dnsmasq with an up-to-date list (StevenBlack)
- Automatic list update every night via cron

## Provided Scripts

- `remove_adguardhome.sh`: completely removes AdGuard Home and its files
- `adblock_dnsmasq.sh`: installs and enables ad blocking via dnsmasq
- `install_adblock_cron.sh`: schedules automatic list updates every night at 3am
- `setup_adblock_clean.sh`: runs the three scripts above in order

## Quick Installation

1. **Copy all scripts to your router (in the same folder)**
2. Make them executable:
   ```sh
   chmod +x *.sh
   ```
3. Run the full setup:
   ```sh
   sh setup_adblock_clean.sh
   ```

## Details
- The blocklist comes from the [StevenBlack/hosts](https://github.com/StevenBlack/hosts) project
- Blocking is applied via dnsmasq (lightweight and native to OpenWrt)
- Automatic updates are scheduled every night at 3am (modifiable in the cron script)

## How to test if ad blocking works?

1. **DNS test from a device connected to the router**
   ```sh
   nslookup doubleclick.net
   ```
   **Expected result:**
   ```
   Name:   doubleclick.net
   Address: 0.0.0.0
   ```
   If you get a different address, ad blocking is not active.

2. **Browse ad-heavy websites**
   - Visit sites known for many ads (e.g., lemonde.fr, 20minutes.fr, jeuxvideo.com).
   - If most ad spaces are empty or missing, blocking works.

3. **Use an online adblock test tool**
   - [https://adblock-tester.com/](https://adblock-tester.com/)
   - [https://d3ward.github.io/toolz/adblock.html](https://d3ward.github.io/toolz/adblock.html)

## Troubleshooting

- **Blocking does not work (nslookup returns a real IP):**
  1. Check that `/etc/dnsmasq.d/adblock.conf` exists and contains lines like `address=/domain/0.0.0.0`.
  2. Check that `/etc/config/dhcp` contains:
     ```
     option confdir '/etc/dnsmasq.d'
     ```
     in the `config dnsmasq` section.
  3. Restart dnsmasq:
     ```sh
     /etc/init.d/dnsmasq restart
     ```
  4. Clear your device's DNS cache (toggle WiFi or reboot).
  5. Make sure your devices use the router as their main DNS server.

- **Still not blocking?**
  - Make sure you are not using an external DNS (Google, Cloudflare, etc.) on your devices.
  - Check the router's connectivity (blocking works locally even without Internet, but list updates require access).

- **WAN connection problem (udhcpc/no lease message)**
  - This means the router has no IP on its WAN interface, but local DNS blocking still works.
  - To fix, check WAN cable or WiFi client configuration.

## Uninstall
To remove ad blocking, simply delete `/etc/dnsmasq.d/adblock.conf` and restart dnsmasq:
```sh
rm /etc/dnsmasq.d/adblock.conf
/etc/init.d/dnsmasq restart
```

## Notes
- Tested on GL.iNET MiFi (Atheros AR9330, OpenWrt)
- Suitable for any OpenWrt router with dnsmasq
- Feel free to adapt the scripts to your needs

---

**Contact:** Open a GitHub issue for any questions or suggestions. 