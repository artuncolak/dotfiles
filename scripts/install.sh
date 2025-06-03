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

    # Install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc

    # oh-my-zsh plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # Install starship
    curl -sS https://starship.rs/install.sh | sh

    # Run stow
    chmod +x ./scripts/stow.sh
    ./scripts/stow.sh

    echo "Setup completed!"
}

main
