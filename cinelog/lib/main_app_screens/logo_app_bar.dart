import 'package:cinelog/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogoAppBar extends StatelessWidget implements PreferredSizeWidget{
  const LogoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: APPBAR_BACKGROUND_COLOR,
          iconTheme: IconThemeData(color: SECONDARY_COLOR),
          elevation: 0,
          title: Image.asset("lib/images/cinelog_logo.png", width: 50),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => context.push('/options'),
            ),
            const SizedBox(width: 10),
          ],
        );
  }
  
  @override
  Size get preferredSize => AppBar().preferredSize;
}