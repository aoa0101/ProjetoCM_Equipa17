import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:cinelog/models/movie.dart';

class ApiService{
  static Future getMainPageMovies({int page = 1}) async{
    final url = Uri.parse('https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=$page&sort_by=popularity.desc');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMmMyODFjNjNiZmExOTJmZDBmMzE4MzMyMGYyOTE1OCIsIm5iZiI6MTc4MDY3NjYzOC41Mywic3ViIjoiNmEyMmY4MWUyYjBiMmIyYmZkYjYyYWZiIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.vZVmT-0Ytsz8x7sdczNRQrDCDITus33wmENW6TwVabA'
      });

    if (response.statusCode != 200) throw Exception("Não foi possivel fazer a request.");
    List movieList = (json.decode(response.body)['results'] as List).map((json) => Movie.fromJson(json)).toList();
    for (int i = 0; i < movieList.length; i++){
      //print(movieList[i]);
    }
    return movieList;
  }
}