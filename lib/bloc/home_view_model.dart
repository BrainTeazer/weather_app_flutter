import 'package:weather_app_flutter/bloc/home_contract.dart';
import 'package:weather_app_flutter/repository/location.dart';

class HomeViewModel implements ViewModel {
  final Model _model;
  final View _view;

  HomeViewModel(this._model, this._view);

  @override
  viewDisplayed(Location loc) async {
    final response = await _model.getOpenWeather(loc);
    _view.showWeather(response);
  }

}