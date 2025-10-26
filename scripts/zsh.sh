#!/bin/bash

OH_MY_ZSH_DIR="$HOME/.config/omz"
OH_MY_ZSH_CUSTOM_DIR="$OH_MY_ZSH_DIR/custom"

# Check for Oh My Zsh and install if we don't have it
if [ ! -d "$OH_MY_ZSH_DIR" ]; then
    echo "Installing Oh My Zsh..."
    ZSH=$OH_MY_ZSH_DIR /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)" "" --keep-zshrc --unattended
else
    echo "Updating Oh My Zsh..."
    git -C "$OH_MY_ZSH_DIR" pull
fi

if [ ! -d "$OH_MY_ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $OH_MY_ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions
else
    echo "Updating zsh-autosuggestions..."
    git -C "$OH_MY_ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions" pull
fi

if [ ! -d "$OH_MY_ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OH_MY_ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting
else
    echo "Updating zsh-syntax-highlighting..."
    git -C "$OH_MY_ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting" pull
fi

# Check for Starship and install if we don't have it
if test ! $(which starship); then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "Starship already installed."
fi

# Check for tmux plugin manager and clone if we don't have it
TMUX_TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TMUX_TPM_DIR" ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm "$TMUX_TPM_DIR"
else
    echo "Updating tmux plugin manager..."
    git -C "$TMUX_TPM_DIR" pull
fi
