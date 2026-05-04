import 'package:cinelog/main_app_screens/movie_widgets/movie_card.dart';
import 'package:flutter/material.dart';

class MovieGrid extends StatelessWidget {
  final bool neverScrollable;
  
  const MovieGrid({super.key, this.neverScrollable = false});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: neverScrollable ? NeverScrollableScrollPhysics() : null,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, 
      crossAxisSpacing: 20,
      mainAxisSpacing: 25,
      childAspectRatio: 0.75,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const MovieCard();
      }, 
    );
  }
}