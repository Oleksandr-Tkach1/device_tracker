import 'package:device_tracker/%20home_page/buttons/camera_button.dart';
import 'package:device_tracker/%20home_page/buttons/get_location_button.dart';
import 'package:device_tracker/authentication_bloc/authentication_bloc.dart';
import 'package:device_tracker/authentication_bloc/authentication_event.dart';
import 'package:device_tracker/helper/device_inf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  //final String deviceName;

  DeviceInfo deviceInfo = DeviceInfo();

  HomeScreen({Key? key, required this.name}) : super(key: key);

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
                    top: 5,
                    right: 43,
                      child: GetLocationButton()
                  ),
                  Positioned(
                    top: 5,
                    left: 45,
                      child: CameraButton()
                  ),
                ],
              ),
            ],
          ),
          Center(child: Text('Welcome $name!')),

          //Center(child: Text(deviceName.toString() != null ? deviceName.toString() : 'none')),
        ],
      ),
    );
  }
}