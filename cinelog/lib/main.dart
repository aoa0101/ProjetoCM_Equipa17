import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cinelog/splash_screen/splash_screen.dart';
import 'package:cinelog/user_authentication_screens/register_screen.dart';
import 'package:cinelog/user_authentication_screens/login_screen.dart';
import 'package:cinelog/main_app_screens/movie_page.dart';
import 'package:cinelog/main_app_screens/main_screen.dart';
import 'package:cinelog/main_app_screens/options_screen.dart';
import 'package:cinelog/main_app_screens/profile_screen.dart';
import 'package:cinelog/main_app_screens/search_screen.dart';
import 'package:cinelog/main_app_screens/main_layout.dart';
import 'package:cinelog/main_app_screens/watchlist_screen.dart';

void main() {
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: <RouteBase>[
    GoRoute(
      path: '/splash', 
      builder: (BuildContext context, GoRouterState state) => const SplashScreen()
    ),

    GoRoute(
      path: '/login', 
      builder: (context, state) => const LoginScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: 'register', // Fica: /login/register
          builder: (context, state) => const RegisterScreen()
        ), 
      ]
    ),

    GoRoute(
      path: '/options', 
      builder: (BuildContext context, GoRouterState state) => const OptionsScreenWidget()
    ),
    GoRoute(
      path: '/movie', 
      builder: (context, state) => const MoviePage()
    ),
  
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/', 
          builder: (BuildContext context, GoRouterState state) => const MainScreenWidget()
        ),
        GoRoute(
          path: '/search', 
          builder: (context, state) => const SearchScreen()
        ),
        GoRoute(
          path: '/watchlist', 
          builder: (context, state) => const WatchlistScreen()
        ),
        GoRoute(
          path: '/profile', 
          builder: (context, state) => const ProfileScreen()
        ),
      ],
    ),
  ]
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}