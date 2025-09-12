#!/bin/bash

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed."
fi

# Update brew and install packages
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew bundle install

# Run docker compose
docker compose up -d

echo "Install Completed!"
