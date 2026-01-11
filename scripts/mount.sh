#!/bin/sh
# Set up drive mounting for erebor

set -e

MOUNT_POINT="/mnt/emmc_data"
FSTAB="/etc/fstab"

echo "Setting up drive mounting..."

mkdir -p "$MOUNT_POINT"

if [ -z "$1" ]; then
    echo "Usage: $0 <UUID>"
    echo ""
    echo "Available block devices:"
    blkid
    echo ""
    echo "To mount a drive, run:"
    echo "  sudo $0 <UUID>"
    echo ""
    echo "Example:"
    echo "  sudo $0 12345678-1234-1234-1234-123456789012"
    exit 1
fi

UUID="$1"

if grep -q "UUID=$UUID" "$FSTAB"; then
    echo "UUID $UUID already configured in /etc/fstab"
else
    echo "Adding entry to /etc/fstab..."
    echo "UUID=$UUID $MOUNT_POINT ext4 defaults,nofail 0 2" >> "$FSTAB"
    echo "Entry added successfully"
fi

echo "Attempting to mount..."
if mount "$MOUNT_POINT"; then
    echo "Mount successful! Verifying:"
    df -h "$MOUNT_POINT"
else
    echo "Warning: Mount failed. Check blkid output and UUID."
    exit 1
fi