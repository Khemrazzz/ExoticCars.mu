import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/supabase_config.dart';
import 'core/constants/color_scheme.dart';
import 'view/splash/splash_screen.dart';
import 'view/auth/reset_password_screen.dart';
import 'view/auth/login_screen.dart';
import 'view/auth/register_screen.dart';
import 'view/home/home_screen.dart';
import 'view/car/car_detail_screen.dart';
import 'view/quote/request_quote_screen.dart';
import 'view/auth/auth_gate.dart';
import 'view/auth/forgot_password_screen.dart';
import 'view/auth/verify_email_screen.dart';
class App extends StatefulWidget {
  final AuthState? initialAuthState;
  const App({super.key, this.initialAuthState});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/auth', builder: (_, __) => const AuthGate()),
        GoRoute(
          path: '/verify',
          builder: (context, state) {
            final data = state.extra as Map<String, String>?;
            return VerifyEmailScreen(
              email: data?['email'] ?? '',
              password: data?['password'] ?? '',
            );
          },
        ),
        GoRoute(path: '/forgot', builder: (_, __) => const ForgotPasswordScreen()),
        GoRoute(
          path: '/car/:id',
          builder: (context, state) {
            return CarDetailScreen(car: state.extra as Map<String, dynamic>);
          },
        ),
        GoRoute(
          path: '/quote',
          builder: (context, state) {
            final name = state.extra as String? ?? '';
            return RequestQuoteScreen(carName: name);
          },
        ),
        GoRoute(
          path: '/reset-password',
          builder: (_, __) => const ResetPasswordScreen(),
        ),
      ],
    );

    // Handle deep links that include a `#/reset-password` fragment.
    if (Uri.base.fragment.contains('/reset-password')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _router.go('/reset-password');
      });
    } else if (widget.initialAuthState?.event == AuthChangeEvent.passwordRecovery) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _router.go('/reset-password');
      });
    }

    SupabaseConfig.registerAuthListener((data) {
      final event = data.event;
      if (event == AuthChangeEvent.passwordRecovery) {
        _router.go('/reset-password');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Exotic Cars',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: AppColors.primary),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: AppColors.textSecondary),
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDark,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(fontSize: 16),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(AppColors.primary),
          trackColor: MaterialStateProperty.all(AppColors.primary.withOpacity(0.5)),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(color: AppColors.textPrimary),
        ),
        useMaterial3: true,
      ),
    );
  }
}
