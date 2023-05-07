import 'package:flutter/material.dart';
import 'package:weather_app_flutter/constants.dart';
import 'package:weather_app_flutter/screens/change_location_view.dart';
import 'package:weather_app_flutter/screens/home_view.dart';

ColorSeed colorSelected = ColorSeed.blue;


void main()  => runApp(MaterialApp(
  theme: ThemeData(
    colorSchemeSeed: colorSelected.color,
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }
        ),
    brightness: Brightness.dark,
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => const HomePage(),
    '/changeLocation': (context) => const ChangeLocationPage()
  },
));

