#!/bin/bash
set -euo pipefail
HUB=/mnt/c/Projects/Mac6100
cd "$HUB"
pwd
if [ ! -d .git ]; then git init -b main; fi
git add -A
git status -sb
NAME=$(git -C /home/macmuz/Projects/x6100_gui config user.name)
EMAIL=$(git -C /home/macmuz/Projects/x6100_gui config user.email)
export GIT_AUTHOR_NAME="$NAME" GIT_COMMITTER_NAME="$NAME"
export GIT_AUTHOR_EMAIL="$EMAIL" GIT_COMMITTER_EMAIL="$EMAIL"
git commit -F - <<'EOF'
Add MAC6100 project hub: docs, build.sh, and AI guides.

Prepared with Cursor AI (Auto / Composer).
EOF
git remote remove origin 2>/dev/null || true
git remote add origin git@github.com:HE3r0/Mac6100.git
git remote -v
git log -1 --oneline
git status -sb
