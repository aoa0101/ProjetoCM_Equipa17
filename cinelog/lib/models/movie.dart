class Movie{
  final int movieId;
  final String title;
  final String description;
  final String imgPath;
  final double ratingAverage;
  final String language;
  List genres;
  String director;

  Movie({
    required this.movieId, 
    required this.title,
    required this.description,
    required this.imgPath,
    required this.ratingAverage,
    required this.language,
    this.genres = const ['Não disponível'],
    this.director = 'Não disponível'
    });

  factory Movie.fromJson({required Map<String, dynamic> json, String? genre, String? language, String? rating}){
    String fixedPath = 'https://image.tmdb.org/t/p/w500${json["poster_path"]}';

    return Movie(
      movieId: json["id"] as int,
      title: json["title"] as String,
      description: json["overview"] as String,
      imgPath: fixedPath,
      ratingAverage: json["vote_average"] is int ? json['vote_average'].toDouble() : json['vote_average'] as double,
      language: json['original_language'].toUpperCase() as String
    );
  }

  @override
  String toString() {
    return "Movie(id:$movieId,\n title: $title,\n description: $description,\n imgPath: $imgPath,\n ratingAverage: $ratingAverage\n)";
  }

}