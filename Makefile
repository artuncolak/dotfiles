.PHONY: install stow help

# Default target
help:
	@echo "Available targets:"
	@echo "  setup    - Setup the environment"
	@echo "  install  - Install packages"
	@echo "  link     - Install configuration files with dotbot"
	@echo "  help     - Show this help message"

setup:
	@echo "Setting up environment..."
	$(MAKE) install
	$(MAKE) link
	$(MAKE) macos

# Main install target that runs install script via run.sh
install:
	@echo "Running install script..."
	@chmod +x scripts/install.sh
	@./scripts/install.sh

# Stow target for configuration files via run.sh
link:
	@echo "Installing configuration files with dotbot..."
	@chmod +x scripts/link.sh
	@sudo ./scripts/link.sh

macos:
	@echo "Running macOS script..."
	@chmod +x scripts/macos.sh
	@./scripts/macos.sh