#!/usr/bin/env bash
# MAC6100 firmware build helper
# Prepared with Cursor AI (Auto / Composer) for SO0BAD / HE3r0.
#
# Usage (from WSL):
#   /mnt/c/Projects/Mac6100/build.sh
#   # or, after cloning this hub into ~/Projects/Mac6100:
#   ~/Projects/Mac6100/build.sh
#
# Steps: x6100-gui-dirclean → x6100-gui-rebuild → make → copy sdcardN.img → bump counter

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Hub may live on Windows (/mnt/c/...) or as a WSL clone under ~/Projects/Mac6100
HUB_DIR="${MAC6100_HUB:-$SCRIPT_DIR}"
BR_ROOT="${MAC6100_BUILDROOT:-$HOME/Projects/AetherX6100Buildroot}"
BUILD_DIR="${BR_ROOT}/build"
WIN_PROJECTS="${MAC6100_WIN_PROJECTS:-/mnt/c/Projects}"
COUNTER_FILE="${HUB_DIR}/next_sdcard_version.txt"
IMG_SRC="${BUILD_DIR}/images/sdcard.img"

if [[ ! -d "$BUILD_DIR" ]]; then
  echo "error: Buildroot build dir not found: $BUILD_DIR" >&2
  echo "Set MAC6100_BUILDROOT or create the build tree first (see BUILDING.md)." >&2
  exit 1
fi

if [[ ! -f "$COUNTER_FILE" ]]; then
  echo "error: missing version counter: $COUNTER_FILE" >&2
  exit 1
fi

VER="$(tr -d '[:space:]' < "$COUNTER_FILE")"
if [[ ! "$VER" =~ ^[0-9]+$ ]]; then
  echo "error: invalid counter value in $COUNTER_FILE: '$VER'" >&2
  exit 1
fi

echo "==> MAC6100 build"
echo "    buildroot: $BR_ROOT"
echo "    hub:       $HUB_DIR"
echo "    will copy: ${WIN_PROJECTS}/sdcard${VER}.img"
echo

cd "$BUILD_DIR"
echo "==> make x6100-gui-dirclean"
make x6100-gui-dirclean
echo "==> make x6100-gui-rebuild"
make x6100-gui-rebuild
echo "==> make"
make

if [[ ! -f "$IMG_SRC" ]]; then
  echo "error: image not produced: $IMG_SRC" >&2
  exit 1
fi

mkdir -p "$WIN_PROJECTS"
DEST="${WIN_PROJECTS}/sdcard${VER}.img"
echo "==> copy $IMG_SRC -> $DEST"
cp -v "$IMG_SRC" "$DEST"

NEXT=$((VER + 1))
echo "$NEXT" > "$COUNTER_FILE"
echo "==> next_sdcard_version.txt -> $NEXT"
echo
echo "Done. Flash: $DEST"
