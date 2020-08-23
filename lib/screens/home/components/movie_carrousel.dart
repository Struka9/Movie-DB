
import 'package:flutter/material.dart';
import 'package:movie_db/models/movie.dart';

import 'dart:math' as math;

import 'movie_card.dart';

class MovieCarousel extends StatefulWidget {
  final List<MovieOverview> movies;

  MovieCarousel({this.movies});

  @override
  _MovieCarouselState createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    print("Calling init state");
    _pageController = PageController(
      initialPage: _selectedPage,
      // It let's you show a small portion of the other items
      viewportFraction: 0.6,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: PageView.builder(
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        itemCount: widget.movies.length,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          setState(() {
            _selectedPage = value;
          });
        },
        itemBuilder: (context, index) =>
            animatedOpacity(index, widget.movies[index]),
      ),
    );
  }

  Widget animatedOpacity(int index, MovieOverview movie) => AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 0;
          if (_pageController.position.haveDimensions) {
            value = index - _pageController.page;
            // We use 0.038 because 180*0.038 = 7 almost and we need to rotate our poster 7 degree
            // we use clamp so that our value vary from -1 to 1
            value = (value * 0.038).clamp(-1, 1);
          } else if (index != 0) {
            value = 0.038;
          }

          return AnimatedOpacity(
            duration: Duration(
              milliseconds: 350,
            ),
            opacity: index == _selectedPage ? 1 : 0.4,
            child: Transform.rotate(
              angle: math.pi * value,
              child: MovieCard(
                movie: movie,
              ),
            ),
          );
        },
      );
}