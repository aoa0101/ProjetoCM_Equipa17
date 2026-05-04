import 'package:flutter/material.dart';
import 'package:cinelog/color_scheme.dart';
import 'package:go_router/go_router.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});
  static const sectionSpace = SizedBox(height: 28);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // HEADER
              Stack(
                children: [

                  Container(
                    height: 220,
                    color: const Color(0xFFEBEBEB),
                    child: const Center(
                      child: Icon(
                        Icons.movie,
                        size: 80,
                        color: Colors.black26,
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Image.asset(
                      'assets/movie.jpg',
                      fit: BoxFit.cover,

                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox();
                      },
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
                      backgroundColor: APPBAR_BACKGROUND_COLOR.withOpacity(0.7),
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
                      "Um Sonho de Liberdade",
                      style: TextStyle(
                        color: SECONDARY_COLOR,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              sectionSpace,

              // ACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionButton(icon: Icons.remove_red_eye, label: "Visto"),
                  ActionButton(icon: Icons.list, label: "Watchlist"),
                  ActionButton(icon: Icons.favorite_border, label: "Favorito"),
                ],
              ),

              sectionSpace,

              // STARS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Icon(Icons.star, color: SECONDARY_COLOR),
                ),
              ),

              sectionSpace,

              // SCORE
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                    color: SECONDARY_COLOR,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "9.3 / 10",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              sectionSpace,

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
                              text: "Frank Darabont",
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
                              text: "Drama",
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
                                text: "Inglês",
                                style: TextStyle(color: SECONDARY_COLOR),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  sectionSpace,

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

              sectionSpace,

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

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Em 1947, o jovem banqueiro Andy Dufresne é...",
                  style: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
   final IconData icon; 
   final String label; 
   const ActionButton({ super.key, required this.icon, required this.label, }); 
   
   @override Widget build(BuildContext context) { 
    return Column( children: [ 
      CircleAvatar( 
        backgroundColor: Colors.white10, 
        child: Icon(icon, color: SECONDARY_COLOR), 
        ), 
        const SizedBox(height: 5), 
        Text(label, style: const TextStyle(color: Colors.white70)), 
      ], 
    ); 
  } 
}