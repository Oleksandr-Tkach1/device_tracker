import 'package:device_tracker/google_map/bloc_google_map/google_map_bloc.dart';
import 'package:device_tracker/google_map/bloc_google_map/google_map_state.dart';
import 'package:device_tracker/google_map/services/service.dart';
import 'package:device_tracker/helper/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
 late final double? latitude;
 late final double? longitude;

  GoogleMapScreen({this.latitude, this.longitude});

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  late GoogleMapController mapController;
  DatabaseMethods databaseMethods = DatabaseMethods();
  GoogleService googleService = GoogleService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Demo'),
      ),
      body: BlocBuilder<GoogleMapBloc, GoogleMapState>(
        builder: (context, state) {
          if (state is GoogleMapLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          if (state is GoogleMapLoaded){
            ///
            //final locationModel = state.locationModel;
              var ltLn = state.locationModel.map((loc) => LatLng(loc.latitude.toDouble(), loc.longitude.toDouble()));
            return Container(child: Text(state.locationModel.toString()),);
            //   GoogleMap(
            //   myLocationEnabled: true,
            //   //initialCameraPosition: _kInitialPosition,
            //   initialCameraPosition: CameraPosition(target: ltLn, zoom: 11.0, tilt: 0, bearing: 0),
            //   //state.locationModel,
            //   //CameraPosition(target: LatLng(-122, 83),zoom: 11.0,tilt: 0,bearing: 0),
            //   //markers: searchList(globalContext),
            //   onMapCreated: _onMapCreated,
            // );
          }else{
            return Text('Received been error');
          }
      }),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      Marker(icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'user'),
          markerId: MarkerId('<MARKER_ID>'),
          //position: LatLng(24.150, -110.32));
          position: LatLng(widget.latitude!.toDouble(), widget.longitude!.toDouble()));
      mapController = controller;
    });
  }
}