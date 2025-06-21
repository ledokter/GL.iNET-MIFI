# Use an SD Card as Main Storage (Overlay) on GL.iNET MiFi (OpenWrt)

This guide explains how to use the `install_sd_overlay.sh` script to move the overlay (main storage) of a GL.iNET MiFi router to an SD card, allowing you to gain more space and install more packages.

## Prerequisites
- GL.iNET MiFi router (AR9330, OpenWrt)
- MicroSD card inserted and detected as `/dev/sda1`
- Root SSH access
- The `install_sd_overlay.sh` script copied to the router

## What the script does
- Installs required packages (USB support, ext4, block-mount, etc.)
- Formats the SD card as ext4 (**all data will be erased!**)
- Mounts the SD card on `/mnt/sda1`
- Copies the current overlay to the SD card
- Configures `/etc/config/fstab` to use the SD as overlay
- Automatically reboots the router

## Usage

1. **Copy the script to your router**
2. Make it executable:
   ```sh
   chmod +x install_sd_overlay.sh
   ```
3. Run it as root:
   ```sh
   sh install_sd_overlay.sh
   ```

The script does everything. After reboot, the available space will match the size of your SD card.

## Verification
After reboot, SSH into the router and type:
```sh
df -h
```
You should see `/dev/sda1` mounted on `/overlay` (or `overlayfs:/overlay`).

## Important Notes
- **Back up your important data before running this script!**
- Use a high-quality SD card to avoid corruption.
- If you want to revert, you will need to reconfigure the overlay to use the flash memory.

## Uninstall / Revert
1. Edit `/etc/config/fstab` to disable or remove the `overlay` section.
2. Reboot the router.
3. Delete the contents of `/mnt/sda1` if needed.

## Support
For any questions or issues, open a GitHub issue. 