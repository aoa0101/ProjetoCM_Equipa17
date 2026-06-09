import 'dart:async';

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
  final GlobalKey<ActionButtonState> seenKey = GlobalKey();
  final TextEditingController _notesController = TextEditingController();
  bool _isSavingNote = false;

  @override
  void initState() {
    super.initState();
    _loadSavedNote();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _loadSavedNote() async {
    // Passa o ID como int nativo
    String savedNote = await FirestoreService.getUserNote(widget.movie.movieId);
    if (mounted) {
      setState(() {
        _notesController.text = savedNote;
      });
    }
  }

  void _handleSaveNote() async {
    setState(() => _isSavingNote = true);

    try {
      // Passa o ID como int nativo
      await FirestoreService.saveUserNote(
        widget.movie.movieId,
        _notesController.text,
        widget.movie.title,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nota guardada com sucesso! 📝")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro ao guardar a nota. Tenta novamente.")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSavingNote = false);
      }
    }
  }

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
                          decoration: const BoxDecoration(
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

                  // ACTIONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionButton(key: seenKey , icon: Icons.remove_red_eye, label: "Visto", movie: widget.movie),
                      ActionButton(icon: Icons.list, label: "Watchlist", movie: widget.movie),
                      ActionButton(icon: Icons.favorite_border, label: "Favorito", movie: widget.movie, onSeenChanged: (value) {
                        seenKey.currentState?.setSeen(value);
                      },),
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

                  // NOTES TITLE
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
                      controller: _notesController,
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

                  const SizedBox(height: 12),

                  // BOTÃO DE GUARDAR AS NOTAS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: _isSavingNote ? null : _handleSaveNote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SECONDARY_COLOR,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: _isSavingNote
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.black,
                                ),
                              )
                            : const Icon(Icons.save, size: 18),
                        label: const Text(
                          "Guardar Nota",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
  final ActionButton? seenButton;
  final Function(bool)? onSeenChanged;
  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.movie,
    this.seenButton,
    this.onSeenChanged
  });

  @override
  State<ActionButton> createState() => ActionButtonState();
}

class ActionButtonState extends State<ActionButton> {
  bool _isActive = false;
  bool _isLoading = false; 


  @override
  void initState() {
    super.initState();
    _checkInitialState();
  }

    void setSeen(bool value) {
      setState(() {
        _isActive = value;
      });
    }

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
          await FirestoreService.generateNotification(
            "Filme na Watchlist! 📌",
            "Não te esqueças de ver '${widget.movie!.title}' mais tarde!",
          );
        }
      } else if (widget.label == "Favorito") {
        if (previousState) {
          await FirestoreService.removeFromFavorites(widget.movie!.movieId);
        } else {
          if(widget.onSeenChanged != null){ 
            widget.onSeenChanged!.call(true);
          }
          await FirestoreService.addToWatched(widget.movie!);
          await FirestoreService.addToFavorites(widget.movie!);
          await FirestoreService.generateNotification(
            "Novo Favorito! ❤️",
            "Adicionaste '${widget.movie!.title}' aos teus filmes favoritos.",
          );
        }
      } else if (widget.label == "Visto") {
        if (previousState) {
          await FirestoreService.removeFromWatched(widget.movie!.movieId);
        } else {
          await FirestoreService.addToWatched(widget.movie!);
          await FirestoreService.generateNotification(
            "Mais um para a conta! 🍿",
            "Marcaste '${widget.movie!.title}' como visto.",
          );
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