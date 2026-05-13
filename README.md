<p align="center">
  <img width="3171" height="1740" alt="Frame 21" src="https://github.com/user-attachments/assets/b63f52dc-4136-4aeb-9bf9-2d82c0ecb712" />
</p>

# Home CFO

A local-first household finance tracker for the things general-purpose apps don't bother with - your ironing guy's running tab, your electricity meter readings, and whatever else quietly leaks money at home.

## Features

- **Ironing tracker** - log clothes given, track what you paid vs. what was due, and maintain a running credit/debt balance with your serviceman. Price changes over time are handled gracefully.
- **Electricity tracker** - record meter readings monthly or bimonthly and let the app compute your consumption automatically.
- **Local-first** - everything works offline. Your data lives on your device.
- **Optional sync** - enable cloud sync with a passphrase to keep multiple devices in sync. No accounts, no sign-in.

## Development

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Dart 3.x
- A connected device or emulator

### Getting Started

```bash
git clone https://github.com/yourusername/home-cfo-flutter.git
cd home-cfo-flutter
flutter pub get
flutter run
```

### Build

```bash
# Android
flutter build apk --release

# iOS
flutter build ipa --release
```

## Use Case

Home CFO came out of a specific frustration: the ironing serviceman comes every few days, the price occasionally changes, sometimes we forget to pay exactly, and there's no clean way to track who owes what. General expense apps are overkill — they want categories, budgets, and accounts. This just needs a running balance.

The electricity module came from the same place. The meter is read bimonthly, the number means nothing on its own, and computing consumption requires remembering the previous reading. Home CFO stores them all and does the subtraction for you.

Both modules are intentionally narrow. They solve a specific household need without trying to be a full personal finance suite.

## Similar Projects

These are broader expense and finance trackers worth knowing about:

- [**Flow**](https://github.com/flow-mn/flow) — A beautifully designed offline-first expense tracker built with Flutter. Great UX, multi-currency, cross-platform.
- [**Fingrom**](https://github.com/lyskouski/app-finance) — Open-source platform-agnostic financial accounting app with full double-entry support.
- [**FinTracker**](https://github.com/nafishahmeddev/fintracker) — Simple Flutter expense tracker with category budgets.

Home CFO is not trying to compete with these. It tracks things they don't.

## License

GPL-3.0. See [./LICENSE](./LICENSE).

You are free to use, modify, and distribute this software under the same license. If you build something on top of Home CFO, it must also remain open source.
