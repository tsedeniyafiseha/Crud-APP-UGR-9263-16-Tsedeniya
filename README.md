#TSEDENIYA FISEHA - UGR/9263/16 - SECTION 2 



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
<img width="659" height="717" alt="image" src="https://github.com/user-attachments/assets/51ee94f9-e686-4182-9e90-6194acbef7d0" />
<img width="635" height="734" alt="image" src="https://github.com/user-attachments/assets/31c502b5-c2eb-4b87-800a-316a3d374185" />
<img width="669" height="736" alt="image" src="https://github.com/user-attachments/assets/046ebc78-d363-4771-8bb2-35cc649cc153" />
<img width="659" height="698" alt="image" src="https://github.com/user-attachments/assets/c8cc205f-87d3-42b9-8a3b-3ea4aa146095" />
<img width="656" height="732" alt="image" src="https://github.com/user-attachments/assets/d258cb49-d6b5-40d1-b9c3-6431ed3f4e2d" />
<img width="614" height="721" alt="image" src="https://github.com/user-attachments/assets/68ebeb73-c359-4b88-9cf5-0d69a4e92044" />





