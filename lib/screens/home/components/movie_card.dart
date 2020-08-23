import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_db/models/movie.dart';
import 'package:movie_db/screens/details/details.dart';

import '../../../network_requests.dart';

class MovieCard extends StatelessWidget {
  final MovieOverview movie;

  MovieCard({
    @required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openElevation: 0,
      closedElevation: 0,
      closedColor: Colors.transparent,
      openBuilder: (context, action) => DetailsScreen(
        movieId: movie.id,
      ),
      closedBuilder: (context, action) => buildCard(context),
    );
  }

  buildCard(context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  32,
                ),
              ),
              child: Image.network(
                buildImageUrl(
                  movie.poster_path,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              movie.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/star_fill.svg",
                  width: 16,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(movie.vote_avg.toString(),
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 14,
                    )),
              ],
            ),
          ],
        ),
      );
}
