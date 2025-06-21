# OpenWrt GL.iNET MiFi Ad Block Fiber & SD Overlay Scripts

[![Shell](https://img.shields.io/badge/language-shell-blue.svg)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![OpenWrt](https://img.shields.io/badge/OpenWrt-Compatible-brightgreen)](https://openwrt.org/)

> **Powerful ad blocking, FTTH mod and SD card overlay scripts for GL.iNET MiFi routers running OpenWrt. Block ads at the DNS level and expand your router's storage with ease!**

---

## Table of Contents
- [Features](#features)
- [Compatibility](#compatibility)
- [Installation](#installation)
- [Usage](#usage)
- [FTTH/Fibre Setup](#ftthfibre-setup)
- [How to Test Ad Blocking](#how-to-test-ad-blocking)
- [Troubleshooting](#troubleshooting)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)
- [Links & Resources](#links--resources)

---

## Features
- **DNS-level ad blocking** using dnsmasq and the StevenBlack hosts list
- **Automatic adblock list updates** via cron
- **SD card overlay**: use your SD card as main storage for more packages
- **Easy AdGuard Home removal**
- **Bugsnag whitelisting** for 100% on web service tests
- **Self-healing adblock config**: the adblock script automatically checks and fixes dnsmasq configuration to ensure blocking works, even after a system restore or SD card corruption
- **FTTH/Fibre auto-config script**: easily test and apply VLAN 100 DHCP WAN config for Bouygues/Orange/Free fibre
- Lightweight, fast, and designed for OpenWrt/GL.iNET MiFi

## Compatibility
- Tested on **GL.iNET MiFi (Atheros AR9330, OpenWrt)**
- Should work on any OpenWrt router with dnsmasq and SD card support

## Installation
1. **Clone or download this repository**
2. **Copy all scripts to your router (same folder)**
3. **Make scripts executable:**
   ```sh
   chmod +x *.sh
   ```

## Usage
- **Enable SD card overlay:**
  ```sh
  sh install_sd_overlay.sh
  ```
- **Enable ad blocking and automation:**
  ```sh
  sh setup_adblock_clean.sh
  ```
- **Whitelist Bugsnag (for 100% on tests):**
  ```sh
  sh whitelist_bugsnag.sh
  ```

## FTTH/Fibre Setup
- **Test and apply VLAN 100 DHCP WAN config (for Bouygues/Orange/Free fibre):**
  ```sh
  sh Fibre/ftth.sh
  ```
  This script will:
  - Backup your current network configuration
  - Apply the standard FTTH config (WAN on VLAN 100, DHCP client)
  - Give you 5 minutes to test connectivity
  - Ask if you want to keep the new config or restore the previous one
  - Safe: if you lose access, reboot and restore manually from the backup

## How to Test Ad Blocking
- Run on a client device:
  ```sh
  nslookup doubleclick.net
  ```
  **Expected:** `Address: 0.0.0.0`
- Visit ad-heavy sites (e.g., lemonde.fr, 20minutes.fr)
- Use online testers:
  - [adblock-tester.com](https://adblock-tester.com/)
  - [d3ward.github.io/toolz/adblock.html](https://d3ward.github.io/toolz/adblock.html)

## Troubleshooting
- **Blocking not working?**
  - Run the adblock script again: it will automatically check and fix the dnsmasq configuration.
  - Check `/etc/dnsmasq.d/adblock.conf` exists and is populated
  - Ensure `/etc/config/dhcp` contains: `option confdir '/etc/dnsmasq.d'` (the script will add it if missing)
  - Restart dnsmasq: `/etc/init.d/dnsmasq restart`
  - Clear DNS cache on your device
  - Make sure your device uses the router as DNS
- **Still not blocking?**
  - Check for external DNS (Google, Cloudflare) on your device
  - Check router connectivity (blocking works locally even without WAN)
- **WAN issues (udhcpc/no lease)?**
  - Check WAN cable or WiFi client config

## Screenshots
<!-- Add screenshots or GIFs here for better SEO and user understanding -->

## Contributing
Pull requests and issues are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License
[MIT](LICENSE)

## Links & Resources
- [OpenWrt Official Documentation](https://openwrt.org/docs/start)
- [GL.iNET Official Site](https://www.gl-inet.com/)
- [StevenBlack/hosts](https://github.com/StevenBlack/hosts)
- [OpenWrt Forum](https://forum.openwrt.org/)

---

openwrt, gl-inet, mifi, adblock, dnsmasq, sd card, overlay, router, block ads, shell script, linux, ftth, fibre

