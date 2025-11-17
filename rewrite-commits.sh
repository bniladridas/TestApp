#!/bin/bash

# Script to rewrite commit messages and force push all branches and tags

set -e

echo "Note: Updating commit messages and syncing to remote."
read -p "Proceed? (y/N): " confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Cancelled."
  exit 0
fi

echo "Processing commits..."
git filter-repo --commit-callback "
import subprocess
message_str = commit.message.decode('utf-8') if isinstance(commit.message, bytes) else commit.message
result = subprocess.run(['python3', 'hooks/rewrite_msg.py'], input=message_str, capture_output=True, text=True)
commit.message = result.stdout.encode('utf-8')
commit.author_name = b'Niladri Das'
commit.author_email = b'bniladridas@users.noreply.github.com'
commit.committer_name = b'Niladri Das'
commit.committer_email = b'bniladridas@users.noreply.github.com'
" --force

echo "Syncing to remote..."
git push --force --all --quiet github

git push --force --tags --quiet github

echo "Synced."