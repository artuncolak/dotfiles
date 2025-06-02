#!/bin/bash

# run.sh - Script runner for dotfiles management

SCRIPTS_DIR="scripts"

# Function to run a script
run_script() {
    local script_name="$1"
    local script_path="$SCRIPTS_DIR/${script_name}.sh"

    if [[ -f "$script_path" ]]; then
        echo "Running $script_name script..."
        chmod +x "$script_path"
        "./$script_path"
    else
        echo "Error: Script '$script_name' not found in $SCRIPTS_DIR/"
        exit 1
    fi
}

# Main execution
main() {
    # Check if scripts directory exists
    if [[ ! -d "$SCRIPTS_DIR" ]]; then
        echo "Error: Scripts directory '$SCRIPTS_DIR' not found"
        exit 1
    fi

    local script_name="$1"

    # Run the specified script
    run_script "$script_name"
}

main "$@"
