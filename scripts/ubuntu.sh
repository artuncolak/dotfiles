#!/bin/bash

echo "Setting up Ubuntu..."

# Update package list
echo "Updating package list..."
sudo apt update

# Install additional useful packages
echo "Installing packages..."
sudo apt install -y \
    yq stow \
    git \
    zsh

sudo chsh -s $(which zsh)

echo "Ubuntu setup completed!"
