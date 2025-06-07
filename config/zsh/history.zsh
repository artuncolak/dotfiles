fzf-history-widget() {
    local selected_command=$(fc -l 1 | fzf --height 50% --reverse --tac | sed -E 's/ *[0-9]+\*? +//')
    LBUFFER="$selected_command"
    zle redisplay
}
zle -N fzf-history-widget

if [[ ! "$terminfo[kcuu1]" ]]; then
    bindkey '^R' fzf-history-widget
fi

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$ZDOTDIR/.zsh_history

# History options
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first
setopt HIST_IGNORE_DUPS       # Don't record duplicate entries
setopt HIST_IGNORE_ALL_DUPS   # Delete old duplicate entries
setopt HIST_IGNORE_SPACE      # Don't record entries starting with space
setopt HIST_FIND_NO_DUPS      # Don't display duplicates during search
setopt HIST_SAVE_NO_DUPS      # Don't save duplicates
