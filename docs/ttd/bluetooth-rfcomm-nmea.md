# TTD — Bluetooth RFCOMM / NMEA z telefonu (SPP → `/dev/rfcomm0`)

**Status:** zweryfikowane na radiu (2026-08-22)  
**Obraz testowy:** `C:\Projects\sdcard25.img` (pełny build przez `build.sh`)  
**Agent / autor notatki:** HERMES (Cursor), sesja MAC6100

---

## Cel

Odbiór strumienia **NMEA** z telefonu Android przez **Bluetooth Classic SPP** (Serial Port Profile) jako linii TTY Linux: `/dev/rfcomm0`, z komendą `rfcomm connect` (BlueZ 5.65).

Typowe użycie docelowe: `gpsd`, logowanie GPS, integracja z nawigacją na X6100.

---

## Objawy przed naprawą

| Objaw | Przyczyna |
|--------|-----------|
| `rfcomm connect …` → `Protocol not supported` | `CONFIG_BT=m` przy `CONFIG_BT_RFCOMM=y` (moduł vs built-in mismatch) |
| `Can't create RFCOMM TTY: Operation not supported` | Brak `CONFIG_BT_RFCOMM_TTY` lub BT core jako moduł |
| Connect na kanale 11 „działa”, ale **0 bajtów** | Zły kanał SPP — nie usługa „GPS NMEA Tether” |
| Instant `Disconnected` po connect | Konflikt sesji (PulseAudio BT, podwójny connect, zły kanał) |
| `Connected: yes` w `bluetoothctl`, brak `/dev/rfcomm*` | Tylko link ACL — SPP jeszcze nie otwarty |

---

## Co zrobiliśmy (firmware / kernel)

### 1. Kernel — wbudowany Bluetooth + RFCOMM TTY

**Plik źródłowy (nie generated):**

`AetherX6100Buildroot/br2_external/board/X6100/linux/sun8i-r16-x6100_defconfig`

**Wymagane wartości (built-in `=y`, nie moduły):**

```text
CONFIG_BT=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_RFCOMM_TTY=y
```

**Diagnostyka po flashu:**

```text
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
```

→ `/proc/config.gz` na radiu.

**Bez zmian (moduły OK):**

```text
CONFIG_BT_BNEP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HCIBTUSB=m
```

**Rebuild:**

```bash
cd ~/Projects/AetherX6100Buildroot/build
make linux-rebuild
make
```

**Weryfikacja effective config (obowiązkowa):**

```bash
grep -E '^CONFIG_BT=|^CONFIG_BT_RFCOMM|^CONFIG_IKCONFIG' \
  ~/Projects/AetherX6100Buildroot/build/build/linux-6.1.82/.config
```

Na radiu po flashu:

```sh
zcat /proc/config.gz | grep -E 'CONFIG_BT=|CONFIG_BT_RFCOMM|CONFIG_IKCONFIG'
```

### 2. BlueZ — alias adaptera

**Overlay:**

`br2_external/board/X6100/linux/rootfs-overlay/etc/bluetooth/main.conf`

```ini
[General]
Name = XIEGUX6100
```

Po flashu: `bluetoothctl show` → `Name` / `Alias: XIEGUX6100`.

**Uwaga:** po każdym świeżym flashu rootfs trzeba **sparować telefon od nowa** (`/var/lib/bluetooth` puste).

### 3. Build obrazu (nasz szablon)

Pełny obraz z GUI + kernel + logo:

```bash
/mnt/c/Projects/Mac6100/build.sh
```

→ kopiuje do `C:\Projects\sdcardN.img`, bump `next_sdcard_version.txt`.

Tylko kernel + logo (bez pełnego GUI cycle): `build_bootlogo.sh` / `build_bt.sh` w hubie.

---

## Aplikacja na telefonie

| Pole | Wartość |
|------|---------|
| **Aplikacja** | **GPS NMEA Tether** (Android) |
| **Telefon testowy** | Q23+ (`64:B5:F2:E6:1F:CE`) |
| **Urządzenie docelowe** | XIEGUX6100 (sparowane) |
| **Usługa SDP** | `Service Name: GPS NMEA Tether`, Serial Port `0x1101` |
| **Kanał RFCOMM** | **8** (nie 11 ani 13 z ogólnego `sdptool browse`) |

