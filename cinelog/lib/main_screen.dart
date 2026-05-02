import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'color_scheme.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: APPBAR_BACKGROUND_COLOR,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset("lib/images/cinelog_logo.png"),
        ),
        actions: [      
          IconButton(
            icon: Icon(
                Icons.search,
                color: SECONDARY_COLOR,
              ),
            onPressed: () {},
          ),
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
            onPressed: () {},
          )
        ],
      ),
    );
  }
}