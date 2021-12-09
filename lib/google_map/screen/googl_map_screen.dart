import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_tracker/google_map/services/service.dart';
import 'package:device_tracker/helper/database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  var latitude;
  var longitude;

  // final double longitude;
  // final double latitude;
  // LatLng? kMapCenter = LatLng(19.018255973653343, 72.84793849278007);


  GoogleMapScreen({Key? key, this.latitude, this.longitude}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  late GoogleMapController mapController;
  late final double longitude;
  late final double latitude;

  DatabaseMethods databaseMethods = DatabaseMethods();
  GoogleService googleService = GoogleService();

  late QuerySnapshot searchSnapshot;

  // Widget searchList(BuildContext globalContext) {
  //   Set<Marker> _markers= {};
  //   return ListView.builder(
  //         itemCount: searchSnapshot.docs.length,
  //         shrinkWrap: true,
  //         itemBuilder: (context, index) {
  //         return CameraPosition(
  //             target: LatLng(
  //             longitude,
  //             latitude,
  //         ));
  //         // getFirestoreRequest(
  //           //   longitude: searchSnapshot.docs[index]["longitude"],
  //           //   latitude: searchSnapshot.docs[index]["latitude"],
  //           // );
  //         });
  // }

  //static LatLng kMapCenter = LatLng(24.150, -110.32);

  // static final CameraPosition _kInitialPosition = CameraPosition(target: kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

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
                                                                ///
    var _kInitialPosition = CameraPosition(target: LatLng(24.150, -110.32), zoom: 11.0, tilt: 0, bearing: 0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Demo'),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: _kInitialPosition,
        //markers: searchList(globalContext),
        onMapCreated: _onMapCreated,
      ),
    );
  }
  _onMapCreated (GoogleMapController controller){
    setState(() {
      mapController = controller;
    });
  }
}

// Widget getFirestoreRequest ({latitude, longitude}){
//   final latitude;
//   final longitude;
// return Container();
// }
