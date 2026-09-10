#!/bin/bash
set -euo pipefail
BR=/home/macmuz/Projects/AetherX6100Buildroot
WIN=/mnt/c/Projects/AetherX6100Buildroot
OV="$BR/br2_external/board/X6100/linux/rootfs-overlay"

echo "BR=$BR"
ls -la "$BR/br2_external/board/X6100/linux/logo.png"

mkdir -p "$OV/usr/share/mac6100/bootlogo"
cp -a "$BR/br2_external/board/X6100/linux/logo.png" "$OV/usr/share/mac6100/bootlogo/logo.png"

# Prefer scripts already written on the Windows tree
if [ -f "$WIN/br2_external/board/X6100/linux/rootfs-overlay/etc/init.d/S90mac6100_bootsplash" ]; then
  cp -a "$WIN/br2_external/board/X6100/linux/rootfs-overlay/etc/init.d/S90mac6100_bootsplash" "$OV/etc/init.d/"
fi
if [ -f "$WIN/br2_external/board/X6100/linux/rootfs-overlay/etc/init.d/S11radio_daemon" ]; then
  cp -a "$WIN/br2_external/board/X6100/linux/rootfs-overlay/etc/init.d/S11radio_daemon" "$OV/etc/init.d/"
fi

chmod +x "$OV/etc/init.d/S90mac6100_bootsplash" "$OV/etc/init.d/S11radio_daemon"

add_fbv() {
  local cfg="$1"
  if ! grep -q 'BR2_PACKAGE_FBV=y' "$cfg"; then
    sed -i '/BR2_PACKAGE_FBSET=y/a BR2_PACKAGE_FBV=y\nBR2_PACKAGE_FBV_PNG=y\n# BR2_PACKAGE_FBV_GIF is not set' "$cfg"
  fi
}
add_fbv "$BR/br2_external/configs/X6100_defconfig"
add_fbv "$BR/br2_external/configs/X6100_lite_defconfig"
# Keep Windows tree defconfigs in sync if they exist
if [ -f "$WIN/br2_external/configs/X6100_defconfig" ]; then
  add_fbv "$WIN/br2_external/configs/X6100_defconfig"
  add_fbv "$WIN/br2_external/configs/X6100_lite_defconfig"
fi

mkdir -p "$WIN/br2_external/board/X6100/linux/rootfs-overlay/usr/share/mac6100/bootlogo"
cp -a "$OV/usr/share/mac6100/bootlogo/logo.png" "$WIN/br2_external/board/X6100/linux/rootfs-overlay/usr/share/mac6100/bootlogo/"
cp -a "$OV/etc/init.d/S90mac6100_bootsplash" "$WIN/br2_external/board/X6100/linux/rootfs-overlay/etc/init.d/"
cp -a "$OV/etc/init.d/S11radio_daemon" "$WIN/br2_external/board/X6100/linux/rootfs-overlay/etc/init.d/"

# LF for shell scripts on Windows copy
sed -i 's/\r$//' "$OV/etc/init.d/S90mac6100_bootsplash" "$WIN/br2_external/board/X6100/linux/rootfs-overlay/etc/init.d/S90mac6100_bootsplash"

ls -la "$OV/usr/share/mac6100/bootlogo/"
ls -la "$OV/etc/init.d/S90mac6100_bootsplash"
grep -n FBV "$BR/br2_external/configs/X6100_defconfig"
echo DONE
