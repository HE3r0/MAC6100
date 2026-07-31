#!/bin/bash
set -euo pipefail
cd /mnt/c/Projects/Mac6100
rm -f _push.sh
git add -A
NAME=$(git -C /home/macmuz/Projects/x6100_gui config user.name)
EMAIL=$(git -C /home/macmuz/Projects/x6100_gui config user.email)
export GIT_AUTHOR_NAME="$NAME" GIT_COMMITTER_NAME="$NAME"
export GIT_AUTHOR_EMAIL="$EMAIL" GIT_COMMITTER_EMAIL="$EMAIL"
if git diff --cached --quiet; then
  echo "nothing to commit"
else
  git commit -F - <<'EOF'
Remove temporary push helper script.
EOF
fi
git status -sb
git log --oneline
