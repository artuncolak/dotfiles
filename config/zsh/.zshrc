# Eval
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

# Aliases
alias lg=lazygit
alias ls='eza --icons=always'
alias ll='eza --icons=always --long'
alias la='eza --icons=always --long --all'
alias vi='nvim'
alias vim='nvim'
alias cat='bat --color=always --style=plain'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Environment
export TERM=xterm-256color

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Functions

# Fuzzy search through command history with Ctrl+R
if [[ ! "$terminfo[kcuu1]" ]]; then
    bindkey '^R' fzf-history-widget
fi

fzf-history-widget() {
    local selected_command=$(fc -l 1 | fzf --height 50% --reverse --tac | sed -E 's/ *[0-9]+\*? +//')
    LBUFFER="$selected_command"
    zle redisplay
}
zle -N fzf-history-widget

bindkey '^o' fzf-cd-widget

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Antigen
source ~/.antigen.zsh

antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply
