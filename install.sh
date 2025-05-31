#!/bin/bash

echo "Starting setup..."

# Set Variables
OS=$(uname -s)
CONFIG_DIR="config"

# Source the config helper script
source ./scripts/config-helper.sh

# Function to install config files using GNU Stow
install_configs() {
    echo "Installing configuration files using GNU Stow..."
    cd "$CONFIG_DIR"

    # Stow each configuration directory
    for dir in */; do
        if [[ -d "$dir" ]]; then
            dir_name=${dir%/} # Remove trailing slash

            # Get target path from YAML config
            target_path=$(get_target_path "$dir_name" "$OS")

            echo "Stowing $dir_name to $target_path..."
            stow -t "$target_path" "$dir_name"
        fi
    done

    cd ..
    echo "Configuration files installed successfully!"
}

main() {
    case $OS in
    "Darwin")
        echo "Detected macOS"
        chmod +x scripts/macos.sh
        ./scripts/macos.sh
        ;;
    "Linux")
        echo "Detected Linux"
        chmod +x scripts/ubuntu.sh
        ./scripts/ubuntu.sh
        ;;
    *)
        echo "Unsupported operating system: $OS"
        exit 1
        ;;
    esac

    # Install antigen
    curl -L git.io/antigen > $HOME/antigen.zsh

    # Install starship
    curl -sS https://starship.rs/install.sh | sh

    # Install configuration files
    install_configs

    echo "Setup completed!"
}

main
