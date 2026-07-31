# Building MAC6100 firmware

## Quick build (recommended)

From WSL:

```bash
chmod +x /mnt/c/Projects/Mac6100/build.sh   # once
/mnt/c/Projects/Mac6100/build.sh
```

This runs `x6100-gui-dirclean` → `x6100-gui-rebuild` → `make`, then copies
`sdcard.img` to `C:\Projects\sdcardN.img` and bumps `next_sdcard_version.txt`.

Optional env overrides: `MAC6100_BUILDROOT`, `MAC6100_HUB`, `MAC6100_WIN_PROJECTS`.

## Environment

- **Build host:** WSL2 Ubuntu-24.04 (user `macmuz`)
- **Do not assume** a stock Buildroot layout under `buildroot/output`
- Firmware output directory:

```text
~/Projects/AetherX6100Buildroot/build
```

Final image:

```text
~/Projects/AetherX6100Buildroot/build/images/sdcard.img
```

## Source layout

| Path (WSL) | Role |
|---|---|
| `~/Projects/x6100_gui` | GUI sources (edited here) |
| `~/Projects/AetherX6100Buildroot` | Buildroot tree + board packages |

GUI is consumed as a **local** Buildroot package:

`br2_external/package/x6100-gui/x6100_gui.mk`

```make
X6100_GUI_SITE = /home/macmuz/Projects/x6100_gui
X6100_GUI_SITE_METHOD = local
```

If that file still points at GitHub `git`, you are not on the MAC6100 local-dev setup.

## Full image build

```bash
cd ~/Projects/AetherX6100Buildroot/build
make
```

Produces / refreshes `images/sdcard.img`.

First-time / config setup for upstream Aether is documented in that repo’s `readme.md` (`br_config.sh`). Prefer verifying existing `build/` before re-running config scripts.

## After changing GUI sources (important)

Buildroot **caches** the GUI package tree. A plain `make` often **will not** pick up local GUI edits.

Forced GUI rebuild (verified targets in this tree):

```bash
cd ~/Projects/AetherX6100Buildroot/build
make x6100-gui-dirclean
make x6100-gui-rebuild
make
```

### Sanity checks

```bash
# Source of truth
grep -n 'make_app_btn("FT8' ~/Projects/x6100_gui/src/buttons.cpp

# What Buildroot actually compiled
grep -n 'make_app_btn("FT8' \
  ~/Projects/AetherX6100Buildroot/build/build/x6100-gui-v0.23.0-rc.3/src/buttons.cpp

# Strings in installed binary
strings ~/Projects/AetherX6100Buildroot/build/target/usr/sbin/x6100_gui \
  | grep -E 'MAC6100|FT8|R1CBU'
```

If source and `build/build/x6100-gui-...` disagree, the image is stale — re-run `dirclean` + `rebuild`.

## Windows copy of `x6100_gui`

`C:\Projects\x6100_gui` may exist but is **not** the build input. Always edit / verify under WSL `~/Projects/x6100_gui`.

## Copy image to Windows (versioned)

After a successful build, copy and bump the version counter:

```bash
# Read next number from hub (example: 7)
VER=$(cat /mnt/c/Projects/Mac6100/next_sdcard_version.txt)
cp -v ~/Projects/AetherX6100Buildroot/build/images/sdcard.img \
      /mnt/c/Projects/sdcard${VER}.img
echo $((VER + 1)) > /mnt/c/Projects/Mac6100/next_sdcard_version.txt
```

Convention on disk today: `sdcard.img`, `sdcard1.img` … `sdcard5.img` were earlier; MAC6100 automation starts numbering from **6**.

## Flash

Burn `sdcardN.img` with balenaEtcher / Rufus (or equivalent) to microSD, insert into X6100, boot.

## What not to invent

- Do not invent Buildroot package target names — list them from the existing `build` Makefile if unsure (`make -qp | grep '^x6100-gui'`).
- Do not use `buildroot/output` as the image path for this project.
