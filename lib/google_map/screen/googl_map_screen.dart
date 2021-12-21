import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_tracker/google_map/services/service.dart';
import 'package:device_tracker/helper/database.dart';
import 'package:flutter/material.dart';
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

  //late Stream stream;
  CollectionReference stream = FirebaseFirestore.instance.collection('Location');


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

  // Future getLoc() async{
  //    FirebaseFirestore.instance.collection('ChatRoom').get().then((querySnapshot) => querySnapshot.docs.forEach((result) {
  //      widget.latitude = result.data()['latitude'] as double?;
  //      widget.longitude = result.data()['longitude'] as double?;
  //      print('RESULT: ${result.data()}');
  //      print('RESULT PEREM: ${widget.latitude}');
  //      print('RESULT PEREM: ${widget.longitude}');
  //    }));
  //  }


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

  df() {
    return StreamBuilder<QuerySnapshot>(
        stream: stream.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("There is no expense");
               print('RESULT PEREM1: ${widget.latitude}');
               print('RESULT PEREM2: ${widget.longitude}');
          return getExpenseItems(snapshot);
        });
  }


getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
  print('RESULT PEREM3: ${widget.latitude}');
  print('RESULT PEREM4: ${widget.longitude}');
  return snapshot.data!.docs
      .map((doc) =>
      GoogleMapScreen( latitude:
        doc["latitude"],
        longitude:
        doc["longitude"],));
      //CameraPosition(target: LatLng(doc["latitude"].toDoble, doc["longitude"].toDoble,)));
  //     getFirestoreRequest(
  //     doc["latitude"],
  //     doc["longitude"],
  // ));
}



  Widget getFirestoreRequest(latitude, longitude) {
    double? latitude;
    double? longitude;
    return GoogleMapScreen(latitude: latitude, longitude: longitude,);
    //return Container();
  }


  @override
  void initState() {
    df();
    //getLoc();
    //getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///
    var _kInitialPosition =
    // CameraPosition(target: LatLng(24.150, -110.32), zoom: 11.0, tilt: 0, bearing: 0);
    CameraPosition(target: LatLng(widget.latitude!.toDouble(), widget.longitude!.toDouble()));

    ///getLocation();
    //var _kInitialPosition = capPos();
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Demo'),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: _kInitialPosition,
        //CameraPosition(target: LatLng(-122, 83),zoom: 11.0,tilt: 0,bearing: 0),
        //markers: searchList(globalContext),
        onMapCreated: _onMapCreated,
      ),
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

  capPos() {
    CameraPosition(
        target: LatLng(-122, 83), zoom: 11.0, tilt: 0, bearing: 0);
  }
}