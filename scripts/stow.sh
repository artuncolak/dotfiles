#!/bin/bash
source ./scripts/variables.sh
source ./scripts/config-helper.sh

echo "Starting configuration file installation with GNU Stow..."

# Function to install config files using GNU Stow
main() {
    echo "Installing configuration files using GNU Stow..."

    # Navigate to config directory
    if [[ -d "$CONFIG_DIR" ]]; then
        cd "$CONFIG_DIR"

        # Stow each configuration directory
        for dir in */; do
            if [[ -d "$dir" ]]; then
                dir_name=${dir%/} # Remove trailing slash

                # Get target path from YAML config
                target_path=$(get_target_path "$dir_name" "$OS")

                stow -D -t "$target_path" "$dir_name" 2>/dev/null || true
                stow --adopt -v -t "$target_path" "$dir_name"
            fi
        done

        cd ..

        echo "Configuration files installed successfully!"
    else
        echo "Config directory not found: $CONFIG_DIR"
        exit 1
    fi
}

main