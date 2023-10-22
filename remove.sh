#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <folder_name>"
    exit 1
fi

# Get the folder name from the argument
folder_name="$1"

# Specify the target directory where the folder is located
target_directory="/home/void/Documents/Projects"

# Check if the target directory exists
if [ ! -d "$target_directory" ]; then
    echo "Target directory does not exist: $target_directory"
    exit 1
fi

# Determine the project directory
project_directory="$target_directory/$folder_name"

# Check if the folder exists
if [ ! -d "$project_directory" ]; then
    echo "Folder '$project_directory' does not exist."
    exit 1
fi

# Use gh to delete the GitHub repository
gh repo delete "$folder_name" --yes

# Remove the local project folder
rm -rf "$project_directory"

echo "GitHub repository '$folder_name' and project folder '$project_directory' deleted."

