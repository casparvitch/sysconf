#!/bin/sh
set -e

id "greetd" >/dev/null 2>&1 || \
    useradd -r -s /usr/sbin/nologin -c "greetd user" -d /var/lib/greetd greetd

id "greeter" >/dev/null 2>&1 || \
    useradd -r -s /usr/sbin/nologin -c "Greeter user" -d /var/lib/greetd greeter

mkdir -p /etc/greetd

cat > /etc/greetd/config.toml << 'EOF'
[terminal]
vt = 2

[default_session]
command = "tuigreet --time --cmd sway"
user = "greeter"
EOF

systemctl mask getty@tty2.service

grep -q "console=tty1" /proc/cmdline 2>/dev/null || \
    echo "Warning: add 'console=tty1' to kernel params"

usermod -a -G video greeter 2>/dev/null || true
usermod -a -G input greeter 2>/dev/null || true
usermod -a -G seat greeter 2>/dev/null || true

[ -f /etc/greetd/config.toml ] || exit 1

systemctl enable greetd
systemctl is-enabled greetd > /dev/null 2>&1 || exit 1
