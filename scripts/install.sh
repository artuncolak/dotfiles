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
    sudo -u $SUDO_USER NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

# Check for Oh My Zsh and install if we don't have it
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"

    # oh-my-zsh plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "Oh My Zsh already installed."
fi

# Check for Starship and install if we don't have it
if test ! $(which starship); then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "Starship already installed."
fi

# Update brew and install packages
sudo -u $SUDO_USER brew update
sudo -u $SUDO_USER brew bundle install

echo "Install Completed!"
