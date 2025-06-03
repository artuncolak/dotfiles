export TERM=xterm-256color
export ZSH="$HOME/.oh-my-zsh"
export DOTFILES_DIR="$HOME/.dotfiles"

eval "$(fnm env --use-on-cd --shell zsh)"

plugins=(
    starship
    git
    sudo
    zsh-interactive-cd
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Aliases
# Development tools
alias lg=lazygit
alias vi='nvim'
alias vim='nvim'
alias dotfiles='git -C $DOTFILES_DIR'
alias dotfiles-go='cd $DOTFILES_DIR'

# Enhanced ls commands with eza
alias ls='eza --icons=always'
alias ll='ls -l'
alias la='ls -la'
alias ldot='ls -ld .*'

# Better cat with syntax highlighting
alias cat='bat --color=always --style=plain'

source <(fzf --zsh)

fzf-history-widget() {
    local selected_command=$(fc -l 1 | fzf --height 50% --reverse --tac | sed -E 's/ *[0-9]+\*? +//')
    LBUFFER="$selected_command"
    zle redisplay
}
zle -N fzf-history-widget

if [[ ! "$terminfo[kcuu1]" ]]; then
    bindkey '^R' fzf-history-widget
fi

bindkey '^o' fzf-cd-widget

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# History options
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first
setopt HIST_IGNORE_DUPS       # Don't record duplicate entries
setopt HIST_IGNORE_ALL_DUPS   # Delete old duplicate entries
setopt HIST_IGNORE_SPACE      # Don't record entries starting with space
setopt HIST_FIND_NO_DUPS      # Don't display duplicates during search
setopt HIST_SAVE_NO_DUPS      # Don't save duplicates
