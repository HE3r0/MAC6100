# Roadmap — MAC6100

Ordered roughly by risk / value. Prefer finishing docs + build automation before deep RF features.

## Near term

- [x] Boot logo
- [x] Local GUI build wiring
- [x] About branding
- [x] Remove startup banner
- [x] SSH git push
- [x] Project documentation hub
- [x] `build.sh` (GUI dirclean/rebuild/make + versioned `sdcardN.img` copy)
- [x] Document local vs git `SITE` (`x6100_gui.mk.local.example`)
- [ ] Publish / maintain hub repo on GitHub (`HE3r0/Mac6100`)
- [ ] Keep Windows vs WSL tree confusion documented / avoided

## Features (ham / portable)

- [ ] **Mactenna** — antenna helpers for portable ops
- [ ] **Calculators** — wavelength, dipole length, simple loss / offset helpers
- [ ] Portable UX — brighter field presets, battery-friendly shortcuts
- [ ] Optional voice welcome string aligned with MAC6100 (low priority)

## Project hygiene

- [ ] CHANGELOG updates on each MAC6100 behavior change
- [ ] Tag / release notes when publishing images
- [ ] Decide whether `x6100_gui.mk` local `SITE` stays machine-specific or becomes a documented override file (not committed path)

## Explicit non-priorities

- Full rewrite of DSP / radio control
- Dropping upstream credit
- Blind full `make clean` rebuilds when package rebuild suffices
