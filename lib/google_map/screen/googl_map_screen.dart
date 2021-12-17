import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_tracker/google_map/services/service.dart';
import 'package:device_tracker/helper/database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
 final double? latitude;
 final double? longitude;

  GoogleMapScreen({this.latitude, this.longitude});

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  late GoogleMapController mapController;
  DatabaseMethods databaseMethods = DatabaseMethods();
  GoogleService googleService = GoogleService();
  //late Stream stream;
  CollectionReference stream = FirebaseFirestore.instance.collection('ChatRoom');


  // getLocation() async{
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('ChatRoom')
  //       .get();
  //       //.snapshots();
  //   snapshot.docs.forEach((docs) {
  //     snapshot.docs.asMap().forEach((index, data) {
  //       longitude: snapshot.docs[index]["longitude"];
  //       latitude: snapshot.docs[index]["latitude"];
  //     });
  //   });
  // }


   getLocation() {
    return StreamBuilder<QuerySnapshot>(
        stream: stream.snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                print('DEBUG DATA: ' + snapshot.data!.docs[index].data().toString());
                    return getFirestoreRequest(
                      snapshot.data!.docs[index]["latitude"],
                      snapshot.data!.docs[index]["longitude"],
                    );
                  }) : Center(child: Text('Error', style: TextStyle(fontSize: 25, color: Colors.white)));
        }
    );
  }


  Widget getFirestoreRequest (latitude, longitude){
    double? latitude;
    double? longitude;
    return GoogleMapScreen(latitude: latitude, longitude: longitude,);
    //return Container();
  }


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
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
                                                                ///
    // var _kInitialPosition = CameraPosition(target: LatLng(widget.latitude!.toDouble(), widget.longitude!.toDouble()), zoom: 11.0, tilt: 0, bearing: 0);
    ///getLocation();
    //var _kInitialPosition = capPos();
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Demo'),
      ),
      body: Column(
        children: [
          //getLocation(),
          // fireFunk(),
          // searchList(context),
          GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: capPos(),
            //markers: searchList(globalContext),
            onMapCreated: _onMapCreated,
          ),
        ],
      ),
    );
  }
  _onMapCreated (GoogleMapController controller){
    setState(() {
      Marker(infoWindow: InfoWindow(title: 'user'), markerId: MarkerId('<MARKER_ID>'), position: LatLng(widget.latitude!.toDouble(), widget.longitude!.toDouble()));
      mapController = controller;
    });
  }
   capPos() {
    CameraPosition(
        target: LatLng(
             widget.latitude!.toDouble(),
             widget.longitude!.toDouble()),
        zoom: 11.0,
        tilt: 0,
        bearing: 0);
  }
}

// Widget getFirestoreRequest ({latitude, longitude}){
//   final latitude;
//   final longitude;
// return Container();
// }
