# AGENTS.md — MAC6100

> Prepared by **Cursor AI (Auto / Composer)** for the MAC6100 project, with the project owner (SO0BAD / HE3r0).  
> Read this **before** editing firmware or inventing Buildroot commands.  
> Detail card: [`docs/ai/quick-ref.md`](docs/ai/quick-ref.md)

## What this project is

MAC6100 = branded fork of Xiegu X6100 alternative firmware (LVGL GUI + Aether Buildroot). Not a one-off splash tweak.

## Golden rules

1. Work in **WSL** trees under `/home/macmuz/Projects/…`
2. Image path is **`AetherX6100Buildroot/build/images/sdcard.img`** — not `buildroot/output`
3. After GUI edits: `make x6100-gui-dirclean && make x6100-gui-rebuild && make` inside `…/build`
4. **One step → verify → next.** Do not guess make targets or paths
5. If unsure, say so and inspect the tree / ask the user
6. Preserve upstream credit (R1CBU) on About
7. After successful rebuild, copy image to `C:\Projects\sdcardN.img` using `next_sdcard_version.txt`, then increment the counter — or run `/mnt/c/Projects/Mac6100/build.sh`
8. Prefer `build.sh` over ad-hoc `make` sequences when producing a flashable image

## Repos

| Path | Remote |
|---|---|
| `/home/macmuz/Projects/x6100_gui` | `git@github.com:HE3r0/x6100_gui.git` |
| `/home/macmuz/Projects/AetherX6100Buildroot` | `git@github.com:HE3r0/AetherX6100Buildroot.git` |

Hub / docs: `C:\Projects\Mac6100` (also `/mnt/c/Projects/Mac6100` from WSL)

## Do not

- Edit `C:\Projects\x6100_gui` assuming it feeds the radio build
- Commit machine-local secrets
- Force-push or rewrite history unless the user asks
- Add `Co-authored-by: Cursor` if the user rejected it — commit from WSL/Python if the IDE injects a breaking trailer

## After behavior changes

Update `CHANGELOG.md` in this hub. Prefer small, verified diffs.
