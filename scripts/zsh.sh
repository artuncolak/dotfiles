#!/bin/bash

OH_MY_ZSH_DIR="$HOME/.config/omz"
OH_MY_ZSH_CUSTOM_DIR="$OH_MY_ZSH_DIR/custom"

# Check for Oh My Zsh and install if we don't have it
if [ ! -d "$OH_MY_ZSH_DIR" ]; then
    echo "Installing Oh My Zsh..."
    ZSH=$OH_MY_ZSH_DIR /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)" "" --keep-zshrc --unattended
else
    echo "Oh My Zsh already installed."
fi

if [ ! -d "$OH_MY_ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $OH_MY_ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions
fi
if [ ! -d "$OH_MY_ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OH_MY_ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting
fi

# Check for Starship and install if we don't have it
if test ! $(which starship); then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "Starship already installed."
fi
