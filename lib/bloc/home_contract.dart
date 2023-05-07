import 'package:weather_app_flutter/repository/location.dart';

abstract class Model {
  Future<Map<String, dynamic>> getOpenWeather(Location loc);
}

abstract class View {
  showWeather(Map<String, dynamic> response);
}

abstract class ViewModel {
  viewDisplayed(Location loc);
}