# Building MAC6100 firmware

## macOS + Linux build host (current)

Firmware **does not build natively on macOS**. Use:

1. **Mac host** — Cursor, git, edit `x6100_test` / docs, flash with balenaEtcher  
2. **Ubuntu 24.04 VM** (UTM / Parallels) — Buildroot `make` → `sdcard.img`

### One-time on the Mac

```bash
cd ~/Projects/MAC6100
chmod +x setup-macos.sh setup-buildhost.sh build.sh
./setup-macos.sh
```

Ensure these clones exist (names matter for the scripts):

| Path | Repo | Branch / tag |
|------|------|----------------|
| `~/Projects/MAC6100` | `HE3r0/MAC6100` | `main` |
| `~/Projects/x6100_test` | `HE3r0/x6100_test` | `main` (baseline GUI) |
| `~/Projects/AetherX6100Buildroot` | `HE3r0/AetherX6100Buildroot` | `bootlogo` / tag `mac6100-baseline-1` |

### One-time inside Ubuntu 24.04

Clone or share the same three repos under `~/Projects/…`, then:

```bash
cd ~/Projects/MAC6100
./setup-buildhost.sh
# optional exact baseline:
# MAC6100_RESET_TO_BASELINE=1 ./setup-buildhost.sh
```

First Buildroot (only if `AetherX6100Buildroot/build` is missing):

```bash
cd ~/Projects/AetherX6100Buildroot
git submodule update --init --recursive
./br_config.sh
cd build && make          # long cold build
```

### Day-to-day rebuild

```bash
# inside Ubuntu
~/Projects/MAC6100/build-local.sh
```

That runs `x6100-gui-dirclean` → `x6100-gui-rebuild` → `make`, copies  
`images/sdcard.img` → `~/Projects/images/sdcardN.img`, bumps `next_sdcard_version.txt`.

Env overrides: `MAC6100_BUILDROOT`, `MAC6100_HUB`, `MAC6100_WIN_PROJECTS` (image output dir).

### Flash

Burn `sdcardN.img` with **balenaEtcher** on the Mac → microSD → X6100.

---

## Legacy: WSL on Windows

Same `build.sh`; default image dir was `/mnt/c/Projects`. Prefer `build-local.sh` / `MAC6100_WIN_PROJECTS` now.

### Environment

- **Build host:** Linux (Ubuntu 24.04 VM or WSL)
- Output: `~/Projects/AetherX6100Buildroot/build/images/sdcard.img`
- **Do not** use `buildroot/output`

### Source layout (Linux)

| Path | Role |
|------|------|
| `~/Projects/x6100_test` | **Active** GUI (local Buildroot `SITE`) |
| `~/Projects/AetherX6100Buildroot` | Buildroot + board packages |
| `~/Projects/MAC6100` | Hub / docs / `build.sh` |

`br2_external/package/x6100-gui/x6100_gui.mk` must use:

```make
X6100_GUI_SITE = /home/<you>/Projects/x6100_test
X6100_GUI_SITE_METHOD = local
```

`setup-buildhost.sh` rewrites this for the current machine.  
`~/Projects/x6100_gui` / `HE3r0/x6100_gui` is an **obsolete** archive — do not use for new work.

### After GUI edits

```bash
cd ~/Projects/AetherX6100Buildroot/build
make x6100-gui-dirclean
make x6100-gui-rebuild
make
```

Or just `~/Projects/MAC6100/build-local.sh`.

### Sanity checks

```bash
grep -n 'make_app_btn("FT8' ~/Projects/x6100_test/src/buttons.cpp
strings ~/Projects/AetherX6100Buildroot/build/target/usr/sbin/x6100_gui \
  | grep -E 'MAC6100|FT8|R1CBU'
```

### What not to invent

- Do not invent Buildroot package target names — list from `make -qp | grep '^x6100-gui'`.
- Do not use `buildroot/output` as the image path.
