# MAC6100

Fork firmware for the **Xiegu X6100** transceiver.

Brand: **MAC6100**  
Modifier: **SO0BAD**  
Based on: [X6100 GUI](https://github.com/gdyuldin/x6100_gui) by R1CBU / gdyuldin and [AetherX6100Buildroot](https://github.com/gdyuldin/AetherX6100Buildroot)

This is a long-term open-source-style fork: own branding first, then ham-oriented features (Mactenna, calculators, portable UX).

## Repositories

| Repo | Role | GitHub (fork) |
|---|---|---|
| `x6100_test` | **Active** LVGL UI | https://github.com/HE3r0/x6100_test |
| `AetherX6100Buildroot` | Buildroot → `sdcard.img` | https://github.com/HE3r0/AetherX6100Buildroot |
| `x6100_gui` | Obsolete archive | https://github.com/HE3r0/x6100_gui |

Canonical layout (Linux build host **or** Mac checkouts for editing):

```text
~/Projects/MAC6100
~/Projects/x6100_test
~/Projects/AetherX6100Buildroot
~/Projects/images/          # versioned sdcardN.img output
```

This hub (`MAC6100`) holds docs, assets, and build helpers.  
GitHub: https://github.com/HE3r0/MAC6100

**Builds require Linux** (Ubuntu 24.04 VM on Mac, or WSL on Windows) — not native macOS. See [BUILDING.md](BUILDING.md).

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
| [setup-macos.sh](setup-macos.sh) | Mac host: verify clones |
| [setup-buildhost.sh](setup-buildhost.sh) | Ubuntu: apt + SITE + `build-local.sh` |
| [build.sh](build.sh) | One-shot GUI rebuild + versioned `sdcardN.img` |
| [overrides/x6100_gui.mk.local.example](overrides/x6100_gui.mk.local.example) | Local vs git GUI `SITE` example |

## Current status

- Custom boot logo
- Local GUI sources wired into Buildroot
- About screen branded as MAC6100
- Startup version banner disabled
- Git push via SSH/HTTPS to `HE3r0/*`
- Firmware builds and runs on the radio

## Flash artifacts

Built image (Linux):

`~/Projects/AetherX6100Buildroot/build/images/sdcard.img`

Versioned copies (after `build-local.sh`):

`~/Projects/images/sdcardN.img`

Next free number is stored in [`next_sdcard_version.txt`](next_sdcard_version.txt).
