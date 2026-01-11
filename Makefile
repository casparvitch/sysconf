# System setup for Reform device
.PHONY: all install greetd mount clean help

# Default target
all: greetd install mount

# Install all required packages
install:
	@echo "Installing packages..."
	./scripts/install.sh

# Set up greetd configuration
greetd:
	@echo "Setting up greetd..."
	./scripts/greetd.sh

# Set up drive mounting
mount:
	@echo "Setting up drive mounting..."
	./scripts/mount.sh

# Clean up any temporary files
clean:
	@echo "Cleaning up..."
	rm -f /tmp/sysconf_*

# Display help
help:
	@echo "Available targets:"
	@echo "  all     - Run complete setup (greetd, install, mount)"
	@echo "  install - Install all packages"
	@echo "  greetd  - Set up greetd configuration"
	@echo "  mount   - Set up drive mounting"
	@echo "  clean   - Clean up temporary files"
	@echo "  help    - Show this help"