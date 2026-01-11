#!/bin/sh
# Package installation script for Reform device

set -e

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing packages from list..."
sudo xargs -a ../packages.txt apt install -y

echo "Package installation complete!"