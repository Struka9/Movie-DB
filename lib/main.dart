import 'package:flutter/material.dart';
import 'package:movie_db/constants.dart';
import 'package:movie_db/screens/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0.0,
        ),
        accentColor: kSecondaryColor,
      ),
      darkTheme: ThemeData.dark(),
      home: Home(),
    );
  }
}