Inne wpisy „Serial Port” w SDP (kanały 11, 13, …) to **inne profile** — łączenie na nich daje pusty strumień lub natychmiastowy disconnect.

---

## Procedura operacyjna (zweryfikowana)

### Przygotowanie

```sh
bluetoothctl pairable on
bluetoothctl trust 64:B5:F2:E6:1F:CE
# opcjonalnie, jeśli SPP niestabilny:
/etc/init.d/S50pulseaudio stop
```

**Telefon:** GPS NMEA Tether → **Start** (serwer NMEA ON, fix GPS włączony).

### Odkrycie właściwego kanału

```sh
sdptool browse 64:B5:F2:E6:1F:CE
```

Szukaj bloku:

```text
Service Name: GPS NMEA Tether
...
  "RFCOMM" (0x0003)
    Channel: 8
```

### Połączenie (terminal 1)

```sh
rfcomm connect /dev/rfcomm0 64:B5:F2:E6:1F:CE 8
```

Oczekiwane: `Connected /dev/rfcomm0 to … on channel 8` i **wiszenie** (Ctrl+C = hangup).

### Odbiór danych (terminal 2)

```sh
ls -l /dev/rfcomm0
head -c 512 /dev/rfcomm0 | hexdump -C
```

**Sukces (2026-08-22):** linie `$GNRMC`, `$GNGGA`, `$GNGSA`, `$GPGSV`, … (ASCII NMEA).

`stty`/baud **nie są wymagane** do podglądu surowych bajtów przez `cat`/`hexdump`.

### Sprzątanie

```sh
/etc/init.d/S50pulseaudio start
```

---

## Pułapki (nie tracić kontekstu)

1. **`grep Channel` na całym SDP** — zwraca wiele kanałów; używać kanału z **GPS NMEA Tether**, nie pierwszego „Serial Port”.
2. **ACL ≠ SPP** — `bluetoothctl info` → `Connected: yes` bez `/dev/rfcomm0` to normalne przed `rfcomm connect`.
3. **Nie łączyć jednocześnie** `rfcomm connect` z radia **i** „connect do XIEGU” z apki — konflikt → instant `Disconnected`.
4. **PulseAudio** na X6100 ładuje moduły BT (A2DP/HFP) — przy problemach ze SPP: zatrzymać `S50pulseaudio` na czas testu.
5. **Brak `timeout`** na obrazie — użyć `head -c N` lub Ctrl+C zamiast `timeout`.
6. **Parowanie po reflashu** — certyfikaty/klucze w `/var/lib/bluetooth` znikają; telefon traktuje radio jak nowe urządzenie.

---

## Następne kroki (nie zrobione w firmware)

- [ ] `rfcomm bind 0 <MAC> 8` — automatyczne odtwarzanie `/dev/rfcomm0` po restarcie BT
- [ ] init script / integracja z `gpsd` (`GPSD_DEVICES="/dev/rfcomm0"`)
- [ ] Wyłączenie autoconnect profili audio PulseAudio przy pracy SPP
- [ ] GUI: przycisk / status BT NMEA w MAC6100 (osobny temat)

---

## Szybki checklist po flashu

```sh
zcat /proc/config.gz | grep -E 'CONFIG_BT=|CONFIG_BT_RFCOMM|CONFIG_IKCONFIG'
bluetoothctl show | grep -E 'Name|Alias|Powered'
sdptool browse <phone-MAC> | grep -A8 'GPS NMEA Tether'
rfcomm connect /dev/rfcomm0 <phone-MAC> 8
head -c 256 /dev/rfcomm0 | hexdump -C
```

---

## Powiązane pliki w repo

| Obszar | Ścieżka |
|--------|---------|
| Kernel defconfig | `AetherX6100Buildroot/br2_external/board/X6100/linux/sun8i-r16-x6100_defconfig` |
| BlueZ alias | `…/rootfs-overlay/etc/bluetooth/main.conf` |
| Build helper (pełny) | `Mac6100/build.sh` |
| Build helper (kernel+logo) | `Mac6100/build_bootlogo.sh` |
| Build helper (BT alias + kernel) | `Mac6100/build_bt.sh` |
| Licznik obrazów | `Mac6100/next_sdcard_version.txt` |
