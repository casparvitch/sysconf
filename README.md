# System Configuration for MNT Reform

This repository contains scripts and configuration for setting up a MNT Pocket Reform device with a minimal Debian install and a self-contained Wayland/Sway environment.

**Philosophy:** System-level stuff here, user customizations in your dotfiles.

## Prerequisites

- MNT Pocket Reform (or similar device)
- Fresh minimal Debian install
- Network access (USB-C tether to phone recommended for initial setup)

## WiFi Setup (Pocket Reform)

The Pocket Reform's WiFi requires firmware and a DKMS driver that are in backports and non-free-firmware repos:

```bash
# 1. Add required repos (trixie-backports and non-free-firmware)
echo "deb http://deb.debian.org/debian trixie-backports main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list.d/backports.list

# Update existing repos to include non-free-firmware if not present
sudo sed -i 's/main$/main contrib non-free non-free-firmware/' /etc/apt/sources.list

sudo apt update

# 2. Install driver and firmware
sudo apt install -t trixie-backports ezurio-qcacld-2.0-dkms ezurio-qca-firmware

# 3. Handle Secure Boot (if enabled)
# You may see a black/blank popup during install - this is a broken debconf
# dialog asking for MOK enrollment. If so, press Tab then Enter blindly,
# or run: sudo DEBIAN_FRONTEND=readline dpkg --configure -a

# 4. Reboot
sudo reboot

# After reboot, WiFi should appear as wlan0
ip link show
```

**Note:** The black popup during install is a known issue with the debconf dialog when Secure Boot is enabled. It's asking you to set a password for Machine Owner Key (MOK) enrollment. You can either:
- Disable Secure Boot in firmware (easiest)
- Complete MOK enrollment (enter password in the broken dialog, reboot, and follow the blue MOK enrollment screen)

## User Setup

If your user isn't in the sudo group (common after a debootstrap install):

```bash
# Replace 'yourusername' with your actual username
sudo usermod -aG sudo yourusername
# Log out and back in for group change to take effect
```

## Quick Start

```bash
# Get network via USB-C tether to phone, or configure wifi manually

# Clone this repo
git clone https://github.com/samsc/sysconf
cd sysconf

# Run complete setup
sudo make all

# Reboot and log in via tuigreet
sudo reboot
```

**Pocket Reform WiFi:** If WiFi doesn't work after reboot, see the [WiFi Setup](#wifi-setup-pocket-reform) section above.

## What Gets Installed

**Base System:**
- Hostname set to 'narsil'
- All packages from packages.txt (Sway, waybar, greetd, etc.)

**Display Manager:**
- greetd with tuigreet (TUI login)

**Window Manager:**
- Sway with minimal but functional configuration
- Waybar with: battery, WiFi, clock, system tray, power menu
- Brightness/volume keys work out of the box
- Screenshots (grim + slurp)

**No External Dependencies:**
- No reform-tools required
- No flatpak
- No external repos

## Post-Setup (Optional)

After the base system is working, you can layer your personal dotfiles on top:

```bash
# Clone your dotfiles
git clone https://github.com/yourusername/dotfiles ~/dotfiles
cd ~/dotfiles

# Apply your personal Sway/waybar config
stow sway waybar
```

Your dotfiles will override the base configs installed by sysconf.

## Individual Components

Run individual components if needed:

```bash
sudo make hostname    # Set hostname to 'narsil'
sudo make install     # Install all packages
sudo make greetd      # Set up greetd with tuigreet
sudo make sway        # Copy base Sway/waybar configs
sudo make mount UUID=<uuid>  # Mount secondary drive
```

## Drive Mounting

If you have a secondary drive:

```bash
blkid                                    # Find your UUID
sudo make mount UUID=<your-uuid>
```

## Troubleshooting

**No network after install:** The installer needs network to clone this repo. Use USB-C tether to phone, or manually configure wifi first.

**Reform-specific features missing:** The reform-tray is intentionally excluded. Battery and network are shown in waybar instead. Use the power menu in waybar (⏻) for shutdown/reboot/suspend.

## Structure

```
packages.txt              - Core packages list
scripts/
  install.sh              - Package installation
  greetd.sh               - Display manager setup
  sway.sh                 - Copy base Sway configs
  hostname.sh             - Set system hostname
  mount.sh                - Configure drive mounting
configs/
  sway/config             - Base Sway configuration
  waybar/config           - Waybar configuration (battery, network, power)
  waybar/style.css        - Waybar styling
  waybar/power-menu.txt   - Power menu options
```
