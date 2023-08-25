#!/bin/bash

# Check if a default clone URL is set as an argument
if [ $# -eq 1 ]; then
    clone_url="$1"
else
    # Request the clone URL
    read -p "Enter the clone URL for the Git repo: " clone_url
fi

# Step 2: Clone the repo and checkout the latest master branch
git clone "$clone_url"
repo_name=$(basename "$clone_url" .git)
cd "$repo_name"
git checkout master

# Step 3: Get user information
userName=$(id -un)
fullName=$(id -F)

# Step 4: Append user information to Readme.MD
echo -e "\n$fullName <$userName>" >> Readme.MD

# Step 5: Create and checkout the new branch with rolling number
base_branch_name="onboard/$userName"
branch_name="$base_branch_name"
counter=1
while git rev-parse --verify "$branch_name" &>/dev/null; do
    counter=$((counter + 1))
    branch_name="$base_branch_name"_"$counter"
done
git checkout -b "$branch_name"

# Step 6: Commit changes
git add Readme.MD
git commit -m "Add user info: $userName"

# Step 7: Push the branch to remote
git push origin "$branch_name"

echo "Script completed successfully!"
