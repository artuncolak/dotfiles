#!/usr/bin/env bash
#
# tmux-sessionizer.sh
# Interactive tmux session manager with fzf integration
#
# Usage:
#   tmux-sessionizer.sh                    Run main session picker
#   tmux-sessionizer.sh --preview <session>  Preview mode (internal)
#   tmux-sessionizer.sh --list             List sessions (internal)
#   tmux-sessionizer.sh --project-picker   Project picker (internal)
#

set -euo pipefail

# ============================================================================
# CONFIGURATION
# ============================================================================

PROJECTS_DIR="$HOME/projects"
WORK_DIR="$HOME/projects/work"
SCRIPT_PATH="$(realpath "$0")"

# Colors
C_GREEN='\033[1;32m'
C_YELLOW='\033[1;33m'
C_CYAN='\033[1;36m'
C_WHITE='\033[1;37m'
C_DIM='\033[2m'
C_RESET='\033[0m'

# Nerd Font Icons (using unicode escape sequences)
ICON_SESSION=""        
ICON_SESSION_ACTIVE="󰮯"
ICON_WINDOW=""        
ICON_WINDOW_ACTIVE="" 
ICON_PANE=""          
ICON_FOLDER=""           
ICON_WORK=""           
ICON_ENTER="↵"          
ICON_KILL=""          
ICON_NEW=""            
ICON_CANCEL=""  

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

# Check if required dependencies are installed
check_dependencies() {
    if ! command -v fzf &>/dev/null; then
        echo "Error: fzf is not installed" >&2
        exit 1
    fi

    if ! command -v tmux &>/dev/null; then
        echo "Error: tmux is not installed" >&2
        exit 1
    fi
}

# Get current tmux session name (empty if not inside tmux)
get_current_session() {
    if [[ -n "${TMUX:-}" ]]; then
        tmux display-message -p '#S'
    else
        echo ""
    fi
}

# Clean session name by removing ANSI codes, icons, and labels
clean_session_name() {
    local name="$1"
    # Remove ANSI escape codes
    name=$(echo "$name" | sed 's/\x1b\[[0-9;]*m//g')
    # Remove icons and labels
    name=$(echo "$name" | sed "s/^$ICON_SESSION_ACTIVE //" | sed "s/^$ICON_SESSION //" | sed 's/ (active)$//')
    echo "$name"
}

# ============================================================================
# SESSION FUNCTIONS
# ============================================================================

# Generate formatted session list with active indicator
get_sessions() {
    local current
    current=$(get_current_session)

    tmux list-sessions -F '#{session_name}|#{session_attached}' 2>/dev/null | \
    while IFS='|' read -r name attached; do
        if [[ "$name" == "$current" && "$attached" == "1" ]]; then
            # Green color for active session with icon and label
            printf "${C_GREEN}${ICON_SESSION_ACTIVE} %s (active)${C_RESET}\n" "$name"
        else
            printf "${ICON_SESSION} %s\n" "$name"
        fi
    done
}

# Generate preview content for a session (windows and panes)
preview_session() {
    local session="$1"

    # Clean the session name
    session=$(clean_session_name "$session")

    # Check if session exists
    if ! tmux has-session -t "$session" 2>/dev/null; then
        echo "Session '$session' not found"
        return 1
    fi

    # Header
    local window_count
    window_count=$(tmux list-windows -t "$session" 2>/dev/null | wc -l | tr -d ' ')
    printf "${C_WHITE}${ICON_SESSION} Session:${C_RESET} %s\n" "$session"
    printf "${C_WHITE}${ICON_WINDOW} Windows:${C_RESET} %s\n\n" "$window_count"

    # List windows and their panes
    tmux list-windows -t "$session" -F '#{window_index}|#{window_name}|#{window_active}' 2>/dev/null | \
    while IFS='|' read -r win_idx win_name win_active; do
        # Window header (yellow, with icon for active window)
        if [[ "$win_active" == "1" ]]; then
            printf "${C_YELLOW}${ICON_WINDOW_ACTIVE} [%s] %s${C_RESET}\n" "$win_idx" "$win_name"
        else
            printf "${C_DIM}${ICON_WINDOW} [%s] %s${C_RESET}\n" "$win_idx" "$win_name"
        fi

        # List panes in this window
        tmux list-panes -t "${session}:${win_idx}" \
            -F '#{pane_index}|#{pane_current_command}|#{pane_current_path}' 2>/dev/null | \
        while IFS='|' read -r pane_idx pane_cmd pane_path; do
            # Shorten home directory path
            pane_path="${pane_path/#$HOME/~}"
            printf "    ${C_CYAN}${ICON_PANE} Pane %s:${C_RESET} %s %s\n" "$pane_idx" "$pane_cmd" "$pane_path"
        done
        echo ""
    done
}

# Attach or switch to a session based on context
attach_or_switch() {
    local session="$1"

    # Clean the session name
    session=$(clean_session_name "$session")

    if [[ -z "${TMUX:-}" ]]; then
        # Outside tmux: attach
        tmux attach-session -t "$session"
    else
        # Inside tmux: switch client
        tmux switch-client -t "$session"
    fi
}

# ============================================================================
# PROJECT FUNCTIONS
# ============================================================================

