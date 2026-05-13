# Home CFO

Home CFO is a local-first personal finance tracker Flutter app. It utilizes SQLite via the Drift package as the primary local database and Neon Postgres as a sync target. This tool is designed to manage domestic utility costs efficiently and locally.

## Setup Instructions

1. Ensure you have the Flutter SDK installed (tested with ^3.5.3).
2. Clone the repository and run `flutter pub get`.
3. If making changes to the database schemas (`lib/db/tables.dart`), run the build runner to regenerate drift files:
   ```bash
   dart run build_runner build
   ```
4. Run the app on an Android or iOS emulator using `flutter run`.

## Architecture

- **Local-First:** Uses `drift` (SQLite) to store all interactions locally on the device.
- **State Management:** Relies on `flutter_riverpod` (classic providers) to distribute data from local repositories to UI elements effortlessly.
- **Database:** Schemas strictly use `deleted_at` fields for soft-deletes and leverage `synced_at` identifiers to push records across nodes via an HTTP-driven Hono backend API interacting with Neon Postgres (Future integration).
- **Styling:** Adheres strictly to predefined colors in `lib/theme/app_theme.dart` (Tailwind palette equivalent) and heavily utilizes Google's `Public Sans` and Material Symbols.

## Contributing Guidelines

- When writing tests, hide `isNull` and `isNotNull` from `flutter_test` if you need them alongside Drift. See `test/electricity_repository_test.dart` for patterns.
- Global riverpod providers belong in `lib/providers/`.
- Never manually compute balances in the UI; always rely directly on `balance_after` stored snapshots in queries.
- UI elements shouldn't directly manipulate databases; always build functions through the Repository layer (`lib/db/repositories/`).
- App primarily targets mobile platforms. Do not optimize for desktop/tablet layout parameters.

## Screenshots

<img width="353" height="742" alt="image" src="https://github.com/user-attachments/assets/8314c394-da3d-42ac-88db-cfdf43b60efd" />
<img width="353" height="742" alt="image" src="https://github.com/user-attachments/assets/d489cf48-fc87-4509-a263-56c4a9c3f321" />
<img width="353" height="742" alt="image" src="https://github.com/user-attachments/assets/6d91acca-1d91-45aa-9ec6-5b36e1e11bb4" />
<img width="353" height="742" alt="image" src="https://github.com/user-attachments/assets/45f2f250-d0b7-4c64-ba13-fdf3135510c4" />
