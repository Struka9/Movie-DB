import 'package:flutter/material.dart';

class MovieOverview {
  final String title;
  final String poster_path;
  final int id;
  final vote_avg;

  MovieOverview({
    @required this.id,
    @required this.title,
    @required this.poster_path,
    @required this.vote_avg,
  });

  factory MovieOverview.fromJson(Map<String, dynamic> json) {
    return MovieOverview(
      id: json['id'],
      title: json['title'],
      poster_path: json['poster_path'],
      vote_avg: json['vote_average'],
    );
  }
}
