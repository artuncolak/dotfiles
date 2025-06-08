#!/bin/bash

# Install XCode
if ! xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools not found. Installing..."
    xcode-select --install
else
    echo "Xcode Command Line Tools already installed."
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed."
fi

# Check for Battery and install if we don't have it
if test ! $(which battery); then
    echo "Installing Battery..."
    curl -s https://raw.githubusercontent.com/actuallymentor/battery/main/setup.sh | bash
else
    echo "Battery already installed."
fi

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

# Update brew and install packages
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew bundle install

echo "Install Completed!"
