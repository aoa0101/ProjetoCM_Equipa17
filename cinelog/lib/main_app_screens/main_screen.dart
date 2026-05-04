import 'package:cinelog/main_app_screens/logo_app_bar.dart';
import 'package:cinelog/main_app_screens/movie_widgets/movie_grid.dart';
import 'package:cinelog/color_scheme.dart';
import 'package:flutter/material.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR, 
      appBar: LogoAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: MovieGrid()
      ),
    );
  }
}