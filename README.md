# System Configuration for MNT Reform

This repository contains scripts and configuration for setting up a MNT Pocket Reform device with a minimal Debian install and a self-contained Wayland/Sway environment.

**Philosophy:** System-level stuff here, user customizations in your dotfiles.

## Prerequisites

- MNT Pocket Reform (or similar device)
- Fresh minimal Debian install
- Network access (USB-C tether to phone recommended for initial setup)

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
