#!/bin/bash

echo "Starting setup..."

# Set Variables
OS=$(uname -s)

main() {
    case $OS in
    "Darwin")
        echo "Detected macOS"
        chmod +x ./scripts/macos.sh
        ./scripts/macos.sh
        ;;
    "Linux")
        echo "Detected Linux"
        chmod +x ./scripts/ubuntu.sh
        ./scripts/ubuntu.sh
        ;;
    *)
        echo "Unsupported operating system: $OS"
        exit 1
        ;;
    esac

    # Install antigen
    curl -L git.io/antigen >$HOME/.antigen.zsh

    # Install starship
    curl -sS https://starship.rs/install.sh | sh

    # Run stow
    chmod +x ./scripts/stow.sh
    ./scripts/stow.sh

    echo "Setup completed!"
}

main
