#!/bin/bash
set -euo pipefail

BR=~/Projects/AetherX6100Buildroot
HUB=/mnt/c/Projects/Mac6100
BUILD=$BR/build
MAIN=$BR/br2_external/board/X6100/linux/rootfs-overlay/etc/bluetooth/main.conf

echo "==> BT main.conf"
grep '^Name' "$MAIN"

cd "$BUILD"
echo "==> make linux-rebuild (RFCOMM + logo if changed)"
make linux-rebuild
echo "==> make"
make

VER=$(tr -d '[:space:]' < "$HUB/next_sdcard_version.txt")
DEST="/mnt/c/Projects/sdcard${VER}.img"
cp -v images/sdcard.img "$DEST"
echo $((VER + 1)) > "$HUB/next_sdcard_version.txt"
echo "Done. Flash: $DEST"
