import 'package:flutter/material.dart';

class MovieDetails {
  final title;
  final id;
  final genres;
  final overview;
  final DateTime release_date;
  final Duration runtime;
  final vote_count;
  final vote_average;
  final poster_path;

  MovieDetails({
    @required this.title,
    @required this.id,
    @required this.genres,
    @required this.overview,
    @required this.release_date,
    @required this.runtime,
    @required this.vote_count,
    @required this.vote_average,
    @required this.poster_path,
  });

  MovieDetails.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        genres = json['genres'],
        overview = json['overview'],
        release_date = DateTime.parse(json['release_date']),
        runtime = Duration(minutes: json['runtime']),
        vote_count = json['vote_count'],
        vote_average = json['vote_average'],
        poster_path = json['poster_path'];
}
