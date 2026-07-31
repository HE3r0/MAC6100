# Changelog — MAC6100

All notable MAC6100-specific changes. Upstream history remains in the respective git repos.

## Unreleased

- (none)

## 2026-07-31

### Project hub / docs

- Documentation hub under `C:\Projects\Mac6100` (README, BUILDING, DEVELOPMENT, ARCHITECTURE, ROADMAP, AGENTS, AI quick-ref)
- `build.sh` — one-shot GUI rebuild + image build + versioned copy to `C:\Projects\sdcardN.img`
- `overrides/x6100_gui.mk.local.example` — documents local vs git `SITE` for the GUI package
- Hub prepared for publishing as its own GitHub repository

### Firmware / GUI

- **About screen** branded as MAC6100 with versions, upstream credit, and `SO0BAD`
- Compact About layout for 800×480; use `(c)` instead of `©` (font glyph)
- **Disabled** startup popup: `X6100 de R1CBU es Others <VERSION>`
- Confirmed local GUI rebuild path (`x6100-gui-dirclean` / `rebuild`) so label edits (e.g. FT8) reach the radio

### Buildroot

- Boot logo customized for MAC6100
- `x6100-gui` package set to `SITE_METHOD = local` → `/home/macmuz/Projects/x6100_gui`
- Added `x6100_gui.mk.local.example` beside the package `.mk`

### Tooling / process

- Git remotes switched to SSH for `HE3r0/x6100_gui` and `HE3r0/AetherX6100Buildroot`
- Versioned Windows copies of images: `C:\Projects\sdcardN.img` (MAC6100 series from **6**)
- Counter file: `Mac6100/next_sdcard_version.txt`

### Git references (GUI `main`)

| Commit | Summary |
|---|---|
| `869524c` | Add AGENTS.md for MAC6100 AI onboarding |
| `1eba930` | Disable startup version banner popup |
| `f804a43` | Replace copyright symbol with `(c)` on About |
| `38bce4c` | Compact About screen layout |
| `d8f21fe` | Update About screen with Mac6100 branding |
