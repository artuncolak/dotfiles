plugins=(
    starship
    git
    sudo
    zsh-interactive-cd
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $OH_MY_ZSH_DIR/oh-my-zsh.sh

# MacOS-specific services
if [ "$(uname -s)" = "Darwin" ]; then
    # Add Brew to path, if it's installed
    if [[ -d /opt/homebrew/bin ]]; then
        export PATH=/opt/homebrew/bin:$PATH
    fi
fi

# Source local zshrc if present
if [ -f "$ZDOTDIR/local.zsh" ]; then
    source "$ZDOTDIR/local.zsh"
fi

source <(fzf --zsh)
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/history.zsh

eval "$(fnm env --use-on-cd --shell zsh)"

bindkey '^o' fzf-cd-widget

if [ -z "$TMUX" ]
then
    tmux attach -t main || tmux new -s main
fi
