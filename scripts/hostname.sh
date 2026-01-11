#!/bin/sh
# Set hostname to 'narsil'

set -e

echo "Setting hostname to 'narsil'..."

# Update /etc/hostname
echo "narsil" > /etc/hostname

# Update /etc/hosts - handle existing or missing 127.0.1.1 line
if grep -q "127.0.1.1" /etc/hosts; then
    if ! grep -q "127.0.1.1.*narsil" /etc/hosts; then
        sed -i 's/127.0.1.1.*/127.0.1.1\tnarsil/' /etc/hosts
        echo "Updated existing 127.0.1.1 entry in /etc/hosts"
    else
        echo "Hostname already configured in /etc/hosts"
    fi
else
    echo "127.0.1.1	narsil" >> /etc/hosts
    echo "Added 127.0.1.1 entry to /etc/hosts"
fi

if [ "$(cat /etc/hostname)" != "narsil" ]; then
    echo "Error: Failed to set hostname"
    exit 1
fi

echo "✓ hostname.sh complete"