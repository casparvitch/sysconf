# System Configuration for Reform Device

This repository contains scripts and configuration for setting up a Reform device with a minimal Debian install and custom Wayland/Sway environment.

## Structure

- `packages.txt` - List of all packages to install
- `scripts/install.sh` - Installs all packages from the list
- `scripts/greetd.sh` - Sets up greetd with tuigreet login manager
- `scripts/mount.sh` - Helps configure drive mounting for the secondary drive
- `Makefile` - Orchestrates the entire setup process

## Usage

After a fresh minimal Debian install:

```bash
# Run complete setup
make all

# Or run individual components
make install    # Install all packages
make greetd     # Set up greetd
make mount      # Configure drive mounting
```

## Components

### Package Installation
All packages are listed in `packages.txt` and installed via `xargs` for clean organization.

### Display Manager
Uses greetd with tuigreet for a minimal TUI login manager that launches Sway.

### Drive Mounting
Automatically sets up mount point and helps configure `/etc/fstab` for the secondary "erebor" drive.

## Post-Setup

After running the setup:
1. Configure your Sway settings (`~/.config/sway/config`)
2. Set up Waybar configuration if using it
3. Customize any other user-specific settings