# XPeng P5 ADB Dashcam

[中文](README.md) | English

Community-driven, experimental software to loop-record the 360° camera view on an ADB-enabled XPeng P5 head unit, with automatic old-clip rotation. Not an official XPeng feature.

> In short: ADB lets the head unit run shell commands, so we can use the built-in `screenrecord` to loop-capture the screen and a script to delete old clips — bypassing the stock gallery's "no automatic overwrite" limitation.

## Why this exists

While driving, the P5's dozen-odd cameras feed ADAS and the 360° display only — they never write to storage. The 360° app can manually record a clip (up to 5 minutes), but it **stops when done, with no loop or overwrite**. This project fills the "loop recording" gap in software.

See [docs/BACKGROUND.md](docs/BACKGROUND.md) for the technical rationale.

## Two approaches

| | Approach B: `screenrecord` loop (recommended) | Approach A: simulated button taps |
|---|---|---|
| What is recorded | On-screen 360° view including head-unit UI, portrait | Native camera footage, clean image |
| Clip length | Up to 180 s, auto-chained by script | Up to 5 min, needs timed taps |
| Rotation | Script deletes old clips, fully controlled | Must delete gallery files; path must be probed first |
| Stability | High, pure script | Lower — if the 360 UI exits, taps hit the wrong place |
| Cost | Center screen occupied, extra power/heat, no collision lock | Same, plus higher mis-tap risk |

Neither is a **true dashcam**: no collision auto-lock, no G-sensor trigger, weak evidentiary value. For critical incidents, a dedicated plug-and-play dashcam is still recommended.

## Prerequisites

- XPeng P5 with **ADB already enabled** (early-firmware units, typically Xmart OS 3.5.0 or earlier)
- PC and head unit on the same WiFi; `adb connect <head-unit-ip>:<port>` works (common ports: 5555 / 5050)
- `adb` (Android platform-tools) installed on the PC and on PATH
- The 360° view can be opened full-screen and stays on while driving

## Quick start

```bat
:: 1. Probe the environment: adb / screenrecord / resolution / storage
scripts\00_probe.bat

:: 2. Edit config.sh based on the probe result (keep count, duration, bitrate)

:: 3. Push scripts to the head unit
scripts\01_install.bat

:: 4. Open the 360° view full-screen on the head unit, then start recording
scripts\02_start.bat

:: 5. Stop
scripts\03_stop.bat
```

Videos are saved on the head unit at `/sdcard/p5dashcam/videos/`. Pull them with:

```bat
adb pull /sdcard/p5dashcam/videos ./videos
```

Tail the log: `adb shell tail -f /sdcard/p5dashcam/run.log`

## Configuration

All parameters live in `config.sh`. Edit it and re-run `01_install.bat` to push again:

| Variable | Meaning | Default |
|---|---|---|
| `DIR` | Video output directory | `/sdcard/p5dashcam/videos` |
| `KEEP` | Number of recent clips to keep | `10` |
| `DURATION` | Seconds per clip (≤180) | `170` |
| `BITRATE` | Bitrate in bps | `6000000` |
| `ALBUM` | Native gallery path (approach A) | `/sdcard/DCIM/Camera` |
| `TAP_X` / `TAP_Y` | Record-button coordinates (approach A) | `0` |

## Running persistently

A background process started with `adb shell ... &` may die after a head-unit reboot or ADB disconnect. For "record on every drive", use an automation app already installed on the head unit — **MacroDroid** or **Auto Tasks** — with a trigger (boot completed / phone Bluetooth connected) that runs:

```
sh /sdcard/p5dashcam/screenrecord_loop.sh
```

## Contributing

This project needs real-car validation: behavior varies widely across OS versions, resolutions and storage sizes. Test reports, compatibility patches and new approaches are all welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) and [docs/TESTING.md](docs/TESTING.md).

### Call for contributors

This project is at an early stage and **needs real-car testing**. If you own a P5 with ADB enabled, you can help by:

- Running `00_probe.bat` and submitting a compatibility report (2 minutes)
- Testing the recording loop and reporting the results
- Suggesting improvements (power saving, auto-upload, event triggers, etc.)

**No coding required to contribute** — a test report is as valuable as a patch. See the [test checklist](docs/TESTING.md), or open a "Compatibility report" issue directly.

## Safety notice

- Keeping the 360° view on screen while driving obstructs navigation and distracts the driver. Set it up while parked; do not operate it while driving.
- A constantly-on screen plus continuous encoding increases power draw and heat.
- Recordings may capture private conversations and bystanders' license plates — do not distribute or use commercially.
- This project is not affiliated with XPeng. Any modification may affect warranty; use at your own risk.

## License

[MIT](LICENSE)
