import 'package:device_tracker/geolocation.dart';
import 'package:flutter/material.dart';

class GetLocationButton extends StatelessWidget {
  final VoidCallback? _onPressed;
  LocationInfo position = LocationInfo();

  GetLocationButton({Key? key, VoidCallback? onPressed}): _onPressed = onPressed, super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      shape: CircleBorder(),
      padding: EdgeInsets.all(7),
      //TODO
      onPressed: () async {
        //Navigate to CitySearchScreen
        await position.getUserLocationData();
        //TODO
        if (position != null) {
          //await BlocProvider.of<WeatherGeolocationBloc>(context).add(WeatherEventRequested(latitude: position.latitude, longitude: position.longitude));
          print(position.longitude);
          print(position.latitude);
        }
        //Navigator.pop(context);
      },      child: Icon(Icons.location_on_outlined, size: 30, color: Colors.white,),
    );
  }
}