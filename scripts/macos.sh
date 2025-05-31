#!/bin/bash

echo "Setting up macOS..."

# Install XCode
echo "Installing XCode command line tools..."
xcode-select --install

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Brew Packages
echo "Installing brew packages..."
brew bundle install

echo "macOS setup completed!"
