#!/usr/bin/env bash

# Tmux Session Switcher with fzf
# Lists all active tmux sessions and allows switching to the selected one
# Press 'd' to delete a session

while true; do
    # Check if tmux is running
    if ! tmux list-sessions &>/dev/null; then
        echo "No active tmux sessions found."
        exit 0
    fi

    # Get current session name if we're inside tmux
    current_session=""
    if [ -n "$TMUX" ]; then
        current_session=$(tmux display-message -p '#S')
    fi

    # Get list of sessions and mark current one with green color
    # Current session is listed first, then others in alphabetical order
    sessions=$(
        # First, print current session if it exists
        if [ -n "$current_session" ]; then
            echo -e "\033[32m$current_session (current)\033[0m"
        fi
        # Then print all other sessions
        tmux list-sessions -F "#{session_name}" | while read -r session; do
            if [ "$session" != "$current_session" ]; then
                echo "$session"
            fi
        done
    )

    # If no sessions exist
    if [ -z "$sessions" ]; then
        echo "No active tmux sessions found."
        exit 0
    fi

    # Use fzf to select a session
    selected_session=$(echo "$sessions" | fzf \
        --prompt="Select tmux session: " \
        --height=100% \
        --reverse \
        --border \
        --ansi \
        --preview="tmux list-windows -t {1} -F '#{window_index}: #{window_name} #{window_active}' | sed 's/1$/ (active)/' | sed 's/0$//'" \
        --preview-window=right:50% \
        --bind="d:execute(tmux kill-session -t {1})+reload(tmux list-sessions -F '#{session_name}' 2>/dev/null | while read -r s; do [ \"\$s\" = \"$current_session\" ] && echo -e \"\033[32m\$s (current)\033[0m\" || echo \"\$s\"; done)" \
        --bind="q:abort" \
        --color="fg+:green" \
        --header="Enter: switch | d: delete | q: quit" | awk '{print $1}')

    # If a session was selected
    if [ -n "$selected_session" ]; then
        # Check if we're inside tmux
        if [ -n "$TMUX" ]; then
            # Switch to the selected session
            tmux switch-client -t "$selected_session"
        else
            # Attach to the selected session
            tmux attach-session -t "$selected_session"
        fi
        break
    else
        # User pressed ESC or no selection was made
        break
    fi
done
