# AGENTS.md — MAC6100

> Prepared by **Cursor AI (Auto / Composer)** for the MAC6100 project, with the project owner (SO0BAD / HE3r0).  
> Read this **before** editing firmware or inventing Buildroot commands.  
> Detail card: [`docs/ai/quick-ref.md`](docs/ai/quick-ref.md)  
> **Baseline (mandatory):** [`docs/ai/baseline.md`](docs/ai/baseline.md)

## What this project is

MAC6100 = branded fork of Xiegu X6100 alternative firmware (LVGL GUI + Aether Buildroot). Not a one-off splash tweak.

## Baseline (start here)

**Tag:** `mac6100-baseline-1` on `AetherX6100Buildroot` (`bootlogo`, `1c5af10`)  
**GUI:** `/home/macmuz/Projects/test/x6100` (`HE3r0/x6100_test`, v0.34.2) — no BT APP button  
**Flash reference:** `C:\Projects\sdcard25.img`

Every new modification branches from this baseline. See [`docs/ai/baseline.md`](docs/ai/baseline.md).

## Golden rules

1. Work in **WSL** trees under `/home/macmuz/Projects/…`
2. Image path is **`AetherX6100Buildroot/build/images/sdcard.img`** — not `buildroot/output`
3. After GUI edits: `make x6100-gui-dirclean && make x6100-gui-rebuild && make` inside `…/build`
4. **One step → verify → next.** Do not guess make targets or paths
5. If unsure, say so and inspect the tree / ask the user
6. Preserve upstream credit (R1CBU) on About
7. After successful rebuild, copy image to `C:\Projects\sdcardN.img` using `next_sdcard_version.txt`, then increment the counter — or run `/mnt/c/Projects/Mac6100/build.sh`
8. Prefer `build.sh` over ad-hoc `make` sequences when producing a flashable image
9. **Do not** treat `~/Projects/x6100_gui` as the active GUI — it is **obsolete** (WiFi/BT experiments archive)

## Repos

| Path | Remote | Role |
|---|---|---|
| `/home/macmuz/Projects/test/x6100` | `git@github.com:HE3r0/x6100_test.git` | **Active GUI** (baseline) |
| `/home/macmuz/Projects/AetherX6100Buildroot` | `git@github.com:HE3r0/AetherX6100Buildroot.git` | Buildroot @ `mac6100-baseline-1` |
| `/home/macmuz/Projects/x6100_gui` | `git@github.com:HE3r0/x6100_gui.git` | **OBSOLETE** archive |

Hub / docs: `C:\Projects\Mac6100` (also `/mnt/c/Projects/Mac6100` from WSL)

## Do not

- Edit `C:\Projects\x6100_gui` or `~/Projects/x6100_gui` for new features (obsolete)
- Edit Windows copies assuming they feed the radio build
- Commit machine-local secrets
- Force-push or rewrite history unless the user asks
- Add `Co-authored-by: Cursor` if the user rejected it — commit from WSL/Python if the IDE injects a breaking trailer

## After behavior changes

Update `CHANGELOG.md` in this hub. Prefer small, verified diffs.
