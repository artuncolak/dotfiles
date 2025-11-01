#!/bin/sh

# Check if a path is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <path>"
    echo "Find and delete all node_modules directories in the specified path"
    exit 1
fi

path="$1"

# Check if path exists
if [ ! -d "$path" ]; then
    echo "Error: Directory '$path' not found"
    exit 1
fi

echo "Scanning: $path"

# Find all node_modules directories
dirs=$(/usr/bin/find "$path" -type d -name "node_modules" 2>/dev/null)

if [ -z "$dirs" ]; then
    echo "No node_modules directories found."
    exit 0
fi

count=$(echo "$dirs" | /usr/bin/wc -l | /usr/bin/tr -d ' ')
echo "Found $count node_modules directories."
echo
echo "Total size:"
echo "$dirs" | /usr/bin/xargs /usr/bin/du -ch 2>/dev/null | /usr/bin/grep total

echo
printf "Do you want to delete them? (y/Y/yes/YES): "
read -r confirm

case "$confirm" in
    [Yy]|[Yy][Ee][Ss])
        echo "$dirs" | /usr/bin/xargs /bin/rm -rf
        echo "✅ node_modules directories deleted."
        ;;
    *)
        echo "❌ Operation cancelled."
        exit 0
        ;;
esac
