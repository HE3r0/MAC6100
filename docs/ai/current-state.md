# Current state — MAC6100

Snapshot for AI/session handoff. Update when behavior or process changes.

## Working

- **Bluetooth RFCOMM NMEA** z telefonu (GPS NMEA Tether, kanał 8 → `/dev/rfcomm0`) — patrz [../ttd/bluetooth-rfcomm-nmea.md](../ttd/bluetooth-rfcomm-nmea.md)
- Kernel: `CONFIG_BT=y`, `CONFIG_BT_RFCOMM_TTY=y`, `/proc/config.gz` (IKCONFIG)
- BlueZ alias **XIEGUX6100** (`rootfs-overlay/etc/bluetooth/main.conf`)
- Radio boots MAC6100 image from Buildroot `build/images/sdcard.img`
- Local GUI package wiring confirmed
- About: MAC6100 / SO0BAD / R1CBU credit / GUI+BASE versions / `(c)`
- Startup banner removed
- FT8 button label restored to `FT8` (build-tree sync required)
- SSH push to GitHub works from WSL
- Versioned copies `sdcard6.img+` under `C:\Projects`

## Open / watch

- `x6100_gui.mk` still embeds a machine-local absolute path (documented via `x6100_gui.mk.local.example`)
- Windows `C:\Projects\x6100_gui` can diverge from WSL — treat WSL as truth
- Hub GitHub repo published: https://github.com/HE3r0/MAC6100

## Counter

See `next_sdcard_version.txt` in hub root for next `sdcardN.img` number.
