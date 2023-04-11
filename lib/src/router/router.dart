import 'package:go_router/go_router.dart';

import '../features/home/views/home_screen.dart';
import '../features/splash/views/splash_screen.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const SplashScreen(),
    // ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
