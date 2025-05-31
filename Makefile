.PHONY: install clean help

# Default target
help:
	@echo "Available targets:"
	@echo "  install  - Run the install script"
	@echo "  clean    - Clean up temporary files"
	@echo "  help     - Show this help message"

# Main install target that runs setup.sh
install:
	@echo "Running install script..."
	@chmod +x install.sh
	@./install.sh

# Clean target for cleanup
clean:
	@echo "Cleaning up temporary files..."
	@find . -name "*.tmp" -delete
	@find . -name ".DS_Store" -delete
