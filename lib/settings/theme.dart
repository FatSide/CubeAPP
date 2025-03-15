import 'package:flutter/material.dart';
import 'package:test_app/colors.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

  textTheme: TextTheme(
      headline6: TextStyle(
        color: verylightblue,
      ),
      headline5: TextStyle(
        color: verylightblue,
        fontSize: 32,
      )
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
  ),

  iconTheme: IconThemeData(
    color: verylightblue,
  ),

  cardTheme: CardTheme(
    color: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  textTheme: TextTheme(
    headline6: TextStyle(
      color: Colors.white,
    ),
    headline5: TextStyle(
      color: Colors.white,
      fontSize: 32,
    )
  ),

  iconTheme: IconThemeData(
    color: Colors.white,
  ),

  scaffoldBackgroundColor: lightgrey,

  appBarTheme: AppBarTheme(
    foregroundColor: lightgrey,
  ),
  cardTheme: CardTheme(
    color: Colors.black26,
  ),

);

