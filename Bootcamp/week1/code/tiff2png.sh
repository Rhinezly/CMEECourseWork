#!/bin/bash

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed. Please install it to run this script."
    exit 1
fi

# Check for the presence of .tif files
shopt -s nullglob  # Enable nullglob to handle no .tif files case
tif_files=(*.tif)

if [ ${#tif_files[@]} -eq 0 ]; then
    echo "No .tif files found in the current directory."
    exit 1
fi

# Convert .tif files to .png
for f in "${tif_files[@]}"; do
    echo "Converting $f"
    convert "$f" "$(basename "$f" .tif).png"
done
