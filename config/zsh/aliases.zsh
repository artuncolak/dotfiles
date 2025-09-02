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

clean_node_modules() {
    local path="$1"

    if [[ -z "$path" ]]; then
        echo "Usage: clean_node_modules /path/to/search"
        return 1
    fi

    echo "Scanning: $path"

    # Find all node_modules directories
    local dirs
    dirs=$(/usr/bin/find "$path" -type d -name "node_modules" 2>/dev/null)

    if [[ -z "$dirs" ]]; then
        echo "No node_modules directories found."
        return 0
    fi

    local count=$(echo "$dirs" | /usr/bin/wc -l)
    echo "Found $count node_modules directories."
    echo
    echo "Total size:"
    echo "$dirs" | /usr/bin/xargs /usr/bin/du -ch | /usr/bin/grep total

    echo
    read "?Do you want to delete them? (y/Y/yes/YES): " confirm
    if [[ "$confirm" =~ ^[Yy](es)?$ ]]; then
        echo "$dirs" | /usr/bin/xargs /bin/rm -rf
        echo "node_modules directories deleted."
    else
        echo "Operation cancelled."
    fi
}

alias nuke-nm='clean_node_modules'

# Project aliases
alias p='cd ~/projects'