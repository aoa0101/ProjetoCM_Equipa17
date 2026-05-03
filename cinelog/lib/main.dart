import 'package:cinelog/color_scheme.dart';
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
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreenWidget();
      },
      routes: <RouteBase>[
        GoRoute(
          path: "options",
          /*
          pageBuilder:(context, state) {
            return CustomTransitionPage(
              child: const OptionsScreenWidget(), 
              transitionsBuilder:(context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.bounceIn).animate(animation),
                  child: child,
                );
              },
            );
          },
          */
          builder: (BuildContext context, GoRouterState state) {
            return const OptionsScreenWidget();
          },
        )
      ]
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
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