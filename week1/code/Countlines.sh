#!/bin/bash

# Check for the correct number of arguments
if [ $# -ne 2 ]; then
    echo "Please provide an input file and an output file on the command line!"
    exit 1
fi

# Validate the input file
if [ ! -f "$1" ]; then
    echo "File $1 does not exist!"
    exit 1
fi

# Check if the output file already exists
if [ -f "$2" ]; then
    read -p "Output file $2 already exists. Overwrite? (y/n) " choice
    case "$choice" in
        y|Y ) echo "Overwriting $2";;  # Proceed to overwrite
        n|N ) echo "Operation cancelled. Exiting."; exit 0;;  # Exit without overwriting
        * ) echo "Invalid choice. Operation cancelled."; exit 1;;  # Handle invalid input
    esac
fi

# Count the number of lines in the input file
NumLines=$(wc -l < "$1")
echo "The file $1 has $NumLines lines"
echo