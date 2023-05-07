import 'package:weather_app_flutter/bloc/change_location/change_location_contract.dart';

class ChangeLocationViewModel implements ViewModel {
  final Model _model;
  final View _view;

  ChangeLocationViewModel(this._model, this._view);

  @override
  viewDisplayed(String? cityName) async {
    if (cityName != null) {
      final locations = await _model.getLocations(cityName);
      _view.showLocations(locations);
    }
  }

}