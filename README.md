# MAC6100

Fork firmware for the **Xiegu X6100** transceiver.

Brand: **MAC6100**  
Modifier: **SO0BAD**  
Based on: [X6100 GUI](https://github.com/gdyuldin/x6100_gui) by R1CBU / gdyuldin and [AetherX6100Buildroot](https://github.com/gdyuldin/AetherX6100Buildroot)

This is a long-term open-source-style fork: own branding first, then ham-oriented features (Mactenna, calculators, portable UX).

## Repositories

| Repo | Role | GitHub (fork) |
|---|---|---|
| `x6100_gui` | LVGL UI / applications | https://github.com/HE3r0/x6100_gui |
| `AetherX6100Buildroot` | Buildroot → `sdcard.img` | https://github.com/HE3r0/AetherX6100Buildroot |

**Canonical working copies live in WSL**, not under `C:\Projects\x6100_gui` (Windows copies may be stale).

```
\\wsl.localhost\Ubuntu-24.04\home\macmuz\Projects\x6100_gui
\\wsl.localhost\Ubuntu-24.04\home\macmuz\Projects\AetherX6100Buildroot
```

This folder (`C:\Projects\Mac6100`) is the **project hub**: docs, assets, image version counter.  
GitHub: https://github.com/HE3r0/MAC6100

## Documentation

| Doc | Purpose |
|---|---|
| [BUILDING.md](BUILDING.md) | How to build and flash firmware |
| [DEVELOPMENT.md](DEVELOPMENT.md) | Day-to-day workflow |
| [ARCHITECTURE.md](ARCHITECTURE.md) | How the pieces fit |
| [CHANGELOG.md](CHANGELOG.md) | What changed in MAC6100 |
| [ROADMAP.md](ROADMAP.md) | Planned work |
| [AGENTS.md](AGENTS.md) | **Start here if you are an AI assistant** |
| [docs/ai/quick-ref.md](docs/ai/quick-ref.md) | One-page AI quick reference |
| [build.sh](build.sh) | One-shot rebuild + versioned `sdcardN.img` copy |
| [overrides/x6100_gui.mk.local.example](overrides/x6100_gui.mk.local.example) | Local vs git GUI `SITE` example |

## Current status

- Custom boot logo
- Local GUI sources wired into Buildroot
- About screen branded as MAC6100
- Startup version banner disabled
- Git push via SSH to `HE3r0/*`
- Firmware builds and runs on the radio

## Flash artifacts

Built image (WSL):

`~/Projects/AetherX6100Buildroot/build/images/sdcard.img`

Versioned copies on Windows:

`C:\Projects\sdcardN.img` (N = 1, 2, …)

Next free number is stored in [`next_sdcard_version.txt`](next_sdcard_version.txt).
