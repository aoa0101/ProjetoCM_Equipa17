import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'color_scheme.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR, 
      appBar: AppBar(
        backgroundColor: APPBAR_BACKGROUND_COLOR,
        iconTheme: IconThemeData(color: SECONDARY_COLOR),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: const Offset(-15, 0),
              child: Transform.scale(
                scale: 1.0,
                child: Image.asset("lib/images/cinelog_logo.png", width: 50),
              ),
            ),
            Transform.translate(
              offset: const Offset(-20, 0),
              child: IconButton(
                padding: const EdgeInsets.all(8.0),
                icon: Icon(Icons.search),
                onPressed: () {
                },
              ),
            ),
          ],
        ),
        actions: [      
          IconButton(
            icon: Icon(Icons.notifications_none),
              onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => context.go('/options'),
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: SECONDARY_COLOR),
            onPressed: () => context.go('/profile'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(), 
    );
  }
}