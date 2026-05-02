import 'package:cinelog/main_screen.dart';
import 'package:cinelog/options.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//Color backgroundColor = ;
void main() {
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder:(BuildContext context, GoRouterState state) {
        return MainScreenWidget();
      },
      routes: <RouteBase>[
        GoRoute(
          path: "options",
          builder: (BuildContext context, GoRouterState state) {
            return OptionsScreenWidget();
          },)
        ]
    )
  ]
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
