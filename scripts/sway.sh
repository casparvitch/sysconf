#!/bin/sh
set -e

USERNAME="samsc"
USER_HOME="/home/$USERNAME"
SWAY_CONFIG_DIR="$USER_HOME/.config/sway"
WAYBAR_CONFIG_DIR="$USER_HOME/.config/waybar"
MAKO_CONFIG_DIR="$USER_HOME/.config/mako"
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
CONFIGS_DIR="$SCRIPT_DIR/../configs"

mkdir -p "$SWAY_CONFIG_DIR" "$WAYBAR_CONFIG_DIR" "$MAKO_CONFIG_DIR"
chown "$USERNAME:$USERNAME" "$SWAY_CONFIG_DIR" "$WAYBAR_CONFIG_DIR" "$MAKO_CONFIG_DIR"

cp "$CONFIGS_DIR/sway/config" "$SWAY_CONFIG_DIR/config"
cp "$CONFIGS_DIR/sway/wp.jpg" "$SWAY_CONFIG_DIR/wp.jpg"
chown "$USERNAME:$USERNAME" "$SWAY_CONFIG_DIR/config" "$SWAY_CONFIG_DIR/wp.jpg"

cp "$CONFIGS_DIR/waybar/config" "$WAYBAR_CONFIG_DIR/config"
cp "$CONFIGS_DIR/waybar/style.css" "$WAYBAR_CONFIG_DIR/style.css"
cp "$CONFIGS_DIR/waybar/power-menu.txt" "$WAYBAR_CONFIG_DIR/power-menu.txt"
chown "$USERNAME:$USERNAME" "$WAYBAR_CONFIG_DIR/config" "$WAYBAR_CONFIG_DIR/style.css" "$WAYBAR_CONFIG_DIR/power-menu.txt"

cp "$CONFIGS_DIR/mako/config" "$MAKO_CONFIG_DIR/config"
chown "$USERNAME:$USERNAME" "$MAKO_CONFIG_DIR/config"
