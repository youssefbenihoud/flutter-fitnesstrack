# FitTrack App

FitTrack is a cross-platform fitness tracking application built with Flutter. It helps users manage their workouts, track their progress, and customize their fitness profiles.

## Features

-   **User Authentication:** Secure user registration and login.
-   **Workout Management:** Create, view, edit, and delete custom workout routines.
-   **Exercise Tracking:** Define exercises with sets, reps, and weights.
-   **Profile Customization:** Users can customize their fitness profile with details like height, weight, and fitness goals.
-   **Settings:** Configure application settings, such as preferred weight units (kg/lbs).
-   **State Management:** Utilizes BLoC (Business Logic Component) for robust and predictable state management.
-   **Local Data Persistence:** Uses Hive for efficient and fast local data storage.

## Technologies Used

-   **Flutter:** Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
-   **Dart:** The programming language used by Flutter.
-   **BLoC (Bloc Library):** For state management, providing a clear separation of concerns.
-   **Hive:** A fast, lightweight, and schema-free NoSQL database for local data storage.
-   **`shared_preferences`:** For simple key-value pair storage, primarily used for tracking user login status.
-   **`build_runner` & `hive_generator`:** For generating Hive adapters for data models.
-   **GitHub Actions:** For Continuous Integration (CI) and Continuous Deployment (CD) to build and deploy the application (e.g., to GitHub Pages for web).

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

-   **Flutter SDK:** Make sure you have Flutter installed. Follow the official guide: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
-   **IDE:** Visual Studio Code or Android Studio with Flutter and Dart plugins installed.
-   **Git:** For cloning the repository.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/youssefbenihoud/flutter-fitnesstrack.git
    cd flutter-fitnesstrack
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Generate Hive adapters:**
    This step is crucial after modifying any `@HiveType` annotated classes.
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

### Running the Application

Ensure you have a device connected (emulator, simulator, or physical device) or enable a desktop platform.

-   **List devices:**
    ```bash
    flutter devices
    ```

-   **Run on an Android device/emulator:**
    ```bash
    flutter run
    ```
    (If multiple devices, use `flutter run -d <device_id>`)

-   **Run on an iOS simulator/device:**
    ```bash
    flutter run
    ```
    (Requires Xcode for iOS development)

-   **Run on macOS desktop:**
    ```bash
    flutter run -d macos
    ```
    (Ensure macOS desktop support is enabled: `flutter config --enable-macos-desktop`)

-   **Run on Web:**
    ```bash
    flutter run -d chrome
    ```
    (Or `flutter run -d web-server` for a local server with hot reload)

### Testing

The project includes different types of tests:

-   **Unit & Widget Tests:** Located in the `test/` directory.
    ```bash
    flutter test
    ```

-   **Integration Tests (End-to-End):** Located in the `integration_test/` directory.
    ```bash
    flutter test integration_test/app_test.dart
    ```
    (Ensure a device/emulator is running for integration tests)

## Project Structure

The application follows a clean architecture pattern with a clear separation of concerns:

```
lib/
├── business_logic/
│   ├── bloc/               # BLoC (Business Logic Component) files (events, states, blocs)
│   ├── models/             # Data models (Workout, Exercise, Settings, User)
├── data/
│   ├── local/              # Local data persistence (Hive setup, boxes)
│   ├── repositories/       # Abstractions for data sources (WorkoutRepository, SettingsRepository, UserRepository)
├── presentation/
│   ├── screens/            # UI screens (Home, Create Workout, Settings, Login, Register, Profile)
│   ├── widgets/            # Reusable UI components (WorkoutCard, ExerciseCard, ProgressIndicator)
├── main.dart               # Application entry point and theme definition
```

## Deployment

### Web Deployment (GitHub Pages)

The project includes a GitHub Actions workflow (`.github/workflows/flutter_web_deploy.yml`) to automatically build and deploy the Flutter web application to GitHub Pages on pushes to the `main` branch.

### Android APK

To build a release APK for distribution:

```bash
flutter build apk --release
```
The APK will be located in `build/app/outputs/flutter-apk/app-release.apk`. For Google Play Store submission, ensure proper signing with a release keystore.

## Future Enhancements

-   Implement a timer for workouts.
-   Add advanced analytics and progress tracking.
-   Cloud synchronization for user data.
-   More robust authentication (e.g., Firebase Authentication).
-   Customizable exercise templates.

## Contributing

Contributions are welcome! If you have any suggestions, bug reports, or want to contribute to the codebase, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.