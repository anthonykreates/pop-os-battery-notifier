# Pop!_OS Battery Notifier

A lightweight Bash utility for Pop!_OS / GNOME that issues desktop banners and sound chimes at target battery thresholds.

## Features
- **22% Discharging Alert**: Triggers a 3-ping sound chime and critical desktop notification to give a 2% buffer before hitting 20%.
- **80% Charging Alert**: Alerts with a 3-ping sound chime when the battery reaches 80% to prompt unplugging the charger.
- **Low Resource Usage**: Monitors hardware state via native `upower`.

## Setup
1. Clone the repository into `~/repos/`:
   ```bash
   git clone [https://github.com/YOUR_USERNAME/pop-os-battery-notifier.git](https://github.com/YOUR_USERNAME/pop-os-battery-notifier.git) ~/repos/pop-os-battery-notifier# pop-os-battery-notifier
