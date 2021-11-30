import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_tracker/google_map/services/service.dart';
import 'package:device_tracker/helper/database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  late double? longitude;
  late double? latitude;
  // LatLng? kMapCenter = LatLng(19.018255973653343, 72.84793849278007);


  GoogleMapScreen({Key? key, this.latitude, this.longitude}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  GoogleService googleService = GoogleService();

  // late QuerySnapshot searchSnapshot;
  //
  // Widget searchList(BuildContext globalContext) {
  //   return ListView.builder(
  //         itemCount: searchSnapshot.docs.length,
  //         shrinkWrap: true,
  //         itemBuilder: (context, index) {
  //           return getFirestoreRequest(
  //             longitude: searchSnapshot.docs[index]["longitude"],
  //             latitude: searchSnapshot.docs[index]["latitude"],
  //           );
  //         });
  // }

  late LatLng kMapCenter = LatLng(googleService.latitude, googleService.longitude);

  late CameraPosition _kInitialPosition = CameraPosition(target: LatLng(googleService.latitude, googleService.longitude), zoom: 11.0, tilt: 0, bearing: 0);

  // @override
  // void initState() {
  //   databaseMethods.getUserByData().then((val) {
  //     setState(() {
  //       searchSnapshot = val;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Demo'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
      ),
    );
  }
}

// Widget getFirestoreRequest ({latitude, longitude}){
//   final latitude;
//   final longitude;
// return Container();
// }
