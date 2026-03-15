#!/bin/sh
set -e

MOUNT_POINT="/mnt/emmc_data"
FSTAB="/etc/fstab"

[ -n "$1" ] || { blkid; exit 1; }

UUID="$1"
mkdir -p "$MOUNT_POINT"

grep -q "UUID=$UUID" "$FSTAB" || \
    echo "UUID=$UUID $MOUNT_POINT ext4 defaults,nofail 0 2" >> "$FSTAB"

mount "$MOUNT_POINT" || exit 1
