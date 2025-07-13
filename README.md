# exotic_cars_apk

Mobile app for Exotic Cars showroom

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Environment variables

Create an `assets/.env` file and set the following variables:

```
SUPABASE_URL=<your supabase project url>
SUPABASE_ANON_KEY=<your supabase anon key>
AUTH_REDIRECT_URL=<your desired redirect url>
```

`AUTH_REDIRECT_URL` specifies the callback used when Supabase needs to
redirect back to the app during authentication flows (for example password
resets). The value should match a deep link your application can handle.
