import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:cinelog/models/movie.dart';

const authorization = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMmMyODFjNjNiZmExOTJmZDBmMzE4MzMyMGYyOTE1OCIsIm5iZiI6MTc4MDY3NjYzOC41Mywic3ViIjoiNmEyMmY4MWUyYjBiMmIyYmZkYjYyYWZiIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.vZVmT-0Ytsz8x7sdczNRQrDCDITus33wmENW6TwVabA';

class ApiService{
  static Future getMainPageMovies({int page = 1}) async{
    final response = await _makeRequest(url: 'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-EN&page=$page&sort_by=popularity.desc');

    List movieList = (json.decode(response.body)['results'] as List).map((json) => Movie.fromJson(json: json)).toList();

    return movieList;
  }

  static Future getSearchResults({required String searchValue, required Map filters, int page = 1}) async{
    String? genreValue = filters['genre'] ; 
    String? languageValue = filters['language'] ; 
    String? yearValue = filters['year'] ;
    String? ageRatingValue = filters['ageRating'] ; 
    String? ratingValue = filters['rating'] ;

    String url = 'https://api.themoviedb.org/3/search/movie?query=$searchValue&include_adult=${ageRatingValue ?? 'false'}&language=en-US&page=$page';
    
    if (yearValue != null) url = '$url&primary_release_year=$yearValue';


    final response = await _makeRequest(url: url);
    
    if(genreValue != null || languageValue != null || ratingValue != null){
      
      List results = json.decode(response.body)['results'] as List;

      List filteredResults = [];
      
      for (var element in results) {

        if(_filterSearchResults(element, genreValue, languageValue, ratingValue)){
          filteredResults.add(element);
        }

      }

      return filteredResults.map((json) => Movie.fromJson(json: json)).toList();

    } else {

      List movieList = (json.decode(response.body)['results'] as List).map((json) => Movie.fromJson(json: json)).toList();
      return movieList;

    }
  }

  static bool _filterSearchResults(dynamic element, String? genreValue, String? languageValue, String? ratingValue){
    if(genreValue != null && !(element['genre_ids'] as List).contains(int.parse(genreValue))) return false;

    if(languageValue != null && element['original_language'] != languageValue) return false;

    if(ratingValue != null){
      if(ratingValue == '<5'){
        if(element['vote_average'] > 5.0){
          return false;
        }
      } else if(double.parse(ratingValue) > element['vote_average']  && element['vote_average'] <= double.parse(ratingValue) + 1){
        return false;
      }
    }
    return true;
  }

  static Future getMoviePageDetails({required Movie movie}) async{
    final results = await Future.wait([
      _getMovieGenres(movieId: movie.movieId),
      _getMovieDirector(movieId: movie.movieId)
    ]);
    movie.genres = results[0];
    movie.director = results[1]; 
    return 0;
  }

  static Future getFiltersContent() async{
    Map filtersContent = {};
    final results = await Future.wait([
      _getGenres(),
      _getLanguages()
      //_getCertifications()
    ]);
    filtersContent['genres'] = results[0];
    filtersContent['languages'] = results[1];
    filtersContent['certifications'] = _getCertifications();
    filtersContent['years'] = _makeYearList();
    filtersContent['ratings'] = _makeRatingList();

    return filtersContent;
  }

  static List _makeYearList(){
    List years = [];
    int minPossibleYear = 1800;
    int currentYear = DateTime.now().year;
    while (minPossibleYear <= currentYear) {
      years.add({'id' : currentYear.toString(), 'name' : currentYear.toString()});
      currentYear--;
    }

    return years;
  }

  static List _makeRatingList(){
    List ratingsList = [];

    for (int i = 9; i >= 5; i--){
      if(i > 5){
        ratingsList.add({'id': '$i', 'name': '$i'});
      } else {
        ratingsList.add({'id': '<$i', 'name': '<$i'});
      }
    }

    return ratingsList;
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

    if(response.statusCode == 22) return {'results':[]};

    if (response.statusCode != 200) throw Exception("Não foi possivel fazer a request.");

    return response;
  }
  
  static Future _getGenres() async{
    final response = await _makeRequest(url: 'https://api.themoviedb.org/3/genre/movie/list');

    List genres = (json.decode(response.body)['genres'] as List);
    return genres;
  }

  static Future _getLanguages() async{
    final List<String> relevantLanguages = [
      "en",
      "pt",
      "es",
      "fr",
      "de",
      "it",
      "ja",
      "ko",
      "zh",
      "hi",
      "ru",
      "ar",
      "tr",
      "nl"
    ];
    final response = await _makeRequest(url: 'https://api.themoviedb.org/3/configuration/languages');
    List languages = [];
    for (var element in  (json.decode(response.body) as List)) {
      if(relevantLanguages.contains(element['iso_639_1'])){
        
        String language = "${element['english_name']} (${element['iso_639_1']})";
        languages.add({'id': element['iso_639_1'], 'name': language});
      }
    }
    return languages;
  }

  static List _getCertifications() {
    /*
    final response = await _makeRequest(url: 'https://api.themoviedb.org/3/certification/movie/list');

    Map certifications = (json.decode(response.body)['certifications'] as Map);

    List ptCertifications = [];
    
    for (var element in  certifications['PT'] as List) {
        ptCertifications.add({'id': element['certification'], 'name': element['certification']});
      
    }

    return ptCertifications;
  }
  */

    return [{'id': 'true', 'name': 'Para adultos'}]; 
  }
}