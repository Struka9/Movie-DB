import 'package:flutter/cupertino.dart';
import 'package:movie_db/constants.dart';

import 'models/movie.dart';

typedef MovieListRequest = Future<List<MovieOverview>> Function();

class HomeScreenModel with ChangeNotifier {
  String _selectedCategory = kMovieCategories.keys.elementAt(0);
  String get selectedCategory => _selectedCategory;

  MovieListRequest get selectedRequest {
    return kMovieCategories[_selectedCategory];
  }

  void selectCategory(String category) {
    assert(kMovieCategories.containsKey(category));
    _selectedCategory = category;
    notifyListeners();
  }
}
