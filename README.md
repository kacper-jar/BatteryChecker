# BatteryChecker

**BatteryChecker** is a simple macOS utility written in Swift that helps you keep your Mac’s battery in good condition. It monitors your battery percentage and sends you a notification when it's time to plug in your charger — extending battery lifespan.

## Features

- 💡 Monitors current battery percentage
- 🛎️ Sends notifications when it's time to charge
- ⚙️ Configurable thresholds for battery alerts
- 🧩 Native Swift + SwiftUI experience on macOS
- 🚀 Lightweight and runs quietly in the background

## Installation

1. Download the latest release from the [Releases](https://github.com/kacper-jar/BatteryChecker/releases) page.
2. Unzip the archive and move `BatteryChecker.app` to your `Applications` folder.
3. If macOS blocks the app because it is unsigned:
   - Go to **System Settings → Privacy & Security**.
   - Scroll down to the **Security** section.
   - Click **Open Anyway** next to BatteryChecker.
   - Confirm when prompted.

## Building from Source

To build BatteryChecker from source:

1. Clone the repository:
   ```
   git clone https://github.com/kacper-jar/BatteryChecker.git
   cd BatteryChecker
   ```

2. Open the project in Xcode:
   ```
   open BatteryChecker.xcodeproj
   ```

3. Select the target `BatteryChecker` and run the app using the **Play** button or build it for release.

## Compatibility

- macOS 13.5 (Ventura) or newer

## License

This project is licensed under the MIT License. See the `LICENSE` file for more information.

---

Made with ❤️ for macOS by [Kacper Jarosławski](https://github.com/kacper-jar)
