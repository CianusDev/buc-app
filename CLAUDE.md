# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter pub get        # install dependencies
flutter run            # run on connected device/emulator
flutter analyze        # lint
flutter test           # all tests
flutter test test/widget_test.dart  # single test file
```

## Architecture

Notes app (tutorial). Feature-based folder structure under `lib/`.

**State management:** Provider. Single `NoteProvider` (`ChangeNotifier`) wraps `List<Note>`. Initialized at root in `main.dart` via `ChangeNotifierProvider`, calls `loadNotes()` on startup.

**Persistence:** `shared_preferences` key `mes_notes` — stores JSON-encoded list of notes.

**Routing:** Named routes in `app.dart`. Navigation to `/note-detail` passes note fields as `Map<String, dynamic>` via `Navigator.pushNamed` arguments. `NoteDetail` receives this map via `ModalRoute.of(context)!.settings.arguments`.

**Design system:**
- `lib/core/constants/app_colors.dart` — static `Color` constants (primary, secondary, background, foreground, destructive)
- `lib/core/constants/app_sizes.dart` — static spacing/radius/text size constants
- `lib/core/theme/app_theme.dart` — `AppTheme.light` wires font (GeneralSans) and component themes
- Custom font `GeneralSans` loaded from `assets/fonts/`

**Known bug:** `Note.fromMap` reads `createdAt`/`updatedAt` directly from the map without calling `DateTime.parse()`. When loaded from `shared_preferences` these will be strings, causing a runtime type error. Fix: `createdAt: DateTime.parse(map['createdAt'])`.
