export DOTFILES_DIR="$HOME/.dotfiles"

# Aliases
# Development tools
alias lg=lazygit
alias vi='nvim'
alias vim='nvim'
alias dotfiles='git -C $DOTFILES_DIR'
alias dotfiles-go='cd $DOTFILES_DIR'

# Enhanced ls commands with eza
alias ls='eza --icons=always'
alias ll='eza --icons=always -l'
alias la='eza --icons=always -la'
alias ldot='eza --icons=always -ld .*'

# Better cat with syntax highlighting
alias cat='bat --color=always --style=plain'
