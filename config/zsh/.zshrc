# Eval
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

# Aliases
alias lg=lazygit
alias ls='eza --icons=always'
alias ll='eza --icons=always --long'
alias la='eza --icons=always --long --all'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Environment
export TERM=xterm-256color

# Antigen
source ~/antigen.zsh

antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply
