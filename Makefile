.PHONY: install stow help

# Default target
help:
	@echo "Available targets:"
	@echo "  install  - Run the install script"
	@echo "  stow     - Install configuration files with GNU Stow"
	@echo "  help     - Show this help message"

# Main install target that runs install script via run.sh
install:
	@echo "Running install script..."
	@chmod +x run.sh
	@./run.sh install

# Stow target for configuration files via run.sh
stow:
	@echo "Installing configuration files with GNU Stow..."
	@chmod +x run.sh
	@./run.sh stow
