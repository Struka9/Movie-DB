import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_db/models/movie_details.dart';

import '../../network_requests.dart';

class DetailsScreen extends StatelessWidget {
  final int movieId;

  const DetailsScreen({Key key, this.movieId}) : super(key: key);

  @override
  build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MovieDetails>(
        future: getMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return DetailsBody(
            movie: snapshot.data,
          );
        },
      ),
    );
  }
}

class DetailsBody extends StatelessWidget {
  final MovieDetails movie;

  const DetailsBody({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;

    final canvasHeight = displaySize.height * .5;
    final imageHeight = displaySize.height * .45;

    final runtimeHours = movie.runtime.inHours;
    final runtimeMinutes =
        movie.runtime.inMinutes - (movie.runtime.inHours * 60);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              height: canvasHeight,
            ),
            Container(
              height: imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    40,
                  ),
                  bottomRight: Radius.circular(
                    40,
                  ),
                ),
                image: DecorationImage(
                  alignment: Alignment(0, 1),
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                    buildImageUrl(
                      movie.poster_path,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: (canvasHeight - imageHeight) - 40,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 16,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: kElevationToShadow[1],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      topLeft: Radius.circular(
                        50,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  width: displaySize.width * .8,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/star_fill.svg",
                              width: 36,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${movie.vote_average}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          fontSize: 15,
                                        ),
                                  ),
                                  TextSpan(
                                    text: "/10",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "${movie.vote_count}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/star.svg",
                              width: 36,
                            ),
                            Text("Rate This"),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              child: SizedBox(
                                height: 30,
                                width: 36,
                                child: Center(
                                  child: Text(
                                    "99",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    4,
                                  ),
                                ),
                                color: Colors.green[500],
                              ),
                            ),
                            Text(
                              "Metascore",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                            Text("62 critic reviews"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: Text(
            movie.title,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  letterSpacing: 1.1,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                movie.release_date.year.toString(),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.6),
                    ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                "${runtimeHours}h ${runtimeMinutes}min",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.6),
                    ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: Container(
            height: 30,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 4,
              ),
              itemCount: movie.genres.length,
              itemBuilder: (context, index) {
                final genre = movie.genres[index];
                return Chip(
                  backgroundColor: Colors.transparent,
                  label: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      genre['name'],
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.grey[300],
                    ),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: Text(
            "Plot Summary",
            style: Theme.of(context).textTheme.headline5.copyWith(
                  letterSpacing: 1.1,
                ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: Text(
                movie.overview,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: Text(
            "Cast & Crew",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 4,
          ),
          child: FutureBuilder<dynamic>(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 50,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final widgets = snapshot.data
                  .map<Widget>(
                    (e) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: e['profile_path'] != null
                                ? NetworkImage(
                                    buildImageUrl(
                                      e['profile_path'],
                                    ),
                                  )
                                : null,
                          ),
                          Text(
                            e['name'],
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                          Text(
                            e['character'],
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList();

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widgets,
                ),
              );
            },
            future: getCredits(
              movie.id,
            ),
          ),
        )
      ],
    );
  }
}
