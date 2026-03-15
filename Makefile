# sysconf
.PHONY: all install greetd mount hostname sway clean help

all: hostname install greetd sway

install:
	./scripts/install.sh

greetd: install
	./scripts/greetd.sh

mount:
	@if [ -z "$(UUID)" ]; then \
		echo "UUID=<uuid> required"; \
		exit 1; \
	fi
	./scripts/mount.sh $(UUID)

hostname:
	./scripts/hostname.sh

sway: install
	./scripts/sway.sh

clean:
	rm -f /tmp/sysconf_*

help:
	@echo "all install greetd hostname sway mount clean"
