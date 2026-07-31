# Architecture — MAC6100

```text
┌─────────────────────────────────────────────────────────┐
│  MAC6100 hub (docs / assets / image counter)            │
│  C:\Projects\Mac6100                                    │
└─────────────────────────────────────────────────────────┘
                          │
          ┌───────────────┴───────────────┐
          ▼                               ▼
┌─────────────────────┐         ┌─────────────────────────┐
│  x6100_gui (WSL)    │         │  AetherX6100Buildroot   │
│  LVGL application   │◄──local─│  Buildroot + br2_ext    │
│  src/, CMake        │  SITE   │  build/ → sdcard.img    │
└─────────────────────┘         └─────────────────────────┘
                                              │
                                              ▼
                                    microSD → X6100 radio
```

## Layers

1. **GUI (`x6100_gui`)**  
   LVGL UI, FT8/RTTY/apps, settings dialogs, audio/DSP glue. Built as Buildroot package `x6100-gui`, installed as `/usr/sbin/x6100_gui`.

2. **OS / image (`AetherX6100Buildroot`)**  
   Kernel, rootfs, boot files, board splash, package recipes. Output under **`build/`** (project convention), including `images/sdcard.img`.

3. **Hub (`Mac6100`)**  
   Not required to compile. Holds documentation, bootlogo assets, and `next_sdcard_version.txt` for Windows-side image archives.

## Data flow for a UI change

1. Edit file under `~/Projects/x6100_gui/src/`
2. Buildroot rsyncs local tree into `build/build/x6100-gui-<version>/` on extract/rebuild
3. Cross-compile → install into `build/target/`
4. Pack rootfs + boot → `build/images/sdcard.img`
5. Flash SD → radio runs new UI

## Upstream relationship

- Upstream GUI: `gdyuldin/x6100_gui` (and historical R1CBU work)
- Upstream buildroot family: Aether X6100 Buildroot
- MAC6100 forks under `HE3r0` keep upstream credit in About and licenses

## Non-goals (for now)

- Not a from-scratch radio stack
- Not replacing Buildroot with Yocto
- Not claiming stock Xiegu firmware compatibility for every vendor app
