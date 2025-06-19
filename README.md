# 🐾 Pet Adoption App

A beautiful, modern, and responsive Flutter app for adopting pets! Supports both mobile and web, with persistent favorites, adoption history, and a clean architecture using BLoC.

---

## ✨ Features

- **Home Page**: List of 25+ adoptable pets, search bar, responsive grid, pull-to-refresh, and infinite scroll (pagination).
- **Details Page**: Pet details (name, age, price, image), interactive image viewer (zoom), "Adopt Me" button, confetti animation on adoption, and favorite toggle.
- **Favorites Page**: View and manage your favorite pets (persistent across launches).
- **History Page**: Chronological list of adopted pets.
- **Hero Animations**: Smooth image transitions between list and details.
- **Dark Theme**: Full dark mode support.
- **Responsive UI**: Adapts to mobile, tablet, and web.
- **State Persistence**: Adoption and favorites are saved using SharedPreferences.
- **Modern UI**: Uses Google Fonts, card-based design, and beautiful layouts.
- **Testing**: Includes unit and widget tests.

---

## 📸 Screenshots

> _Add screenshots here for Home, Details, Favorites, and History pages on both web and mobile._

---

## 🏗️ Architecture

- **Clean Architecture**: `lib/core`, `lib/data`, `lib/domain`, `lib/presentation`
- **BLoC Pattern**: All state management via BLoC/Cubit
- **Model Classes**: All data models use `.fromJson`/`.toJson`
- **Separation of Concerns**: UI, business logic, and data layers are cleanly separated

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart 3.7+

### Install dependencies
```sh
flutter pub get
```

### Run on Mobile
```sh
flutter run
```

### Run on Web
```sh
flutter run -d chrome
```

---

## 🧪 Testing

Run all tests:
```sh
flutter test
```
- Includes unit test for model serialization
- Includes widget test for HomePage UI (with network images mocked)

---

## 🗂️ Project Structure

```
lib/
  core/           # Theme, utils, shared widgets
  data/           # Data sources, models, repositories
  domain/         # Entities, repositories, use cases
  presentation/   # BLoC, pages, widgets
  main.dart       # App entry point
```

---

## 🛠️ Key Packages Used
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [photo_view](https://pub.dev/packages/photo_view)
- [confetti](https://pub.dev/packages/confetti)
- [pull_to_refresh](https://pub.dev/packages/pull_to_refresh)
- [google_fonts](https://pub.dev/packages/google_fonts)
- [network_image_mock](https://pub.dev/packages/network_image_mock) (for widget tests)

---

## 💡 Design & Inspiration
- Inspired by modern pet adoption UIs on [Dribbble](https://dribbble.com/) and [UpLabs](https://www.uplabs.com/)
- Fully responsive and visually appealing


For any queries, reach out to [sharanya.nambiar@posha.com](mailto:sharanya.nambiar@posha.com)
