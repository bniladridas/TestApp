#!/bin/bash

# Stage all changes
git add .

# Check if there are changes
if git diff --cached --quiet; then
  echo "No changes to commit"
  exit 0
fi

# Save original profile
original_name=$(git config user.name)
original_email=$(git config user.email)

# Set bot profile for commit
git config user.name "TestApp Bot"
git config user.email "244429612+testapp-bot@users.noreply.github.com"

# Generate commit message using AI
diff=$(git diff --cached)
msg=$(node commitmsg.js "$diff" 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "AI unavailable, using default message."
  msg="chore: update files"
fi

# Commit
git commit -m "$msg"

# Restore original profile
git config user.name "$original_name"
git config user.email "$original_email"

# Run rewrite commits
echo "y" | ./rewrite-commits.sh