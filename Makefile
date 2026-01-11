# System setup for Reform device
.PHONY: all install greetd mount hostname sway clean help

# Default target with explicit dependencies
all: hostname install greetd sway
	@echo ""
	@echo "✓ Setup complete!"
	@echo "  Run: sudo reboot"

# Install all required packages
install:
	@echo "Installing packages..."
	./scripts/install.sh

# Set up greetd configuration (depends on install)
greetd: install
	@echo "Setting up greetd..."
	./scripts/greetd.sh

# Set up drive mounting (manual, not part of 'all')
mount:
	@echo "Setting up drive mounting..."
	@if [ -z "$(UUID)" ]; then \
		echo "Error: UUID required. Usage: sudo make mount UUID=<your-uuid>"; \
		exit 1; \
	fi
	./scripts/mount.sh $(UUID)

# Set up hostname (should run first)
hostname:
	@echo "Setting hostname..."
	./scripts/hostname.sh

# Set up Sway (depends on install)
sway: install
	@echo "Setting up Sway..."
	./scripts/sway.sh

# Clean up any temporary files
clean:
	@echo "Cleaning up..."
	rm -f /tmp/sysconf_*

# Display help
help:
	@echo "Available targets (must run as root with 'sudo make'):"
	@echo ""
	@echo "  all      - Run complete setup (hostname, install, greetd, sway)"
	@echo "  install  - Install all packages"
	@echo "  greetd   - Set up greetd configuration"
	@echo "  hostname - Set hostname to 'narsil'"
	@echo "  sway     - Set up basic Sway configuration"
	@echo ""
	@echo "  mount    - Set up drive mounting (manual)"
	@echo "            Usage: sudo make mount UUID=<your-uuid>"
	@echo ""
	@echo "  clean    - Clean up temporary files"
	@echo "  help     - Show this help"