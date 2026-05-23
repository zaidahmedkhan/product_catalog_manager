# Product Catalog Manager

UBIT Batch 23 — Assignment 9  
Flutter app for managing products with **Provider** state management and **crudcrud.com** REST API.

## Features

- View product list with loading, empty, and error states
- Add, edit, and delete products (full CRUD)
- UI aligned with the provided Figma designs
- Clean folder structure: `models`, `services`, `providers`, `views`

## Setup

1. Install [Flutter](https://docs.flutter.dev/get-started/install)
2. Clone this repository
3. Create your `.env` file (first time only):

```bash
cp .env.example .env
```

4. Open `.env` and set your crudcrud API ID from [crudcrud.com](https://crudcrud.com):

```
CRUDCRUD_API_ID=your_unique_id_here
```

5. Run:

```bash
flutter pub get
flutter run
```

## API Configuration (`.env`)

The API key is **not** hardcoded in Dart source. It lives in the project root `.env` file:

| File | Purpose |
|------|---------|
| `.env` | Your real API ID (local only; listed in `.gitignore`) |
| `.env.example` | Template committed to GitHub for other developers |

`lib/core/constants/api_constants.dart` reads `CRUDCRUD_API_ID` from `.env` at startup via `flutter_dotenv`.

If your endpoint resets (every 24 hours), visit [crudcrud.com](https://crudcrud.com), copy your new ID, and update **only** `.env`.

## Project Structure

```
lib/
├── main.dart
├── core/
│   ├── constants/api_constants.dart
│   └── theme/app_theme.dart
├── models/product.dart
├── services/product_service.dart
├── providers/product_provider.dart
└── views/
    ├── home/
    │   ├── home_screen.dart
    │   └── widgets/
    └── product_form/product_form_screen.dart
```

## Dependencies

- `provider` — state management
- `http` — REST API calls
- `flutter_dotenv` — loads `.env` at runtime

## Submission

Push to GitHub and submit the repository link as required by your instructor.
