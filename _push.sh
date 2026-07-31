#!/bin/bash
set -euo pipefail
cd /mnt/c/Projects/Mac6100
git rm -f --ignore-unmatch _init_repo.sh || true
# if already deleted from disk:
git add -A
NAME=$(git -C /home/macmuz/Projects/x6100_gui config user.name)
EMAIL=$(git -C /home/macmuz/Projects/x6100_gui config user.email)
export GIT_AUTHOR_NAME="$NAME" GIT_COMMITTER_NAME="$NAME"
export GIT_AUTHOR_EMAIL="$EMAIL" GIT_COMMITTER_EMAIL="$EMAIL"
if ! git diff --cached --quiet; then
  git commit -F - <<'EOF'
Remove temporary repo init script from hub.
EOF
fi
git status -sb
# Try push; create remote repo via API if missing is not possible without token
set +e
git push -u origin main
PUSH_RC=$?
set -e
exit $PUSH_RC
