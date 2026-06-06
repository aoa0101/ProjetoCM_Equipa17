import 'package:cinelog/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinelog/color_scheme.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: () => context.push("/movie"),
      borderRadius: BorderRadius.circular(8),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              movie.imgPath,
              fit: BoxFit.cover,
            )
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0x408B8B8B),
                    SECONDARY_COLOR.withValues(alpha: 0.9),
                  ],
                ),
              ),
            ),
          ),
          
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                movie.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    )
  );
  }
}