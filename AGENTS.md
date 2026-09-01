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

1. Build on **Linux** (Ubuntu 24.04 VM or WSL) under `~/Projects/…` — not native macOS
2. Image path is **`AetherX6100Buildroot/build/images/sdcard.img`** — not `buildroot/output`
3. After GUI edits: `make x6100-gui-dirclean && make x6100-gui-rebuild && make` inside `…/build`
4. **One step → verify → next.** Do not guess make targets or paths
5. If unsure, say so and inspect the tree / ask the user
6. Preserve upstream credit (R1CBU) on About
7. After successful rebuild, copy image via `build-local.sh` / `build.sh` (`MAC6100_WIN_PROJECTS` → e.g. `~/Projects/images`)
8. Prefer `build-local.sh` / `build.sh` over ad-hoc `make` sequences when producing a flashable image
9. **Do not** treat `~/Projects/x6100_gui` as the active GUI — it is **obsolete**

## Repos

| Path | Remote | Role |
|---|---|---|
| `~/Projects/x6100_test` | `HE3r0/x6100_test` | **Active GUI** (baseline `main`) |
| `~/Projects/AetherX6100Buildroot` | `HE3r0/AetherX6100Buildroot` | Buildroot @ `mac6100-baseline-1` / `bootlogo` |
| `~/Projects/x6100_gui` | `HE3r0/x6100_gui` | **OBSOLETE** archive |
| `~/Projects/MAC6100` | `HE3r0/MAC6100` | Hub / docs / scripts |

## Do not

- Edit obsolete `x6100_gui` trees for new features
- Assume Windows-only paths (`C:\…`, `/mnt/c/…`) on a Mac setup
- Commit machine-local secrets (`mac6100.local.env`)
- Force-push or rewrite history unless the user asks
- Add `Co-authored-by: Cursor` if the user rejected it — commit from bash/Python if the IDE injects a breaking trailer

## After behavior changes

Update `CHANGELOG.md` in this hub. Prefer small, verified diffs.
