#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <folder_name>"
    exit 1
fi

# Get the folder name from the argument
folder_name="$1"

# Specify the target directory where you want to create the folder
target_directory="/home/void/Documents/Projects"

# Check if the target directory exists
if [ ! -d "$target_directory" ]; then
    echo "Target directory does not exist: $target_directory"
    exit 1
fi

# Create the folder in the target directory
project_directory="$target_directory/$folder_name"
if [ -d "$project_directory" ]; then
    echo "Folder '$project_directory' already exists."
else
    mkdir -p "$project_directory"
    echo "Folder '$project_directory' created."
fi

# Change to the project directory
cd "$project_directory" || exit

# Initialize a Git repository
if [ -d .git ]; then
    echo "Git repository already initialized."
else
    git init
    echo "Git repository initialized."
fi

# Add and commit an initial file (optional)
echo "This is the initial file" > README.md
git add README.md
git commit -m "Initial commit"

# Use gh to create a GitHub repository
gh repo create "$folder_name" --public

# Adding remote origin
git remote add origin git@github.com:VoidWalker-00/"$folder_name"

# Push the project content to GitHub
git push --set-upstream origin master

echo "Project setup completed in '$project_directory' and pushed to GitHub."

