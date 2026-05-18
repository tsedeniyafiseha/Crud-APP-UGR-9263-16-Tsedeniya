# Smart News Digest

A Flutter news app that fetches top headlines, supports search, favorites, and lets you create your own articles.

## Features

- **Top Headlines** — fetches latest news from NewsAPI
- **Search** — search news by keyword
- **Favorites** — save and view favorite articles
- **My Articles** — create, edit, and delete your own articles (CRUD)

## Tech Stack

- Flutter + Dart
- BLoC (state management)
- Hive (local storage)
- Dio (HTTP client)
- NewsAPI

## Getting Started

1. **Install dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── data/
│   ├── models/         # Article data models
│   ├── repositories/   # Data layer bridge
│   └── services/       # API & local storage services
└── presentation/
    ├── bloc/           # BLoC state management
    ├── screens/        # App screens
    └── widgets/        # Reusable widgets
```

## API Key

This app uses [NewsAPI](https://newsapi.org). The key is configured in `lib/data/services/news_api_service.dart`.
