export TERM=xterm-256color
export ZSH_DISABLE_COMPFIX="true"

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

source <(fzf --zsh)
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/history.zsh
source $ZDOTDIR/git.zsh

eval "$(fnm env --use-on-cd --shell zsh)"

bindkey '^o' fzf-cd-widget
