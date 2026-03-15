#!/bin/sh
# Set up greetd configuration

set -e

echo "Setting up greetd..."

# Create greetd user if it doesn't exist (for the daemon)
if ! id "greetd" >/dev/null 2>&1; then
    echo "Creating greetd user..."
    useradd -r -s /usr/sbin/nologin -c "greetd user" -d /var/lib/greetd greetd
fi

# Create greeter user if it doesn't exist (for the session)
if ! id "greeter" >/dev/null 2>&1; then
    echo "Creating greeter user..."
    useradd -r -s /usr/sbin/nologin -c "Greeter user" -d /var/lib/greetd greeter
fi

# Create config directory
mkdir -p /etc/greetd

# Write greetd config - use VT2, keep VT1 for boot logs
# Requires kernel param: console=tty1
# See: https://wiki.archlinux.org/title/Greetd
cat > /etc/greetd/config.toml << 'EOF'
[terminal]
vt = 2

[default_session]
command = "tuigreet --time --cmd sway"
user = "greeter"
EOF

# Disable getty on tty2 so it doesn't fight with greetd
echo "Disabling getty@tty2.service..."
systemctl mask getty@tty2.service

# Check for kernel param (warn if missing)
if ! grep -q "console=tty1" /proc/cmdline 2>/dev/null; then
    echo "WARNING: Add 'console=tty1' to kernel parameters to keep boot logs on VT1"
    echo "Edit /etc/default/grub: GRUB_CMDLINE_LINUX_DEFAULT="... console=tty1""
fi

# Add greeter user to required groups for graphics/input access
usermod -a -G video greeter 2>/dev/null || true
usermod -a -G input greeter 2>/dev/null || true
usermod -a -G seat greeter 2>/dev/null || true

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
