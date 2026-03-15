#!/bin/sh
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PACKAGES_FILE="$SCRIPT_DIR/../packages.txt"

[ -f "$PACKAGES_FILE" ] || { echo "packages.txt not found"; exit 1; }

apt update && apt upgrade -y
xargs -a "$PACKAGES_FILE" apt install -y

MISSING=""
while IFS= read -r package; do
    dpkg -l | grep -q "^ii.*$package" || MISSING="$MISSING $package"
done < "$PACKAGES_FILE"

[ -z "$MISSING" ] || { echo "Failed: $MISSING"; exit 1; }