# List project directories from ~/projects and ~/projects/work
# Output format: " appname" for ~/projects/appname, " work/appname" for ~/projects/work/appname
list_projects() {
    # List direct subdirectories of ~/projects (excluding "work") -> " appname"
    if [[ -d "$PROJECTS_DIR" ]]; then
        find "$PROJECTS_DIR" -mindepth 1 -maxdepth 1 -type d ! -name "work" -exec basename {} \; 2>/dev/null | sort | while read -r name; do
            echo "${ICON_FOLDER} $name"
        done
    fi

    # List direct subdirectories of ~/projects/work -> " work/appname"
    if [[ -d "$WORK_DIR" ]]; then
        find "$WORK_DIR" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | while read -r dir; do
            echo "${ICON_WORK} work/$(basename "$dir")"
        done | sort
    fi
}

# Resolve project display name to full path (strips icons)
resolve_project_path() {
    local name="$1"
    # Remove icons from the beginning
    name=$(echo "$name" | sed "s/^${ICON_FOLDER} //" | sed "s/^${ICON_WORK} //")
    if [[ "$name" == work/* ]]; then
        echo "$WORK_DIR/${name#work/}"
    else
        echo "$PROJECTS_DIR/$name"
    fi
}

# Preview project directory with eza
preview_project() {
    local name="$1"
    local path
    path=$(resolve_project_path "$name")
    eza -la --icons=always --color=always --no-permissions --no-filesize --no-user --no-time --group-directories-first "$path"
}

# Create a new tmux session from a project display name
create_session_from_project() {
    local project_name="$1"
    local project_path session_name

    # Resolve display name to full path
    project_path=$(resolve_project_path "$project_name")

    # Use folder name as session name
    session_name=$(basename "$project_path")

    # Sanitize session name (tmux doesn't allow dots in session names)
    session_name=$(echo "$session_name" | tr '.' '-')

    # Check if session already exists
    if tmux has-session -t "$session_name" 2>/dev/null; then
        # Session exists, just attach/switch
        attach_or_switch "$session_name"
    elif [[ -z "${TMUX:-}" ]]; then
        # Outside tmux: create and attach
        tmux new-session -s "$session_name" -c "$project_path"
    else
        # Inside tmux: create detached, then switch
        tmux new-session -d -s "$session_name" -c "$project_path"
        tmux switch-client -t "$session_name"
    fi
}

# Project picker with fzf (secondary menu)
project_picker() {
    local projects selected

    projects=$(list_projects)

    # Handle case where no projects are found
    if [[ -z "$projects" ]]; then
        echo "No project directories found in:"
        echo "  - $PROJECTS_DIR"
        echo "  - $WORK_DIR"
        echo ""
        read -n 1 -s -r -p "Press any key to exit..."
        return
    fi

    # Show project picker
    selected=$(echo "$projects" | fzf \
        --ansi \
        --layout=reverse \
        --header="${ICON_ENTER} Enter: create session │ ${ICON_CANCEL} Esc: cancel" \
        --preview "$SCRIPT_PATH --project-preview {}" \
        --preview-window=right:50%
    ) || return

    # Create session from selected project
    if [[ -n "$selected" ]]; then
        create_session_from_project "$selected"
    fi
}

# ============================================================================
# MAIN PICKER
# ============================================================================

# Main session picker with fzf
main_picker() {
    check_dependencies

    # Check if tmux server is running and has sessions
    if ! tmux list-sessions &>/dev/null; then
        project_picker
        return
    fi

    local result key selected

    # Run fzf with session list
    # Using --expect to capture "n" key press and handle it after fzf exits
    result=$(get_sessions | fzf \
        --ansi \
        --layout=reverse \
        --header="${ICON_ENTER} Enter: attach │ ${ICON_KILL} d: kill │ ${ICON_NEW} n: new │ ${ICON_CANCEL} Esc: cancel" \
        --preview "$SCRIPT_PATH --preview {}" \
        --preview-window=right:50%:wrap \
        --expect=n \
        --bind "d:execute(
            s={};
            s=\$(echo \"\$s\" | sed 's/\\x1b\\[[0-9;]*m//g' | sed 's/^. //' | sed 's/ (active)\$//');
            printf 'Kill session \"%s\"? (y/n): ' \"\$s\";
            read -r c < /dev/tty;
            if [[ \"\$c\" =~ ^[Yy] ]]; then
                tmux kill-session -t \"\$s\";
            fi;
            clear
        )+reload($SCRIPT_PATH --list)"
    ) || return

    # Parse the result: first line is the key pressed, second line is the selection
    key=$(echo "$result" | head -1)
    selected=$(echo "$result" | tail -n +2)

    # Handle "n" key: open project picker
    if [[ "$key" == "n" ]]; then
        project_picker
        return
    fi

    # Default action: attach/switch to selected session
    if [[ -n "$selected" ]]; then
        attach_or_switch "$selected"
    fi
}

# ============================================================================
# ENTRY POINT
# ============================================================================

case "${1:-}" in
    --preview)
        preview_session "${2:-}"
        ;;
    --list)
        get_sessions
        ;;
    --project-preview)
        preview_project "${2:-}"
        ;;
    --project-picker)
        project_picker
        ;;
    *)
        main_picker
        ;;
esac
