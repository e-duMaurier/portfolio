#!/bin/bash

git_comment="$1"

# Script will fail to run if no comment is required.
if [ -z "$git_comment" ]; then 
  echo "Error: A comment is required."
  exit 1 
fi

# Run Hugo to build the site.
echo -e "Building site..."
hugo
echo -e "Build finished.\n"

# Check Git Status
echo -e "Checking Git Status..."
git status

# Add changes to Git
echo -e "Adding changed files to git..."
git add .
echo -e "All files added.\n"

# Commit the changes
echo -e "Commiting the changes..."
git commit -m "$git_comment"
echo -e "All changes commited.\n"

# Push changes to GitHub repository
echo -e "Pushing changes..."
git push origin main
echo -e "Changes pushed.\nBuild will be live once GitHub action completes."
