class Movie{
  final int idMovie;
  final String title;
  final String description;
  final String imgPath;
  final double ratingAverage;

  Movie({
    required this.idMovie, 
    required this.title,
    required this.description,
    required this.imgPath,
    required this.ratingAverage
    });

  factory Movie.fromJson(Map<String, dynamic> json){
    String fixedPath = 'https://image.tmdb.org/t/p/w500${json["poster_path"]}';
    return Movie(
      idMovie: json["id"] as int,
      title: json["title"] as String,
      description: json["overview"] as String,
      imgPath: fixedPath,
      ratingAverage: json["vote_average"] is int ? json['vote_average'].toDouble() : json['vote_average'] as double
    );
  }

  @override
  String toString() {
    return "Movie(id:$idMovie,\n title: $title,\n description: $description,\n imgPath: $imgPath,\n ratingAverage: $ratingAverage\n)";
  }

}