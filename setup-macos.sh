#!/usr/bin/env bash
# MAC6100 — macOS host helper (Darwin). Does NOT build firmware (needs Linux).
# Run from the MAC6100 hub clone.
set -euo pipefail

cd "$(dirname "$0")"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This script is for the Mac host. On Ubuntu, run: ./setup-buildhost.sh" >&2
  exit 1
fi

PROJECTS="${MAC6100_PROJECTS:-$HOME/Projects}"

echo "==> MAC6100 macOS host check"
echo "    expected layout under: $PROJECTS"
echo

need_clone=0
for pair in \
  "MAC6100:HE3r0/MAC6100" \
  "x6100_test:HE3r0/x6100_test" \
  "AetherX6100Buildroot:HE3r0/AetherX6100Buildroot"
do
  dir="${pair%%:*}"
  repo="${pair##*:}"
  path="$PROJECTS/$dir"
  if [[ -d "$path/.git" ]]; then
    echo "OK  $path"
    git -C "$path" remote -v | head -2
    git -C "$path" status -sb | head -1
  else
    echo "MISSING  $path"
    echo "         gh repo clone $repo \"$path\""
    need_clone=1
  fi
  echo
done

if [[ "$need_clone" -eq 1 ]]; then
  echo "Clone the missing repos, then re-run this script."
  exit 1
fi

echo "==> Recommended branches (on Mac you only need to edit/push; build on Linux)"
echo "    x6100_test:            main          (baseline GUI)"
echo "    AetherX6100Buildroot:  bootlogo      (tag mac6100-baseline-1)"
echo "    MAC6100:               main"
echo
echo "==> Next: create Ubuntu 24.04 VM (UTM/Parallels), share or clone the same three repos,"
echo "    then inside the VM run:"
echo "      cd ~/Projects/MAC6100 && chmod +x setup-buildhost.sh build.sh && ./setup-buildhost.sh"
echo
echo "Flash images with balenaEtcher: https://etcher.balena.io/"
echo "See BUILDING.md (macOS / Linux build host)."
