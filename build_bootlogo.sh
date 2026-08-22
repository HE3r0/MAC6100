#!/bin/bash
set -euo pipefail

BR=~/Projects/AetherX6100Buildroot
LOGO=$BR/br2_external/board/X6100/linux/logo.png
CONV=$BR/build/host/bin/convert
HUB=/mnt/c/Projects/Mac6100
BUILD=$BR/build

echo "==> validate logo"
file "$LOGO"
ls -la "$LOGO"

# Buildroot host convert may fail on PNGs with XMP; system convert usually works.
if ! "$CONV" "$LOGO" -dither None -colors 224 -compress none /tmp/logo_test.ppm 2>/dev/null; then
  echo "==> host convert failed, re-encoding with system convert"
  if command -v convert >/dev/null 2>&1; then
    convert "$LOGO" -strip "$LOGO.tmp" && mv "$LOGO.tmp" "$LOGO"
  fi
  "$CONV" "$LOGO" -dither None -colors 224 -compress none /tmp/logo_test.ppm
fi
rm -f /tmp/logo_test.ppm
echo "logo ok for kernel"

cd "$BUILD"
echo "==> make linux-rebuild"
make linux-rebuild
echo "==> make"
make

VER=$(tr -d '[:space:]' < "$HUB/next_sdcard_version.txt")
DEST="/mnt/c/Projects/sdcard${VER}.img"
cp -v images/sdcard.img "$DEST"
echo $((VER + 1)) > "$HUB/next_sdcard_version.txt"
echo "Done. Flash: $DEST"
