#!/bin/sh
# Set up greetd configuration

set -e

echo "Creating greetd configuration..."

mkdir -p /etc/greetd

tee /etc/greetd/config.toml > /dev/null << 'EOF'
[terminal]
# The VT greetd will use
vt = 1

[default_session]
# The user to autologin for.
# Default: null
# user = "your_username" # Uncomment and replace with your username for autologin

# The command to execute for the default session.
# This tells greetd to launch tuigreet.
command = "tuigreet --cmd sway"
EOF

if [ ! -f /etc/greetd/config.toml ]; then
    echo "Error: Failed to create greetd config file"
    exit 1
fi

echo "Enabling greetd service..."
systemctl enable greetd

if ! systemctl is-enabled greetd > /dev/null 2>&1; then
    echo "Error: Failed to enable greetd service"
    exit 1
fi

echo "✓ greetd.sh complete"