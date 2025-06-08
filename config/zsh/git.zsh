# Source git author config if present
if [ -f "$ZDOTDIR/git-author.zsh" ]; then
    source "$ZDOTDIR/git-author.zsh"

    export GIT_AUTHOR_NAME="$GIT_USER_NAME"
    export GIT_COMMITTER_NAME="$GIT_USER_NAME"

    export GIT_AUTHOR_EMAIL="$GIT_USER_EMAIL"
    export GIT_COMMITTER_EMAIL="$GIT_USER_EMAIL"
fi
