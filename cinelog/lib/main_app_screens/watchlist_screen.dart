import 'package:cinelog/main_app_screens/movie_widgets/movie_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cinelog/color_scheme.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: APPBAR_BACKGROUND_COLOR,
        elevation: 0,
        title: Text(
          "Watchlist",
          style: TextStyle(
            color: SECONDARY_COLOR, 
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: SECONDARY_COLOR),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings, color: SECONDARY_COLOR),
            onPressed: () => context.push('/options'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: MovieGrid()
      ),
    );
  }
}