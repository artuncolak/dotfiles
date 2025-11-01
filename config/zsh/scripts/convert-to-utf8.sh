#!/bin/sh

# Check if a file is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file>"
    echo "Supported formats: PDF, CSV"
    exit 1
fi

input_file="$1"

# Check if file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found"
    exit 1
fi

# Get file extension
extension="${input_file##*.}"
extension_lower=$(echo "$extension" | tr '[:upper:]' '[:lower:]')

# Get base filename without extension
base_name="${input_file%.*}"

case "$extension_lower" in
    pdf)
        echo "Processing PDF file..."
        # Extract text from PDF and convert to UTF-8
        output_file="${base_name}_converted.txt"
        ps2ascii "$input_file" > "$output_file"
        echo "Converted file saved as: $output_file"
        ;;
    csv)
        echo "Processing CSV file..."
        # Convert CSV to UTF-8
        output_file="${base_name}_converted.csv"
        iconv -f ISO-8859-9 -t UTF-8 "$input_file" > "$output_file"
        echo "Converted file saved as: $output_file"
        ;;
    *)
        echo "Error: Unsupported file format '$extension'"
        echo "Supported formats: PDF, CSV"
        exit 1
        ;;
esac
