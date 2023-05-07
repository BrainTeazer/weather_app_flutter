import 'package:weather_app_flutter/repository/temperature.dart';
import 'package:weather_app_flutter/repository/weather_repo.dart';
import 'package:weather_app_flutter/repository/wind.dart';

class OpenWeather implements Weather {
  @override
  final String weatherGroup;

  @override
  final String weatherDescription;

  OpenWeather({required this.weatherGroup, required this.weatherDescription});

  factory OpenWeather.fromJson(Map<String, dynamic> json) {
    return OpenWeather(
        weatherGroup: json['main'],
        weatherDescription: json['description']
    );
  }
}

class OpenWeatherTemperature implements Temperature {
  @override
  final double temp;

  @override
  final double feelsLike;

  @override
  final double tempMin;

  @override
  final double tempMax;

  OpenWeatherTemperature({required this.temp, required this.feelsLike, required this.tempMin, required this.tempMax});


  factory OpenWeatherTemperature.fromJson(Map<String, dynamic> json) {
    return OpenWeatherTemperature(
        temp: json['temp'].toDouble(),
        feelsLike: json['feels_like'].toDouble(),
        tempMin: json['temp_min'].toDouble(),
        tempMax: json['temp_max'].toDouble()
    );
  }
}

class OpenWeatherWind implements Wind {
  @override
  final double speed;

  @override
  final double deg;

  @override
  final double? gust;

  OpenWeatherWind({required this.speed, required this.deg, this.gust});


  factory OpenWeatherWind.fromJson(Map<String, dynamic> json) {
    return OpenWeatherWind(
        speed: json['speed'].toDouble(),
        deg: json['deg'].toDouble(),
        gust: json['gust']?.toDouble(),
    );
  }

}