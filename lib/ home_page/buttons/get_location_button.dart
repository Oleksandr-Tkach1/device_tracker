import 'package:device_tracker/%20home_page/alert.dart';
import 'package:device_tracker/geolocation.dart';
import 'package:device_tracker/google_map/screen/googl_map_screen.dart';
import 'package:device_tracker/services/firebase_data_transfer.dart';
import 'package:flutter/material.dart';

class GetLocationButton extends StatelessWidget {
  final VoidCallback? _onPressed;
  TextEditingController TextRoomId = TextEditingController();
  LocationInfo position = LocationInfo();

  GetLocationButton({Key? key, VoidCallback? onPressed}): _onPressed = onPressed, super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      shape: CircleBorder(),
      padding: EdgeInsets.all(7),
      //TODO
      onPressed: () async {

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GoogleMapScreen()));

        //Navigate to CitySearchScreen
        // await position.getUserLocationData();
        // //TODO
        // if (position != null) {
        //   //await BlocProvider.of<WeatherGeolocationBloc>(context).add(WeatherEventRequested(latitude: position.latitude, longitude: position.longitude));
        //   print(position.longitude);
        //   print(position.latitude);
        //   await firebaseDataTransfer(longitude: position.longitude, latitude: position.latitude);
        // }
        //Navigator.pop(context);
      },
      child: Icon(Icons.map, size: 30, color: Colors.green,),
    );
  }
}