import 'package:cinelog/main_app_screens/logo_app_bar.dart';
import 'package:cinelog/main_app_screens/movie_widgets/movie_card.dart';
import 'package:cinelog/models/loading.dart';
import 'package:cinelog/models/movie.dart';
import 'package:cinelog/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:cinelog/color_scheme.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late Future<List<Movie>> _watchlistFuture;

  @override
  void initState() {
    super.initState();
    _watchlistFuture = FirestoreService.getWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: LogoAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<List<Movie>>(
          future: _watchlistFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loading;
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'A tua watchlist está vazia',
                  style: TextStyle(color: SECONDARY_COLOR, fontSize: 20),
                ),
              );
            }
            final movies = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 25,
                childAspectRatio: 0.75,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) => MovieCard(movie: movies[index]),
            );
          },
        ),
      ),
    );
  }
}