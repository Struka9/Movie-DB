import 'package:flutter/material.dart';
import 'package:movie_db/network_requests.dart';

const kSecondaryColor = Color(0xFFFE6D8E);

const kMovieCategories = {
  "Now Playing": getMoviesNowPlaying,
  "Popular": getMoviesPopular,
  "Coming Soon": getMoviesUpcoming,
};

const kMovieGenres = [];
