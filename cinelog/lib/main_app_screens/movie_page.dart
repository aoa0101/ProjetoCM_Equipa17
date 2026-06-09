import 'package:cinelog/models/loading.dart';
import 'package:cinelog/models/movie.dart';
import 'package:cinelog/services/services.dart';
import 'package:cinelog/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:cinelog/color_scheme.dart';
import 'package:go_router/go_router.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;
  
  const MoviePage({super.key, required this.movie});
 
  static const sectionSpace = SizedBox(height: 28);
  
  @override
  State<StatefulWidget> createState() => MoviePageState();
}

class MoviePageState extends State<MoviePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: FutureBuilder(
        future: ApiService.getMoviePageDetails(movie: widget.movie), 
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) { 
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(widget.movie.imgPath),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black54,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: CircleAvatar(
                          backgroundColor: APPBAR_BACKGROUND_COLOR.withValues(alpha: 0.7),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: SECONDARY_COLOR),
                            onPressed: () => context.pop(),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Text(
                          widget.movie.title,
                          style: TextStyle(
                            color: SECONDARY_COLOR,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  MoviePage.sectionSpace,

                  // ACTIONS (Agora todos passam o filme)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionButton(icon: Icons.remove_red_eye, label: "Visto", movie: widget.movie),
                      ActionButton(icon: Icons.list, label: "Watchlist", movie: widget.movie),
                      ActionButton(icon: Icons.favorite_border, label: "Favorito", movie: widget.movie),
                    ],
                  ),

                  MoviePage.sectionSpace,

                  // STARS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _generateStarRating(movie: widget.movie)
                  ),

                  MoviePage.sectionSpace,

                  // SCORE
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                        color: SECONDARY_COLOR,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${widget.movie.ratingAverage.toStringAsFixed(1)} / 10',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  MoviePage.sectionSpace,

                  // DETAILS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Detalhes",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                            children: [
                              const TextSpan(text: "Diretor/Criador: "),
                              TextSpan(
                                text: widget.movie.director,
                                style: TextStyle(color: SECONDARY_COLOR),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                            children: [
                              const TextSpan(text: "Género: "),
                              TextSpan(
                                text: widget.movie.genres.join(", "),
                                style: TextStyle(color: SECONDARY_COLOR),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                            children: [
                              const TextSpan(text: "Idioma: "),
                              TextSpan(
                                text: widget.movie.language,
                                style: TextStyle(color: SECONDARY_COLOR),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  MoviePage.sectionSpace,

                  // NOTES
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "As minhas notas:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  MoviePage.sectionSpace,

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Escreve a tua opinião...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: OPTION_BUTTON_BACKGROUND_COLOR,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // SINOPSIS
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Sinopse",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.movie.description,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              )
            );
          }
          return loading;
        }
      ),
    );
  }
}

List<Widget> _generateStarRating({required Movie movie}){
  num rating = movie.ratingAverage/2;
  return List.generate(5, (index) {
    if(rating >= index + 1){
      return Icon(Icons.star, color: SECONDARY_COLOR);
    } else if(rating < index && rating > index + 1){
      return Icon(Icons.star_half, color: SECONDARY_COLOR);
    } else {
      return Icon(Icons.star_border, color: SECONDARY_COLOR);
    }
  });
}

class ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Movie? movie;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.movie,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isActive = false;
  bool _isLoading = false; 

  @override
  void initState() {
    super.initState();
    _checkInitialState();
  }

  // Verifica na BD se o filme já está na respetiva coleção ao abrir o ecrã
  void _checkInitialState() async {
    if (widget.movie == null) return;
    
    bool val = false;
    if (widget.label == "Watchlist") {
      val = await FirestoreService.isInWatchlist(widget.movie!.movieId);
    } else if (widget.label == "Favorito") {
      val = await FirestoreService.isInFavorites(widget.movie!.movieId);
    } else if (widget.label == "Visto") {
      val = await FirestoreService.isInWatched(widget.movie!.movieId);
    }

    if (mounted) {
      setState(() => _isActive = val);
    }
  }

  void _handleTap() async {
    if (widget.movie == null || _isLoading) return;

    final previousState = _isActive;

    setState(() {
      _isLoading = true;
      _isActive = !_isActive; 
    });

    try {
      if (widget.label == "Watchlist") {
        if (previousState) {
          await FirestoreService.removeFromWatchlist(widget.movie!.movieId);
        } else {
          await FirestoreService.addToWatchlist(widget.movie!);
        }
      } else if (widget.label == "Favorito") {
        if (previousState) {
          await FirestoreService.removeFromFavorites(widget.movie!.movieId);
        } else {
          await FirestoreService.addToFavorites(widget.movie!);
        }
      } else if (widget.label == "Visto") {
        if (previousState) {
          await FirestoreService.removeFromWatched(widget.movie!.movieId);
        } else {
          await FirestoreService.addToWatched(widget.movie!);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isActive = previousState;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao atualizar ${widget.label}. Tenta novamente.")),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Muda dinamicamente o ícone do coração se estiver ativo
    IconData displayIcon = widget.icon;
    if (widget.label == "Favorito") {
      displayIcon = _isActive ? Icons.favorite : Icons.favorite_border;
    }

    return Column(
      children: [
        IconButton(
          onPressed: _isLoading ? null : _handleTap, 
          style: IconButton.styleFrom(
            backgroundColor: _isActive ? SECONDARY_COLOR.withValues(alpha: 0.3) : Colors.white10,
          ),
          icon: _isLoading 
              ? SizedBox(
                  width: 24, 
                  height: 24, 
                  child: CircularProgressIndicator(strokeWidth: 2, color: SECONDARY_COLOR),
                )
              : Icon(
                  displayIcon,
                  color: _isActive ? SECONDARY_COLOR : Colors.white70,
                ),
        ),
        const SizedBox(height: 5),
        Text(widget.label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}