import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_db/models/movie.dart';
import 'package:movie_db/movies_notifier.dart';
import 'package:movie_db/network_requests.dart';
import 'package:movie_db/screens/home/components/categories.dart';
import 'package:provider/provider.dart';

import 'components/movie_carrousel.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          splashRadius: 24,
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 24,
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (_) => HomeScreenModel(),
        builder: (context, _) {
          return Column(
            children: [
              Categories(),
              buildFuture(context),
            ],
          );
        },
      ),
    );
  }

  Widget buildFuture(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<MovieOverview>>(
        future: Provider.of<HomeScreenModel>(context).selectedRequest(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final movies = asyncSnapshot.data;

          return MovieCarousel(
            movies: movies,
          );
        },
      ),
    );
  }
}
