import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main_screen.dart';
import 'options.dart';
import 'splash_screen.dart';

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
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreenWidget();
      },
      routes: <RouteBase>[
        GoRoute(
          path: "options",
          builder: (BuildContext context, GoRouterState state) {
            return const OptionsScreenWidget();
          },
        )
      ]
    )
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