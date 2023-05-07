import 'package:weather_app_flutter/repository/location.dart';

class OpenWeatherUri {
  String? baseUri;
  String? units;
  Location? loc;
  String? apiKey;

  String? cityName;
  String? limit;

  OpenWeatherUri.forWeather({this.baseUri, this.units,this.loc, this.apiKey});
  OpenWeatherUri.forGeocode({this.baseUri, this.cityName, this.limit, this.apiKey});

  Uri toUri() {
    return Uri.parse('$baseUri?units=$units&lat=${loc?.lat}&lon=${loc?.lon}&appid=$apiKey');
  }

  Uri toUriGeocode() {
    return Uri.parse('$baseUri?q=${cityName ?? ""},&limit=${limit ?? ""}&appid=$apiKey');
  }
}
