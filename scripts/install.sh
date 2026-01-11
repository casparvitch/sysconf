#!/bin/sh
# Package installation script for Reform device

set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PACKAGES_FILE="$SCRIPT_DIR/../packages.txt"

if [ ! -f "$PACKAGES_FILE" ]; then
    echo "Error: packages.txt not found at $PACKAGES_FILE"
    exit 1
fi

echo "Updating system packages..."
apt update && apt upgrade -y

echo "Installing packages from list..."
xargs -a "$PACKAGES_FILE" apt install -y

echo "Verifying package installation..."
MISSING_PACKAGES=""
while IFS= read -r package; do
    if ! dpkg -l | grep -q "^ii.*$package"; then
        MISSING_PACKAGES="$MISSING_PACKAGES $package"
    fi
done < "$PACKAGES_FILE"

if [ -n "$MISSING_PACKAGES" ]; then
    echo "Warning: Some packages failed to install:$MISSING_PACKAGES"
    exit 1
fi

echo "✓ install.sh complete"