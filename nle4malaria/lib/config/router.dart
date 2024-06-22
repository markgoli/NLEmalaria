import 'package:go_router/go_router.dart';
import 'package:nle4malaria/Authentication/auth_page.dart';
import 'package:nle4malaria/Authentication/login_page.dart';
import 'package:nle4malaria/Authentication/register_page.dart';
import 'package:nle4malaria/Home/splashScreen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/register_page',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/login_screen',
      builder: (context, state) => const LoginPage(),
    ),
    // GoRoute(
    //   path: '/forgot_password',
    //   builder: (context, state) => const ForgotPasswordScreen(),
    // ),
    GoRoute(
      path: '/homepage',
      builder: (context, state) => AuthPage(),
    ),
  ],
);
