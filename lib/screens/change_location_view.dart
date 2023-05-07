import 'package:flutter/material.dart';
import 'package:weather_app_flutter/bloc/change_location/change_location_contract.dart';
import 'package:weather_app_flutter/bloc/change_location/change_location_model.dart';
import 'package:weather_app_flutter/bloc/change_location/change_location_view_model.dart';

const double fontSize = 18.0;

class ChangeLocationPage extends StatefulWidget {
  const ChangeLocationPage({Key? key}): super(key: key);

  @override
  _ChangeLocationPageState createState() => _ChangeLocationPageState();

}

class _ChangeLocationPageState extends State<ChangeLocationPage> implements View {

  List<dynamic> _locations = [];
  ViewModel? _viewModel;
  final TextEditingController _locationController = TextEditingController();
  bool _loadingInProgress = true;
  bool _searchSubmitted = false;

  @override
  void initState() {
    super.initState();
    _viewModel = ChangeLocationViewModel(ChangeLocationModel(), this);
  }

  _onLocationSearchHandler(String? cityName) {
    if (cityName != null && cityName != "") {
      _searchSubmitted = true;
      _loadingInProgress = true;
      _viewModel?.viewDisplayed(cityName);
    }
  }

  Widget _buildList() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: _locations.map((e) {
        return _buildListRow(e);
      }).toList(),
    );
  }

  _onLocationSelectHandler(location) {
    Navigator.pop(context, location['loc']);
  }
  
  Widget _buildListRow(location) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: TextButton(
              onPressed: () => _onLocationSelectHandler(location),
              child: Text('${location['name']}, ${location['country']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: fontSize)),
          ))
        ],
      ),
    );
  }

  Widget _buildTextField() {

    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: TextField(
        controller: _locationController,
        style: const TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            labelText: "City Name",
        ),
        onSubmitted: (val) => _onLocationSearchHandler(val),
        textInputAction: TextInputAction.go
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (!_loadingInProgress && _searchSubmitted) {
      return Scaffold(
          body: Column (
              children: <Widget>[
                const SizedBox(height: 50.0),
                _buildTextField(),
                _buildList(),
          ],
    )

    );
    } else {
      return Scaffold(
          body: Column (
            children: <Widget>[
              const SizedBox(height: 50.0),
              _buildTextField()
            ],
          )

      );
    }

  }


  @override
  showLocations(List locations) {
     setState(() {
       _locations = locations;
       _loadingInProgress = false;
     });
  }}