#!/bin/sh
# Set up greetd configuration

set -e

echo "Creating greetd configuration..."

# Create the greetd config directory if it doesn't exist
sudo mkdir -p /etc/greetd

# Create the config file
sudo tee /etc/greetd/config.toml > /dev/null << 'EOF'
# The VTGreetd will use.
# Default: 7
vt = 1

[terminal]
# The VTGreetd will use.
# Default: 7
vt = 1

[default_session]
# The user to autologin for.
# Default: null
# user = "your_username" # Uncomment and replace with your username for autologin

# The command to execute for the default session.
# This tells greetd to launch tuigreet.
command = "tuigreet --cmd sway"
EOF

echo "Enabling greetd service..."
sudo systemctl enable greetd

echo "greetd setup complete!"