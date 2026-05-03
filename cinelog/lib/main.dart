import 'package:cinelog/color_scheme.dart';
import 'package:cinelog/login_screen.dart';
import 'package:cinelog/movie_page.dart';
import 'package:cinelog/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main_screen.dart';
import 'options.dart';
import 'splash_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

void main() {
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: <RouteBase>[
    GoRoute(path: '/splash', builder: (BuildContext context, GoRouterState state) => const SplashScreen()),

    GoRoute(path: '/login', builder: (context, state) => const LoginScreen(),
     routes: <RouteBase>[
        GoRoute(path: 'register', builder: (context, state) => const RegisterScreen()), 
     ]
    ),

    GoRoute(path: '/', builder: (BuildContext context, GoRouterState state) => const MainScreenWidget(),
      routes: <RouteBase>[
        GoRoute(path: 'search', builder: (context, state) => const SearchScreen()),
        GoRoute(path: "options", builder: (BuildContext context, GoRouterState state) => const OptionsScreenWidget()),
        GoRoute(path: 'profile', builder: (context, state) => const ProfileScreen()),
        GoRoute(path: 'movie', builder: (context, state) => const MoviePage()),
      ]
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