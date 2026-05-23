# Assignment 9 — Submission Checklist

Use this before submitting your GitHub repo link.

## Setup before testing

```bash
flutter pub get
# Ensure .env exists (copy from .env.example if needed)
flutter run
```

---

## Checklist (17 tasks)

| # | Task | Status | Where to verify |
|---|------|--------|-----------------|
| 1 | Folder structure matches Section 4 | ✅ | `lib/` tree below |
| 2 | Product `fromJson` / `toJson`, nullable `id` | ✅ | `lib/models/product.dart` + `test/product_model_test.dart` |
| 3 | API constants — single source for URL | ✅ | `lib/core/constants/api_constants.dart` + `.env` |
| 4 | ProductService — GET, POST, PUT, DELETE | ✅ | `lib/services/product_service.dart` |
| 5 | ProductProvider — ChangeNotifier, flags, CRUD | ✅ | `lib/providers/product_provider.dart` |
| 6 | MultiProvider + ChangeNotifierProvider | ✅ | `lib/main.dart` |
| 7 | Loading state while `isLoading` | ✅ | `lib/views/home/home_screen.dart` → `LoadingState` |
| 8 | Empty state when list is empty | ✅ | `EmptyState` widget |
| 9 | Product list from provider, updates on CRUD | ✅ | `ListView` + `ProductCard` |
| 10 | Add form — validation, `addProduct()`, pop | ✅ | `ProductFormScreen` (no `product` arg) |
| 11 | Edit form — pre-fill, `updateProduct()`, pop | ✅ | `ProductFormScreen(product: ...)` |
| 12 | Delete — confirmation dialog | ✅ | `product_card.dart` → `_confirmDelete` |
| 13 | `Consumer` used at least once | ✅ | `home_screen.dart` (body + FAB) |
| 14 | `context.read()` for methods only | ✅ | `initState`, `_save`, delete |
| 15 | Errors caught in provider, shown in UI | ✅ | `_ErrorView` + SnackBars |
| 16 | UI matches Figma | ✅ | `app_theme.dart` + view widgets |
| 17 | Clean code — no prints, no unused imports | ✅ | `flutter analyze` |

## Bonus (included)

| Bonus | Status |
|-------|--------|
| Pull-to-refresh | ✅ `RefreshIndicator` on list |
| `.env` + `flutter_dotenv` | ✅ `.env`, `api_constants.dart` |
| SnackBar on save/delete error | ✅ |

---

## Manual test script (run on device/emulator)

1. **Launch** — See loading screen → then empty state OR product list.
2. **Add** — Tap "+ Add Product" / FAB → fill name + price → Save Product → returns home, item appears.
3. **Edit** — Tap EDIT on a card → change fields → Save Changes → list updates.
4. **Delete** — Tap DELETE → confirm dialog → item removed.
5. **Error** — Turn off Wi‑Fi → pull to refresh → error screen with Try Again.
6. **Empty** — Delete all products → empty state with illustration + button.

---

## Folder structure

```
lib/
├── main.dart
├── core/
│   ├── constants/api_constants.dart
│   ├── theme/app_theme.dart
│   └── utils/price_formatter.dart
├── models/product.dart
├── services/product_service.dart
├── providers/product_provider.dart
└── views/
    ├── home/
    │   ├── home_screen.dart
    │   └── widgets/
    │       ├── product_card.dart
    │       ├── loading_state.dart
    │       └── empty_state.dart
    └── product_form/product_form_screen.dart
```
