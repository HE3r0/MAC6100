# Boot logo (MAC6100)

## How it works

1. **Kernel splash** — built-in `logo.png` baked into the kernel (earliest screen).
2. **Userspace splash** (`S90mac6100_bootsplash`) — runs after DATA (`/mnt`) is available and **before** the GUI (`S95gui`):
   - If `/mnt/Bootlogo/logo.png` (or `.jpg` / `.bmp`) exists → show that
   - Else → show `/usr/share/mac6100/bootlogo/logo.png` (default shipped in the image)

## Put your own logo on the SD card

1. Boot once so the **DATA** partition exists.
2. On a PC, open the **DATA** volume.
3. Create folder `Bootlogo` (created automatically on boot if missing).
4. Copy an **800×480** image as `logo.png` (same orientation as the stock splash).
5. Reboot the radio.

Remove the file (or rename it) to fall back to the built-in default.

## Build notes

Requires `BR2_PACKAGE_FBV` + PNG support in Aether defconfig (already enabled on `bootlogo` with this feature).

After changing overlay/init scripts:

```bash
cd ~/Projects/AetherX6100Buildroot/build
make
# or full image via ~/Projects/MAC6100/build-local.sh once GUI SITE is wired
```

No GUI changes are required for this override path.
