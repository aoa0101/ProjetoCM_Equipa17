import 'package:cinelog/main_app_screens/movie_widgets/movie_card.dart';
import 'package:cinelog/models/loading.dart';
import 'package:cinelog/models/movie.dart';
import 'package:cinelog/services/services.dart';
import 'package:flutter/material.dart';

class MovieGrid extends StatefulWidget {
  final bool neverScrollable;
  final Future Function({int page}) apiCall;
  const MovieGrid({super.key, this.neverScrollable = false, this.apiCall = ApiService.getMainPageMovies});

  @override
  State<StatefulWidget> createState() => MovieGridState();  

}

class MovieGridState extends State<MovieGrid> {
  List<Movie> movieList = [];
  final ScrollController _controller = ScrollController();
  int currentPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() async {
      if(_controller.position.pixels >= _controller.position.maxScrollExtent -150){
        _loadNextPage();
      }
    });
  }

  void _loadNextPage() async{
    if (isLoading) return;

    setState(() => isLoading = true);
    
    currentPage++;
    
    List<Movie> nextPage = await widget.apiCall(page: currentPage);

    setState(() {
      movieList.addAll(nextPage);
      isLoading = false;     
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: widget.apiCall(), 
      builder: (context, asyncSnapshot){
        if (asyncSnapshot.hasData){
          if(movieList.isEmpty){ //Para garantir que quando o estado for atualizado a movieList é atualizada com os novos filmes e não resetada pelo FutureBuilder
            movieList = asyncSnapshot.requireData;
          }
          return GridView.builder(
            controller: _controller,
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
            }
          );
        }
        return loading;
      }
    );
  }

}