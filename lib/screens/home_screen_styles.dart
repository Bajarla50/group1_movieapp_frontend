import 'package:flutter/material.dart';

class HomeScreenStyles {
  static const gradientBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.black, Color(0xFF201F1F)],
      stops: [0.525, 1.0],
    ),
  );

  static const searchBarDecoration = InputDecoration(
    hintStyle: TextStyle(color: Colors.grey),
    filled: true,
    fillColor: Colors.white10,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(color: Color(0xFF5C67D1)),
    ),
  );

  static const titleStyle = TextStyle(
    fontFamily: 'PT Serif Caption',
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  static const movieTitleStyle = TextStyle(
    fontFamily: 'Prata',
    fontSize: 32,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  static const movieTagsStyle = TextStyle(
    fontFamily: 'Anek Kannada',
    fontSize: 10,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  static const seeMoreStyle = TextStyle(
    fontFamily: 'League Spartan',
    fontSize: 20,
    color: Color(0xFF9F9F9F),
    fontWeight: FontWeight.w300,
  );

  static const bottomNavBarTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Color(0xFF5C67D1),
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  );
}
