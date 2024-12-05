#!/bin/bash

git_comment="$1"

# Script will fail to run if no comment is required.
if [ -z "$git_comment" ]; then 
  echo "Error: A comment is required."
  exit 1 
fi

# Run Hugo to build the site.
echo "Building site..."
hugo
echo "Build finished.\n"

# Check Git Status
echo "Checking Git Status..."
git status

# Add changes to Git
echo "Adding changed files to git..."
git add .
echo "All files added.\n"

# Commit the changes
echo "Commiting the changes..."
git commit -m "$git_comment"
echo "All changes commited.\n"

# Push changes to GitHub repository
echo "Pushing changes..."
git push origin main
echo "Changes pushed.\nBuild will be live once GitHub action completes."
