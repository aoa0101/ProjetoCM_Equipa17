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
       title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: const Offset(-15, 0),
              child: Transform.scale(
                scale: 1.5,
                child: Image.asset("lib/images/cinelog_logo.png", width: 100),
              ),
            ),
            
            Transform.translate(
              offset: const Offset(-20, 0),
              child: IconButton(
                padding: const EdgeInsets.all(8.0),
                mouseCursor: SystemMouseCursors.click,
                hoverColor: Colors.white, 
                icon: Icon(
                  Icons.search,
                  color: SECONDARY_COLOR,
                ),
                onPressed: () {
                },
              ),
            ),
          ],
        ),
        actions: [      
          IconButton(
            icon: Icon(
                Icons.notifications_none,
                color: SECONDARY_COLOR
              ),
              onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: SECONDARY_COLOR
              ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: SECONDARY_COLOR
              ),
            onPressed: () => context.go('/options'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(), 
    );
  }
}