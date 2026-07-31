# AI quick reference — MAC6100

> Prepared by **Cursor AI (Auto / Composer)** for the MAC6100 project, with the project owner (SO0BAD / HE3r0).

One page for assistants. Prefer this over guessing.

## Identity

- **Product:** MAC6100 (Xiegu X6100 firmware fork)
- **Modifier credit:** SO0BAD
- **Upstream GUI credit:** R1CBU / gdyuldin X6100 GUI
- **Owner GitHub:** HE3r0

## Canonical paths (WSL)

```text
/home/macmuz/Projects/x6100_gui
/home/macmuz/Projects/AetherX6100Buildroot
/home/macmuz/Projects/AetherX6100Buildroot/build/images/sdcard.img
```

UNC from Windows:

```text
\\wsl.localhost\Ubuntu-24.04\home\macmuz\Projects\
```

Hub:

```text
C:\Projects\Mac6100
```

## Build (GUI change → radio)

Preferred:

```bash
/mnt/c/Projects/Mac6100/build.sh
```

Manual equivalent:

```bash
cd ~/Projects/AetherX6100Buildroot/build
make x6100-gui-dirclean
make x6100-gui-rebuild
make
```

Verify build tree matches sources before flash:

```bash
grep … ~/Projects/x6100_gui/src/…
grep … ~/Projects/AetherX6100Buildroot/build/build/x6100-gui-*/src/…
strings ~/Projects/AetherX6100Buildroot/build/target/usr/sbin/x6100_gui | grep …
```

## Local GUI package

`AetherX6100Buildroot/br2_external/package/x6100-gui/x6100_gui.mk`

- `X6100_GUI_SITE_METHOD = local`
- `X6100_GUI_SITE = /home/macmuz/Projects/x6100_gui`

## Versioned SD images on Windows

- Files: `C:\Projects\sdcardN.img`
- Counter: `C:\Projects\Mac6100\next_sdcard_version.txt` (next N to use)
- After each successful MAC6100 firmware build: copy as `sdcard${N}.img`, then write `N+1` to the counter

## Key source files

| Intent | File |
|---|---|
| About UI | `x6100_gui/src/dialog_settings.cpp` (`make_info_page`) |
| Button labels | `x6100_gui/src/buttons.cpp` |
| Main UI init | `x6100_gui/src/main_screen.c` |
| Boot logo | `AetherX6100Buildroot/br2_external/board/X6100/linux/logo.png` |

## Display

800×480. Keep About compact. Prefer `(c)` over `©`.

## Git

- SSH remotes to `HE3r0/*`
- GUI branch typically `main`
- Buildroot MAC6100 work typically on `bootlogo` — **verify** with `git branch`
- User prefers commit messages that say **why**
- Ask before destructive git operations

## Collaboration style (user)

- Methodical, one change at a time
- Verify on device / with `strings` / build-tree grep
- Documentation and durable process over copy-paste from chat
- Propose docs/scripts when they reduce rebuild mistakes

## Suggested next features (when asked)

See `ROADMAP.md`: Mactenna, calculators, portable UX, then `build.sh` automation.
