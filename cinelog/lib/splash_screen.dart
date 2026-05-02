import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  void _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;

    context.go('/'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SizedBox( 
        width: double.infinity, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Image.asset('lib/images/cinelog_logo.png', width: 800),
            ),
          ],
        ),
      ),
    );
  }
}