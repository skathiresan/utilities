#!/bin/bash

# Step 1: Request the clone URL
read -p "Enter the clone URL for the Git repo: " clone_url

# Step 2: Clone the repo and checkout the latest master branch
git clone "$clone_url"
cd "$(basename "$clone_url" .git)"
git checkout master

# Step 3: Get user information
userName=$(id -un)
fullName=$(id -F)

# Step 4: Append user information to Readme.MD
echo -e "\n$fullName <$userName>" >> Readme.MD

# Step 5: Create and checkout the new branch
branch_name="onboard/$userName"
git checkout -b "$branch_name"

# Step 6: Commit changes
git add Readme.MD
git commit -m "Add user info: $userName"

# Step 7: Push the branch to remote
git push origin "$branch_name"

echo "Script completed successfully!"
