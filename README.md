# Poll Pe

Poll Pe is a Flutter project designed to help users create, manage, and participate in polls or surveys easily. This project serves as a starting point for building an interactive poll-based application using Flutter.

---

## Table of Contents

- [Poll Pe](#poll-pe)
  - [Table of Contents](#table-of-contents)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
  - [Installation](#installation)

---

## Getting Started

Follow these instructions to set up and run Poll Pe on your local development environment.

### Prerequisites

- **Flutter SDK**: Install Flutter SDK by following the official [Flutter installation guide](https://docs.flutter.dev/get-started/install).
- **Dart SDK**: Dart is bundled with Flutter, but ensure your environment is set up by running `flutter doctor` in your terminal.
- **Android Studio** (for Android development) or **Xcode** (for iOS development) is recommended.
- **Emulator/Simulator**: Set up an Android emulator or an iOS simulator for testing.

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/pollpe.git
   cd pollpe


## Requirements

- **Flutter SDK**: Install Flutter SDK by following the official [Flutter installation guide](https://docs.flutter.dev/get-started/install).
- **Dart SDK**: Dart is bundled with Flutter, but ensure your environment is set up by running `flutter doctor` in your terminal.
- **Android Studio** (for Android development) or **Xcode** (for iOS development) is recommended.
- **Emulator/Simulator**: Set up an Android emulator or an iOS simulator for testing.


### Dependencies

The project uses several packages that need to be installed via `flutter pub get`:

- **`image_picker`**: ^1.1.2  
  Used for selecting an image from the device’s gallery.

- **`permission_handler`**: ^11.3.1  
  Manages permissions, such as asking the user for permission to access the gallery.

- **`uuid`**: ^4.5.1  
  Generates unique identifiers for each poll, ensuring each poll has a distinct ID.

- **`shared_preferences`**: ^2.3.2  
  Stores data locally on the device, allowing user preferences and app data to persist between sessions.


### Folder Structure
```
pollpe/
├── lib/
│   ├── main.dart               # Main entry point of the app
│   ├── constants/              # Stores constant values and static configurations like app themes, dimensions, color schemes, and string constants.
│   ├── core/                   # Core utilities, shared methods, or helper functions that may be used across the app.
│   ├── provider/               # Providers for state management, possibly with ChangeNotifier classes if using Provider for state management.
│   ├── routes/                 # Defines app routes and navigation logic. You could have a RouteGenerator or similar for centralizing navigation.
│   ├── screens/                # Main UI screens. Consider creating subfolders if there are multiple screens to organize by feature/module.
│   ├── models/                 # Data representation models, typically for API data structure or app data.
│   ├── services/               # Services for API handling, storage, authentication, and other app logic that interacts with external data or processes.
│   └── widgets/                # Reusable widgets and components that are shared across different screens (e.g., buttons, form fields, custom app bars).
└── test/                       # Unit tests and widget tests to ensure functionality and reliability.

```
