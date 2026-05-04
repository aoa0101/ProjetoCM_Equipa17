import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinelog/color_scheme.dart';

import 'package:cinelog/main_app_screens/movie_card.dart';

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
                  context.push('/search');
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 20,
              mainAxisSpacing: 25,
              childAspectRatio: 0.75, 
            ),
            itemCount: 10,
            itemBuilder:(context, index) {
              return MovieCard();
            }, 
          ),
      ),
    );
  }
}