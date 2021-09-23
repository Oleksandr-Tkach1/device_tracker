import 'package:device_tracker/%20home_page/buttons/camera_button.dart';
import 'package:device_tracker/%20home_page/buttons/get_location_button.dart';
import 'package:device_tracker/authentication_bloc/authentication_bloc.dart';
import 'package:device_tracker/authentication_bloc/authentication_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Padding(padding: const EdgeInsets.only(top: 15)),
              Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                    width: 150,
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 220, top: 15),
                    child: GetLocationButton(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 280, top: 15),
                    child: CameraButton(),
                  ),
                ],
              ),
            ],
          ),
          Center(child: Text('Welcome $name!')),
        ],
      ),
    );
  }
}