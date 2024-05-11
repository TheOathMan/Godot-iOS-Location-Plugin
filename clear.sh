#!/bin/bash

# Check if at least one argument is provided
if [ "$#" -eq 0 ]; then
    echo "Error: No folder paths provided."
    echo "Usage: $0 <folder_path_1> [<folder_path_2>] [<folder_path_3>] ..."
    exit 1
fi

# Loop through each argument
for i in "$@"; do
    # Remove files from the current folder and its subdirectories
    echo "Removing files from $i and its subdirectories..."
    find "$i" -type f \( -name "*.d" -o -name "*.a" -o -name "*.o" \) -delete
    echo "Files ending with .d, .a, and .o have been removed from $i and its subdirectories."
done