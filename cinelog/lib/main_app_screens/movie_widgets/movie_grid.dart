import 'package:cinelog/color_scheme.dart';
import 'package:cinelog/main_app_screens/movie_widgets/movie_card.dart';
import 'package:cinelog/models/movie.dart';
import 'package:cinelog/services/services.dart';
import 'package:flutter/material.dart';

class MovieGrid extends StatefulWidget {
  final bool neverScrollable;

  const MovieGrid({super.key, this.neverScrollable = false});

  @override
  State<StatefulWidget> createState() => MovieGridState();  

}

class MovieGridState extends State<MovieGrid> {
  List<Movie> movieList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: ApiService.getMainPageMovies(), 
      builder: (context, asyncSnapshot){
        if (asyncSnapshot.hasData){
          movieList = asyncSnapshot.requireData;
                    
          return GridView.builder(
          shrinkWrap: true,
          physics: widget.neverScrollable ? NeverScrollableScrollPhysics() : null,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          crossAxisSpacing: 20,
          mainAxisSpacing: 25,
          childAspectRatio: 0.75,
          ),
          itemCount: movieList.length,
          itemBuilder: (context, index) {
            return  MovieCard(movie: movieList[index]);
          });
        }
        return Center(
          child: CircularProgressIndicator(
            color: SECONDARY_COLOR,
        ));
      }
    );
  }

}