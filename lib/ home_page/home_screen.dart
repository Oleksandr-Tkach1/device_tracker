import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:device_tracker/%20home_page/buttons/camera_button.dart';
import 'package:device_tracker/%20home_page/buttons/get_location_button.dart';
import 'package:device_tracker/authentication_bloc/authentication_bloc.dart';
import 'package:device_tracker/authentication_bloc/authentication_event.dart';
import 'package:device_tracker/geolocation.dart';
import 'package:device_tracker/helper/device_inf.dart';
import 'package:device_tracker/search/screen_search.dart';
import 'package:device_tracker/services/background_workmanager.dart';
import 'package:device_tracker/services/firebase_data_transfer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreen extends StatefulWidget {
  final String name;


  HomeScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
///
  late double? longitude;
  late double? latitude;
  LocationInfo locationInfo = LocationInfo();

  @override
  void initState() {
    // Workmanager().initialize(
    //   callbackDispatcher,
    //   isInDebugMode: true,
    // );
    Workmanager().registerPeriodicTask(
      "1",
      simplePeriodicTask,
      frequency: Duration(minutes: 15),
    );
    //onCallback();
    super.initState();
  }

  // void onCallback(){
  //   Timer.periodic(Duration(minutes:  3), (Timer t) {
  //     BackgroundLocation.getLocationUpdates((location) {
  //       longitude = location.longitude;
  //       latitude = location.latitude;
  //     });
  //     print(longitude);
  //     print(latitude);
  //     ///
  //     return firebaseDataTransfer(latitude: latitude, longitude: longitude);
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white, size: 45,
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(padding: const EdgeInsets.only(top: 115)),
              Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                      Container(
                        width: 116,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                        ),
                      ),
                  Positioned(
                    top: 6,
                    right: 43,
                      child: GetLocationButton()
                  ),
                  Positioned(
                    top: 6,
                    left: 45,
                      child: CameraButton()
                  ),
                ],
              ),
            ],
          ),
          Center(child: Text('Welcome ${widget.name}!')),

          //Center(child: Text(deviceName.toString() != null ? deviceName.toString() : 'none')),
        ],
      ),
    );
  }
}