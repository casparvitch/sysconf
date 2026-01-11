#!/bin/sh
# Set up drive mounting for erebor

set -e

echo "Setting up drive mounting..."

# Create mount point if it doesn't exist
sudo mkdir -p /mnt/emmc_data

echo "To complete drive setup, you'll need to:"
echo "1. Find the UUID of your drive:"
echo "   sudo blkid"
echo ""
echo "2. Edit /etc/fstab and add:"
echo "   UUID=<YOUR_UUID_HERE> /mnt/emmc_data ext4 defaults,nofail 0 2"
echo ""
echo "3. Verify the mount works:"
echo "   df -h /mnt/emmc_data"
echo ""
echo "Would you like me to help you find the UUID now? (y/n)"
read -r response

if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
    echo "Available block devices:"
    sudo blkid
    
    echo ""
    echo "Enter the UUID for your erebor drive:"
    read -r uuid
    
    if [ -n "$uuid" ]; then
        echo "Adding entry to /etc/fstab..."
        echo "UUID=$uuid /mnt/emmc_data ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
        
        echo "Attempting to mount..."
        sudo mount /mnt/emmc_data
        echo "Mount complete! Verifying:"
        df -h /mnt/emmc_data
    fi
fi

echo "Drive mounting setup complete!"