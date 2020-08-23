import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:movie_db/models/movie.dart';
import 'package:movie_db/models/movie_details.dart';
import 'package:movie_db/secrets.dart';

final kBaseUrl = "https://api.themoviedb.org/3";

final kImageBaseUrl = "http://image.tmdb.org/t/p/";

String buildImageUrl(imagePath) {
  return "${kImageBaseUrl}w342$imagePath";
}

Future<dynamic> getCredits(movieId) async {
  final response =
      await http.get("$kBaseUrl/movie/$movieId/credits?api_key=$kApiKey");

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    return parsed['cast'];
  } else {
    return Future.error(response.statusCode);
  }
}

Future<MovieDetails> getMovieDetails(movieId) async {
  final response = await http.get("$kBaseUrl/movie/$movieId?api_key=$kApiKey");

  if (response.statusCode == 200) {
    final parsedJson = json.decode(response.body);
    return MovieDetails.fromJson(parsedJson);
  } else {
    return Future.error(response.statusCode);
  }
}

Future<List<MovieOverview>> getMoviesUpcoming() async {
  final response = await http.get("$kBaseUrl/movie/upcoming?api_key=$kApiKey");

  if (response.statusCode == 200) {
    return parseMovies(response.body);
  } else {
    return Future.error(response.statusCode);
  }
}

Future<List<MovieOverview>> getMoviesPopular() async {
  final response =
      await http.get("$kBaseUrl/movie/popular?api_key=$kApiKey");

  if (response.statusCode == 200) {
    return parseMovies(response.body);
  } else {
    return Future.error(response.statusCode);
  }
}

Future<List<MovieOverview>> getMoviesNowPlaying() async {
  final response =
      await http.get("$kBaseUrl/movie/now_playing?api_key=$kApiKey");

  if (response.statusCode == 200) {
    return parseMovies(response.body);
  } else {
    return Future.error(response.statusCode);
  }
}

List<MovieOverview> parseMovies(String response) {
  final parsed = json.decode(response);
  final results = parsed['results'];

  final List<MovieOverview> value =
      results.map<MovieOverview>((e) => MovieOverview.fromJson(e)).toList();
  return value;
}
