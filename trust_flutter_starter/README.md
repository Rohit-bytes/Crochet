# Trust Flutter starter

A responsive Flutter starter for Trust, a news-source transparency app.

## Setup

1. Create a Flutter project or use this folder as the project.
2. Run `flutter pub get`.
3. Run `flutter run`.

## Supabase

The starter initializes Supabase using the URL and publishable key supplied in
`lib/core/constants/app_text.dart`.

Enable Email authentication in Supabase Authentication settings. If email
confirmation is enabled, users must confirm their email before signing in.

Never put a Supabase `service_role` or secret key in a Flutter application.
The publishable key is intended for client use; protect database tables with
appropriate Row Level Security policies.

## Current scope

- Splash screen and session check
- Supabase email/password registration and login
- Responsive home screen
- Sample AI / Journalist news labels and filters

The home feed currently uses demo data. Connect a real `news` table and a
verified source-classification pipeline before presenting source labels or
credibility scores as factual.
