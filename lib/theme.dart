import 'package:flutter/material.dart';


MaterialColor PrimaryMaterialColor = MaterialColor(
  4293821878,
  <int, Color>{
    50: Color.fromRGBO(
      238,
      133,
      182,
      .1,
    ),
    100: Color.fromRGBO(
      238,
      133,
      182,
      .2,
    ),
    200: Color.fromRGBO(
      238,
      133,
      182,
      .3,
    ),
    300: Color.fromRGBO(
      238,
      133,
      182,
      .4,
    ),
    400: Color.fromRGBO(
      238,
      133,
      182,
      .5,
    ),
    500: Color.fromRGBO(
      238,
      133,
      182,
      .6,
    ),
    600: Color.fromRGBO(
      238,
      133,
      182,
      .7,
    ),
    700: Color.fromRGBO(
      238,
      133,
      182,
      .8,
    ),
    800: Color.fromRGBO(
      238,
      133,
      182,
      .9,
    ),
    900: Color.fromRGBO(
      238,
      133,
      182,
      1,
    ),
  },
);

ThemeData myTheme = ThemeData(
  fontFamily: "customFont",
  primaryColor: const Color(0xffee85b6),

  primarySwatch: PrimaryMaterialColor,
);
