# Development workflow — MAC6100

## Principles

1. **One step at a time** — change → verify → next.
2. **No guessing** — confirm paths, branches, and make targets before acting.
3. **Build on Linux** (Ubuntu VM / WSL). Edit on Mac or Linux; flash from Mac with Etcher.
4. Keep original author credit (R1CBU / upstream GUI) visible where appropriate (About).

## Where to work

| Task | Location |
|---|---|
| UI / apps / dialogs | `~/Projects/x6100_test/src/` |
| Boot logo, board, package `.mk` | `~/Projects/AetherX6100Buildroot/br2_external/` |
| Build / flash image | `~/Projects/AetherX6100Buildroot/build/` |
| Docs, assets, image counter | `~/Projects/MAC6100/` |

## Git

HTTPS or SSH to `HE3r0/*`:

```text
https://github.com/HE3r0/x6100_test.git
https://github.com/HE3r0/AetherX6100Buildroot.git
https://github.com/HE3r0/MAC6100.git
```

Typical branches (verify with `git status` / `git branch`):

- GUI: `main` (baseline); `feature/bluetooth-ui` only if working that branch
- Buildroot: `bootlogo` (tag `mac6100-baseline-1`)
- Hub: `main`

### Commit / push (GUI example)

```bash
cd ~/Projects/x6100_test
git status
git diff
git add <files>
git commit -m "Short why-focused message"
git push origin main
```

Note for Cursor agents: the IDE may inject a `Co-authored-by: Cursor` trailer that breaks some shells when `<` is present. Prefer committing from bash, or invoke `git` via Python `subprocess` without that trailer if automation fails.

## Display / UI constraints

- Screen: **800×480**
- Avoid large `text_line_space` and many blank lines on About / dialogs
- Prefer ASCII `(c)` over `©` unless the active font is verified to contain the glyph

## Useful source landmarks

| Feature | File |
|---|---|
| About / info page | `x6100_test/src/dialog_settings.cpp` → `make_info_page()` |
| App button labels (e.g. FT8) | `x6100_test/src/buttons.cpp` |
| Local GUI package | `AetherX6100Buildroot/br2_external/package/x6100-gui/x6100_gui.mk` |
| Boot splash PNG (kernel default) | `AetherX6100Buildroot/br2_external/board/X6100/linux/logo.png` |
| SD override splash | `/mnt/Bootlogo/logo.png` on DATA (see `docs/BOOTLOGO.md`) |

## Verify before claiming “done on radio”

1. Edit `x6100_test` sources  
2. `build-local.sh` (or `x6100-gui-dirclean` + `rebuild` + `make`)  
3. Confirm strings in `build/target/usr/sbin/x6100_gui`  
4. Flash `sdcardN.img` → check on device  

## Branding strings

- Product name on About: `MAC6100`
- Modifier callsign / handle: `SO0BAD` (avoid `Ø` until font support is confirmed)
- Upstream credit: `Based on X6100 GUI (c) R1CBU`
