import 'package:cinelog/models/loading.dart';
import 'package:cinelog/models/movie.dart';
import 'package:cinelog/services/services.dart';
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
      
      body: FutureBuilder(future: ApiService.getMoviePageDetails(movie: widget.movie), 
          builder: (context, asyncSnapshot){
            if (asyncSnapshot.hasData){ 
              return SingleChildScrollView(
                child: 
                Column(
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
                            image: DecorationImage(image: NetworkImage(widget.movie.imgPath),
                            fit: BoxFit.cover)
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
                              onPressed: () {
                                context.pop();
                              },
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
                        ActionButton(icon: Icons.remove_red_eye, label: "Visto"),
                        ActionButton(icon: Icons.list, label: "Watchlist"),
                        ActionButton(icon: Icons.favorite_border, label: "Favorito"),
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
                        child:  Text(
                          '${widget.movie.ratingAverage.toStringAsFixed(1)} / 10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    MoviePage.sectionSpace,

                    // DETAILS
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
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

                          SizedBox(height: 10),

                          // Diretor
                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.white70, fontSize: 14),
                                children: [
                                  TextSpan(text: "Diretor/Criador: "),
                                  TextSpan(
                                    text: widget.movie.director,
                                    style: TextStyle(color: SECONDARY_COLOR),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Género
                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.white70, fontSize: 14),
                                children: [
                                  TextSpan(text: "Género: "),
                                  TextSpan(
                                    text: widget.movie.genres.join(", "),
                                    style: TextStyle(color: SECONDARY_COLOR),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Idioma
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.white70, fontSize: 14),
                                  children: [
                                    TextSpan(text: "Idioma: "),
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.movie.description,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                )
              );
            }
            return loading;
          }),
      );
  }

}

List<Widget> _generateStarRating({required Movie movie}){
  num rating = movie.ratingAverage/2;

  return List.generate(5,
    (index) {
      if(rating >= index + 1){
        return Icon(Icons.star, color: SECONDARY_COLOR);
      } else if(rating < index && rating > index + 1){
        return Icon(Icons.star_half, color: SECONDARY_COLOR);
      } else {
        return Icon(Icons.star_border, color: SECONDARY_COLOR);
      }
    } 
  );
}

class ActionButton extends StatelessWidget {
   final IconData icon; 
   final String label; 
   const ActionButton({ super.key, required this.icon, required this.label, }); 
   
   @override Widget build(BuildContext context) { 
    return Column( children: [ 
      IconButton(
        onPressed: () => {},
        style: IconButton.styleFrom(backgroundColor:  Colors.white10), 
        icon: Icon(icon, color: SECONDARY_COLOR), 
        ), 
        const SizedBox(height: 5), 
        Text(label, style: const TextStyle(color: Colors.white70)), 
      ], 
    ); 
  } 
}