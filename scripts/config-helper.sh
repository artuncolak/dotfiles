#!/bin/bash

# Configuration helper script for parsing YAML targets

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Go up one level to project root and find targets.yaml
CONFIG_TARGETS_FILE="$SCRIPT_DIR/../targets.yaml"

# Function to get target path from YAML config
get_target_path() {
    local app_name="$1"
    local os="$2"

    # Check if yq is available
    if ! command -v yq &>/dev/null; then
        echo "Warning: yq not found, using default target $HOME" >&2
        echo "$HOME"
        return
    fi

    # Check if targets.yaml exists
    if [[ ! -f "$CONFIG_TARGETS_FILE" ]]; then
        echo "Warning: targets.yaml not found at $CONFIG_TARGETS_FILE, using default target $HOME" >&2
        echo "$HOME"
        return
    fi

    # Try to get OS-specific path from YAML
    local target_path=$(yq eval ".targets.${app_name}.${os}" "$CONFIG_TARGETS_FILE" 2>/dev/null)

    # If not found or null, get default target
    if [[ "$target_path" == "null" || -z "$target_path" ]]; then
        target_path=$(yq eval ".default_target" "$CONFIG_TARGETS_FILE" 2>/dev/null)
    fi

    # If still null or empty, fallback to HOME
    if [[ "$target_path" == "null" || -z "$target_path" ]]; then
        target_path="~"
    fi

    # Expand tilde to home directory
    target_path="${target_path/#\~/$HOME}"

    echo "$target_path"
}
