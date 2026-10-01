#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

git status --short
echo
read -r -p "commit message: " msg
if [[ -z "$msg" ]]; then
  echo "message is empty, abort."
  exit 1
fi

git add -A
git commit --no-verify -m "$msg"
git push -u origin HEAD

echo
git status --short
read -r -p "Press Enter to exit..."
