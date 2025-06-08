#!/bin/bash

# Install XCode
if ! xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools not found. Installing..."
    xcode-select --install
else
    echo "Xcode Command Line Tools already installed."
fi

# Check for Battery and install if we don't have it
if test ! $(which battery); then
    echo "Installing Battery..."
    curl -s https://raw.githubusercontent.com/actuallymentor/battery/main/setup.sh | bash
else
    echo "Battery already installed."
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed."
fi

# Update brew and install packages
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew bundle install

echo "Install Completed!"
