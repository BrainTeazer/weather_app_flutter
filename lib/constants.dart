import 'package:flutter/material.dart';
import 'package:weather_app_flutter/apiKey.dart';

class Constants {
  static String? apiKey = ApiKey.openWeatherApiKey.key;

  static String? uriWeather = 'https://api.openweathermap.org/data/2.5/weather';
  static String? units = 'metric';
  static String? uriGeocode = 'https://api.openweathermap.org/geo/1.0/direct';
  static int? limit = 5; // max is 5
  static String? imagePath = 'assets/images';

  static Image getImage (image, height) => Image.asset('$imagePath/$image', height: height,);


}

enum ColorSeed {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;

}