.PHONY: install setup link macos zsh help

# Default target
help:
	@echo "Available targets:"
	@echo "  setup    - Setup the environment"
	@echo "  install  - Install packages"
	@echo "  link     - Install configuration files with dotbot"
	@echo "  macos    - Run macOS script"
	@echo "  zsh      - Run zsh script"
	@echo "  help     - Show this help message"

setup:
	@echo "Setting up environment..."
	@sudo -v
	$(MAKE) install
	$(MAKE) zsh
	$(MAKE) link
	$(MAKE) macos

install:
	@echo "Running install script..."
	@chmod +x scripts/install.sh
	@./scripts/install.sh

link:
	@echo "Installing configuration files with dotbot..."
	@chmod +x scripts/link.sh
	@sudo ./scripts/link.sh

macos:
	@echo "Running macOS script..."
	@chmod +x scripts/macos.sh
	@./scripts/macos.sh

zsh:
	@echo "Running zsh script..."
	@chmod +x scripts/zsh.sh
	@sudo ./scripts/zsh.sh