# Development workflow — MAC6100

## Principles

1. **One step at a time** — change → verify → next.
2. **No guessing** — confirm paths, branches, and make targets before acting.
3. Prefer WSL paths and commands for build/git that must match the radio image.
4. Keep original author credit (R1CBU / upstream GUI) visible where appropriate (About).

## Where to work

| Task | Location |
|---|---|
| UI / apps / dialogs | `~/Projects/x6100_gui/src/` |
| Boot logo, board, package `.mk` | `~/Projects/AetherX6100Buildroot/br2_external/` |
| Build / flash image | `~/Projects/AetherX6100Buildroot/build/` |
| Docs, assets, image counter | `C:\Projects\Mac6100\` |

## Git

Remotes use **SSH** (not HTTPS):

```text
git@github.com:HE3r0/x6100_gui.git
git@github.com:HE3r0/AetherX6100Buildroot.git
```

Typical branches (verify with `git status` / `git branch`):

- GUI: `main`
- Buildroot: `bootlogo` (MAC6100 packaging / logo / local GUI site)

### Commit / push (GUI example)

```bash
cd ~/Projects/x6100_gui
git status
git diff
git add <files>
git commit -m "Short why-focused message"
git push origin main
```

Note for Cursor agents: the IDE may inject a `Co-authored-by: Cursor` trailer that breaks PowerShell when `<` is present. Prefer committing from WSL bash, or invoke `git` via Python `subprocess` without that trailer if automation fails.

## Display / UI constraints

- Screen: **800×480**
- Avoid large `text_line_space` and many blank lines on About / dialogs
- Prefer ASCII `(c)` over `©` unless the active font is verified to contain the glyph

## Useful source landmarks

| Feature | File |
|---|---|
| About / info page | `x6100_gui/src/dialog_settings.cpp` → `make_info_page()` |
| App button labels (e.g. FT8) | `x6100_gui/src/buttons.cpp` |
| Startup message popup | was `msg_schedule_text_fmt(...)` in `main_screen.c` (removed in MAC6100) |
| Local GUI package | `AetherX6100Buildroot/br2_external/package/x6100-gui/x6100_gui.mk` |
| Boot splash PNG | `AetherX6100Buildroot/br2_external/board/X6100/linux/logo.png` |

## Verify before claiming “done on radio”

1. Edit WSL sources  
2. `x6100-gui-dirclean` + `x6100-gui-rebuild` + `make`  
3. Confirm string in `build/build/x6100-gui-...` **and** `strings .../usr/sbin/x6100_gui`  
4. Copy `sdcardN.img` → flash → check on device  

## Branding strings

- Product name on About: `MAC6100`
- Modifier callsign / handle: `SO0BAD` (avoid `Ø` until font support is confirmed)
- Upstream credit: `Based on X6100 GUI (c) R1CBU`
