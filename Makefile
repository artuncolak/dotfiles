.PHONY: install setup link macos zsh docker help

# Default target
help:
	@echo "Available targets:"
	@echo "  setup    - Setup the environment"
	@echo "  install  - Install packages"
	@echo "  link     - Install configuration files with dotbot"
	@echo "  macos    - Run macOS script"
	@echo "  zsh      - Run zsh script"
	@echo "  docker   - Start docker services"
	@echo "  help     - Show this help message"

setup:
	@echo "Setting up environment..."
	@sudo -v
	$(MAKE) install
	$(MAKE) zsh
	$(MAKE) link
	$(MAKE) macos
	$(MAKE) docker

install:
	@echo "Running install script..."
	@chmod +x scripts/install.sh
	@./scripts/install.sh

link:
	@echo "Installing configuration files with dotbot..."
	@chmod +x scripts/link.sh
	@./scripts/link.sh

macos:
	@echo "Running macOS script..."
	@chmod +x scripts/macos.sh
	@./scripts/macos.sh

docker:
	@echo "Starting docker services..."
	@docker compose up -d

zsh:
	@echo "Running zsh script..."
	@chmod +x scripts/zsh.sh
	@sudo ./scripts/zsh.sh
