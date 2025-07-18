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

Copy `assets/.env.example` to `assets/.env` and set the following variables:

```
SUPABASE_URL=<your supabase project url>
SUPABASE_ANON_KEY=<your supabase anon key>
# Include `#/reset-password` so password recovery emails open in the app
AUTH_REDIRECT_URL=exoticcars://login-callback/#/reset-password
QUOTE_FUNCTION_URL=<edge function url>
```

The example file is version controlled while your local `assets/.env` is ignored by Git.

`AUTH_REDIRECT_URL` specifies the callback used when Supabase needs to
redirect back to the app during authentication flows (for example password
resets). The value should match a deep link your application can handle.
For password recovery to work correctly, ensure the URL ends with
`#/reset-password`.

## Password reset deep links

When the app is opened via a link that includes `#/reset-password` in the URL
fragment, it automatically navigates to the reset password screen after the
first frame. This ensures Supabase password recovery links open directly in the
app.

## OTP password recovery

The password reset flow relies on a one-time password (OTP). After entering an
email, the app sends an OTP which must be typed into the verification screen.
Upon successful verification the user is navigated to the password update form.
Update the Supabase reset email template to include `{{ .Token }}` so the OTP is
present in the email.

## Quote request endpoint

Quote requests are sent to a Supabase Edge Function named `send_quote`. Deploy
this function and copy its public URL into `assets/.env` using the
`QUOTE_FUNCTION_URL` variable. The app's `QuoteService` invokes this endpoint
whenever a user submits a quote request.
