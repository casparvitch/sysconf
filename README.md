# sysconf

System configuration for MNT Pocket Reform. Minimal Debian, Wayland/Sway.

System-level only. User customizations in dotfiles.

## Requirements

- MNT Pocket Reform (or compatible)
- Minimal Debian install
- Network access

## WiFi Setup

Pocket Reform WiFi requires backports and non-free-firmware:

```bash
echo "deb http://deb.debian.org/debian trixie-backports main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list.d/backports.list
sudo sed -i 's/main$/main contrib non-free non-free-firmware/' /etc/apt/sources.list
sudo apt update
sudo apt install -t trixie-backports ezurio-qcacld-2.0-dkms ezurio-qca-firmware
sudo reboot
```

Secure Boot: MOK enrollment prompt may render blank. Tab+Enter, or: `sudo DEBIAN_FRONTEND=readline dpkg --configure -a`

## Install

```bash
git clone https://github.com/samsc/sysconf
cd sysconf
sudo make all
sudo reboot
```

## Targets

```
all       hostname, install, greetd, sway
install   packages from packages.txt
greetd    display manager with tuigreet
hostname  set to 'narsil'
sway      base Sway/waybar configs
mount     secondary drive (UUID= required)
clean     remove temp files
```

## Post-Install

Layer dotfiles on top:

```bash
cd ~/dotfiles
stow sway waybar
```

## Drive Mounting

```bash
blkid
sudo make mount UUID=<uuid>
```
