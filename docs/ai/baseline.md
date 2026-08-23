# MAC6100 baseline

**Tag (Buildroot):** `mac6100-baseline-1`  
**Commit:** `1c5af10` on branch `bootlogo`  
**Reference flash image:** `C:\Projects\sdcard25.img`  
**Established:** 2026-08-23

## Rule

**Every new modification starts from this baseline.**  
Do not continue feature work on obsolete trees (see below). Branch / cherry-pick from `mac6100-baseline-1` (Buildroot) and the baseline GUI tree.

## What is in the baseline

| Layer | Location | Notes |
|-------|----------|--------|
| Buildroot / kernel | `~/Projects/AetherX6100Buildroot` @ `mac6100-baseline-1` | RFCOMM TTY (`CONFIG_BT=y`, `CONFIG_BT_RFCOMM=y`, `CONFIG_BT_RFCOMM_TTY=y`), IKCONFIG, splash `logo.png`, BlueZ alias `XIEGUX6100` |
| GUI | `~/Projects/test/x6100` (`HE3r0/x6100_test`, v0.34.2) | **No** BT APP button; WiFi / GPS / RTTY as upstream |
| SITE in `x6100_gui.mk` | `/home/macmuz/Projects/test/x6100` | local method |

## Obsolete for new work

| Tree / remote | Status | Why |
|---------------|--------|-----|
| `~/Projects/x6100_gui` (`HE3r0/x6100_gui`) | **OBSOLETE** as active GUI | WiFi/BT split experiments; not the baseline SITE. Keep as archive / reference only. |
| Windows `C:\Projects\x6100_gui` | **OBSOLETE** | May diverge from WSL; never feeds the radio build. |
| Older `sdcard*.img` before 25 | Historical only | Prefer `sdcard25.img` or rebuilds from this tag. |

RFCOMM / NMEA notes remain valid: [../ttd/bluetooth-rfcomm-nmea.md](../ttd/bluetooth-rfcomm-nmea.md). New **BT GUI** work must be rebased onto baseline GUI (`test/x6100`), not continued on the obsolete fork.
