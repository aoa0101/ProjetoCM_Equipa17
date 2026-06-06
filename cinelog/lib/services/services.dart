import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:cinelog/models/movie.dart';

const authorization = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMmMyODFjNjNiZmExOTJmZDBmMzE4MzMyMGYyOTE1OCIsIm5iZiI6MTc4MDY3NjYzOC41Mywic3ViIjoiNmEyMmY4MWUyYjBiMmIyYmZkYjYyYWZiIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.vZVmT-0Ytsz8x7sdczNRQrDCDITus33wmENW6TwVabA';

class ApiService{
  static Future getMainPageMovies({int page = 1}) async{
    final response = await _makeRequest(url: 'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-EN&page=$page&sort_by=popularity.desc');

    List movieList = (json.decode(response.body)['results'] as List).map((json) => Movie.fromJson(json)).toList();

    return movieList;
  }

  static Future getMoviePageDetails({required Movie movie}) async{
    movie.genres = await _getMovieGenres(movieId: movie.movieId);
    movie.director = await _getMovieDirector(movieId: movie.movieId); 
    return 0;
  }

  static Future _getMovieGenres({required int movieId}) async{
    final response = await _makeRequest(url: 'https://api.themoviedb.org/3/movie/$movieId');

    List movieGenres = (json.decode(response.body)['genres'] as List);

    List genreNames = [];
    
    for (var genre in movieGenres) {
      genreNames.add(genre['name']);
    }

    return genreNames;
  }

  static Future _getMovieDirector({required int movieId}) async{
    final response = await _makeRequest(url: 'https://api.themoviedb.org/3/movie/$movieId/credits');

    List crew = (json.decode(response.body)['crew'] as List);

    for (var element in crew) {
      if(element['job'] == 'Director') return element['name']; 
    }

  }

  static Future _makeRequest({required String url}) async{
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': authorization
      });

    if (response.statusCode != 200) throw Exception("Não foi possivel fazer a request.");

    return response;
  }
}