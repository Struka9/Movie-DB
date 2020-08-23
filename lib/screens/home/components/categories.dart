import 'package:flutter/material.dart';
import 'package:movie_db/constants.dart';
import 'package:provider/provider.dart';

import '../../../movies_notifier.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<HomeScreenModel>(context);
    final textTheme = Theme.of(context).textTheme.headline5;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: kMovieCategories.keys.map((key) {
          final isThisCategorySelected = provider.selectedCategory == key;
          final widget = GestureDetector(
            onTap: () {
              if (!isThisCategorySelected)
                provider.selectCategory(key);
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
                right: 16,
                left: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    key,
                    style: textTheme.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      color: isThisCategorySelected
                          ? textTheme.color
                          : textTheme.color.withOpacity(
                              0.4,
                            ),
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isThisCategorySelected
                      ? Container(
                          height: 6,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                            color: Theme.of(context).accentColor,
                          ),
                        )
                      : Container(
                          height: 6,
                          width: 0,
                        ),
                ],
              ),
            ),
          );
          return widget;
        }).toList(),
      ),
    );
  }
}
