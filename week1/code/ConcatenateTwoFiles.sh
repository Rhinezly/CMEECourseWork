#!/bin/bash

# Check for the correct number of arguments
if [ $# -ne 3 ]; then
    echo "Please provide two input files and one output file on the command line!"
    exit 1
fi

# Validate the first input file
if [ ! -f "$1" ]; then
    echo "File $1 does not exist!"
    exit 1
fi

# Validate the second input file
if [ ! -f "$2" ]; then
    echo "File $2 does not exist!"
    exit 1
fi

# Check if the output file already exists
if [ -f "$3" ]; then
    read -p "Output file $3 already exists. Overwrite? (y/n) " choice
    case "$choice" in
        y|Y ) echo "Overwriting $3";;  # Proceed to overwrite
        n|N ) echo "Operation cancelled. Exiting."; exit 0;;  # Exit without overwriting
        * ) echo "Invalid choice. Operation cancelled."; exit 1;;  # Handle invalid input
    esac
fi

# Merge the files
cat "$1" > "$3"  # Redirect first file to output
cat "$2" >> "$3" # Append second file to output
echo "Merged file is $3"
cat "$3"
