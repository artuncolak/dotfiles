#  ~/.zshenv
# Core envionmental variables

# Set XDG directories
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_LIB_HOME="${HOME}/.local/lib"
export XDG_CACHE_HOME="${HOME}/.cache"

# Respect XDG directories
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

# Set default applications
export EDITOR="cursor"
