import 'package:cinelog/main_app_screens/notifications_screen.dart';
import 'package:cinelog/models/movie.dart';
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
import 'package:go_transitions/go_transitions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  

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
      pageBuilder: GoTransitions.slide.toRight.withFade.call,
      routes: <RouteBase>[
        GoRoute(
          pageBuilder: GoTransitions.slide.toRight.withFade.call,
          path: 'register', // Fica: /login/register
          builder: (context, state) => const RegisterScreen(),
        ), 
      ]
    ),

    GoRoute(
      path: '/notifications', 
      builder: (BuildContext context, GoRouterState state) => const NotificationsPage(),
      pageBuilder: GoTransitions.slide.toRight.withFade.call,
    ),

    GoRoute(
      path: '/options', 
      builder: (BuildContext context, GoRouterState state) => const OptionsScreenWidget(),
      pageBuilder: GoTransitions.slide.toRight.withFade.call,
    ),

    GoRoute(
      path: '/movie', 
      builder: (context, state) {
        final movie = state.extra as Movie;
          return MoviePage(movie: movie);
        },
      pageBuilder: GoTransitions.slide.toRight.withFade.call,
    ),
  
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/', 
          builder: (BuildContext context, GoRouterState state) => const MainScreenWidget(),
          pageBuilder: GoTransitions.slide.toRight.withFade.call,
        ),
        GoRoute(
          path: '/search', 
          builder: (context, state) => const SearchScreen(),
          pageBuilder: GoTransitions.slide.toRight.withFade.call,
        ),
        GoRoute(
          path: '/watchlist', 
          builder: (context, state) => const WatchlistScreen(),
          pageBuilder: GoTransitions.slide.toRight.withFade.call,
        ),
        GoRoute(
          path: '/profile', 
          builder: (context, state) => const ProfileScreen(),
          pageBuilder: GoTransitions.slide.toRight.withFade.call,
        ),
      ],
    ),
  ]
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    GoTransition.defaultCurve = Curves.easeInOut;
    GoTransition.defaultDuration = const Duration(milliseconds: 200);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}