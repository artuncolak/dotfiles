# ZSH
alias zsh-update='source ${ZDOTDIR}/.zshrc && echo "✅ Zsh settings reloaded!"'

# Project aliases
alias p='cd ${PROJECTS_DIR}'
alias pw='cd ${PROJECTS_DIR}/work'

# Development tools
alias lg='lazygit'
alias lzd='lazydocker'
alias vi='nvim'
alias vim='nvim'

# Tmux
alias tm='tmux'
alias tms=${TMUX_DIR}/scripts/tmux-sessionizer.sh

# Enhanced ls commands with eza
alias ls='eza --icons=always --group-directories-first'
alias ll='eza --icons=always --group-directories-first -l'
alias la='eza --icons=always --group-directories-first -la'
alias ldot='eza --icons=always -ld --group-directories-first .*'

# Better cat with syntax highlighting
alias cat='bat --color=always --style=plain'

# Clean node_modules
alias nuke-nm=${ZDOTDIR}/scripts/clean-node-modules.sh

# Dotfiles
dotfiles() {
    if [[ $# -eq 0 ]]; then
        cd $DOTFILES_DIR
    else
        make -C $DOTFILES_DIR "$@"
    fi
}
