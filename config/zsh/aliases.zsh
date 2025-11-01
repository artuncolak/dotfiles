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
alias tmx=${TMUX_DIR}/scripts/tmux-session-switcher.sh

# Enhanced ls commands with eza
alias ls='eza --icons=always'
alias ll='eza --icons=always -l'
alias la='eza --icons=always -la'
alias ldot='eza --icons=always -ld .*'

# Better cat with syntax highlighting
alias cat='bat --color=always --style=plain'

# Convert files to UTF-8
alias convert-utf8='${ZDOTDIR}/scripts/convert-to-utf8.sh'

# Clean node_modules
alias nuke-nm='${ZDOTDIR}/scripts/clean-node-modules.sh'

# Dotfiles
dotfiles() {
    if [[ $# -eq 0 ]]; then
        cd $DOTFILES_DIR
    else
        make -C $DOTFILES_DIR "$@"
    fi
}
