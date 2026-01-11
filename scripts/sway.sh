#!/bin/sh
# Set up Sway and Waybar configuration

set -e

USERNAME="samsc"
USER_HOME="/home/$USERNAME"
SWAY_CONFIG_DIR="$USER_HOME/.config/sway"
WAYBAR_CONFIG_DIR="$USER_HOME/.config/waybar"
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
CONFIGS_DIR="$SCRIPT_DIR/../configs"

echo "Setting up Sway and Waybar configuration for user $USERNAME..."

mkdir -p "$SWAY_CONFIG_DIR" "$WAYBAR_CONFIG_DIR"
chown "$USERNAME:$USERNAME" "$SWAY_CONFIG_DIR" "$WAYBAR_CONFIG_DIR"

echo "Copying Sway config..."
cp "$CONFIGS_DIR/sway/config" "$SWAY_CONFIG_DIR/config"
chown "$USERNAME:$USERNAME" "$SWAY_CONFIG_DIR/config"
echo "Copied sway config to $SWAY_CONFIG_DIR/config"

echo "Copying Waybar config..."
cp "$CONFIGS_DIR/waybar/config" "$WAYBAR_CONFIG_DIR/config"
cp "$CONFIGS_DIR/waybar/style.css" "$WAYBAR_CONFIG_DIR/style.css"
cp "$CONFIGS_DIR/waybar/power-menu.txt" "$WAYBAR_CONFIG_DIR/power-menu.txt"
chown "$USERNAME:$USERNAME" "$WAYBAR_CONFIG_DIR/config" "$WAYBAR_CONFIG_DIR/style.css" "$WAYBAR_CONFIG_DIR/power-menu.txt"
echo "Copied waybar config, style, and power-menu to $WAYBAR_CONFIG_DIR"

echo "✓ sway.sh complete"
