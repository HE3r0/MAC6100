# Current state — MAC6100

Snapshot for AI/session handoff. Update when behavior or process changes.

## Baseline (2026-08-23)

- **Tag:** `mac6100-baseline-1` on `AetherX6100Buildroot` / `bootlogo` (`1c5af10`)
- **GUI SITE:** `/home/macmuz/Projects/test/x6100` (v0.34.2, **no** BT APP button)
- **Reference image:** `C:\Projects\sdcard25.img`
- Full note: [baseline.md](baseline.md)

**All new work starts from this baseline.** `~/Projects/x6100_gui` is obsolete for new features.

## Working

- **Bluetooth RFCOMM NMEA** z telefonu (GPS NMEA Tether, kanał 8 → `/dev/rfcomm0`) — patrz [../ttd/bluetooth-rfcomm-nmea.md](../ttd/bluetooth-rfcomm-nmea.md)
- Kernel: `CONFIG_BT=y`, `CONFIG_BT_RFCOMM_TTY=y`, `/proc/config.gz` (IKCONFIG)
- BlueZ alias **XIEGUX6100** (`rootfs-overlay/etc/bluetooth/main.conf`)
- Radio boots MAC6100 image from Buildroot `build/images/sdcard.img`
- Splash / boot logo in Buildroot `logo.png`
- SSH push to GitHub works from WSL
- Versioned copies under `C:\Projects\sdcardN.img`

## Open / watch

- `x6100_gui.mk` still embeds a machine-local absolute path (documented via `x6100_gui.mk.local.example`)
- BT GUI (pairing UI) not in baseline — re-implement on `test/x6100` when ready
- Hub GitHub: https://github.com/HE3r0/MAC6100

## Counter

See `next_sdcard_version.txt` in hub root for next `sdcardN.img` number.
