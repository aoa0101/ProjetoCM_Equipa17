import 'package:cinelog/color_scheme.dart';
import 'package:cinelog/main_app_screens/movie_widgets/movie_card.dart';
import 'package:cinelog/models/loading.dart';
import 'package:cinelog/models/movie.dart';
import 'package:cinelog/services/services.dart';
import 'package:flutter/material.dart';

class MovieGrid extends StatefulWidget {
  final bool neverScrollable;
  final String? searchQuery;
  final ScrollController? controller;
  final Map? filters;
  const MovieGrid({super.key, this.neverScrollable = false, this.controller, this.searchQuery, this.filters});

  @override
  State<StatefulWidget> createState() => MovieGridState();  

}

class MovieGridState extends State<MovieGrid> {
  List<Movie> movieList = [];
  int currentPage = 1;
  ScrollController _controller = ScrollController();
  bool isLoading = false;
  String latestSearch = '';
  Future? future;
  
  @override
  void initState() {
    super.initState();
    if(widget.controller != null) _controller = widget.controller!;
    future = widget.searchQuery == null ? ApiService.getMainPageMovies() : ApiService.getSearchResults(searchValue: widget.searchQuery!, filters: widget.filters!);
    _loadFirstPage();
    
    _controller.addListener(() async {
      if(_controller.position.pixels >= _controller.position.maxScrollExtent - 150){
        _loadNextPage();
      }
    });
  }

  @override
  void didUpdateWidget(covariant MovieGrid oldWidget) {
    super.didUpdateWidget(oldWidget);

      movieList.clear();
      future = widget.searchQuery == null ? ApiService.getMainPageMovies() : ApiService.getSearchResults(searchValue: widget.searchQuery!, filters: widget.filters!);
      _loadFirstPage();
  }

  void _loadFirstPage() async{
    if (isLoading) return;
    currentPage = 1;
    setState(() => isLoading = true);
    
    List<Movie> firstPage = 
    widget.searchQuery == null ?
     await ApiService.getMainPageMovies(page: currentPage) : 
     await ApiService.getSearchResults(page: currentPage, searchValue: widget.searchQuery!, filters: widget.filters!);

    setState(() {
      movieList = firstPage;
      isLoading = false;     
    });
  }

  void _loadNextPage() async{
    if (isLoading) return;

    setState(() => isLoading = true);
    
    currentPage++;

    List<Movie> nextPage = 
    widget.searchQuery == null ?
     await ApiService.getMainPageMovies(page: currentPage) : 
     await ApiService.getSearchResults(page: currentPage, searchValue: widget.searchQuery!, filters: widget.filters!);

    setState(() {
      movieList.addAll(nextPage);
      isLoading = false;     
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: future, 
      builder: (context, asyncSnapshot){
        if (asyncSnapshot.hasData){
          
          if(movieList.isEmpty && widget.searchQuery == null){ //Para garantir que quando o estado for atualizado a movieList é atualizada com os novos filmes e não resetada pelo FutureBuilder

            movieList = asyncSnapshot.requireData;
          
          } else if(widget.searchQuery != null){

            if (latestSearch.isEmpty || latestSearch != widget.searchQuery) {

              latestSearch = widget.searchQuery!;
              movieList = asyncSnapshot.requireData;
            }

          }

          return GridView.builder(
            controller: widget.controller == null ? _controller : null,
            shrinkWrap: true,
            physics: widget.neverScrollable ? NeverScrollableScrollPhysics() : null,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: movieList.isEmpty ? 1 : 2, 
              crossAxisSpacing: 20,
              mainAxisSpacing: 25,
              childAspectRatio: movieList.isEmpty ? 1 : 0.75,
            ),
            itemCount: movieList.isEmpty ? 1 : movieList.length,
            itemBuilder: (context, index) {
              if(movieList.isEmpty) {
                return Center(
                    heightFactor: 10,
                    child: Text(
                      'Sem resultados', 
                      style: TextStyle(
                        color: SECONDARY_COLOR,
                        fontSize: 25
                      )
                    ),
                  ); 
              }
              return  MovieCard(movie: movieList[index]);
            }
          ); 
        }
        return loading;
      }
    );
  }

}