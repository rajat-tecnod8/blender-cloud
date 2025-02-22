#!/bin/bash
# Check if a folder name was provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <folder-name>"
  exit 1
fi

# Construct the full directory path based on current working directory and argument
TARGET_DIR="$(pwd)/$1"

# Create the directory using sudo (if required) with the -p flag for parent directories
sudo mkdir -p "$TARGET_DIR"

# Change the ownership recursively to the specified user/group
sudo chown -R rajat-gcp:rajat-gcp "$TARGET_DIR"

# Set permissions to 755 for the directory
chmod 755 "$TARGET_DIR"

echo "Directory '$TARGET_DIR' created with permissions 755 and owned by rajat-gcp."
