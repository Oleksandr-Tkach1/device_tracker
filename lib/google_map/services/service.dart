import 'package:device_tracker/google_map/screen/googl_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class GoogleService extends StatelessWidget {
//   const GoogleService({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }


class GoogleService {
 GoogleService({longitude, latitude});
  late double longitude;
  late double latitude;


  late QuerySnapshot searchSnapshot;

  // Widget searchList(BuildContext globalContext) {
  //   return ListView.builder(
  //       itemCount: searchSnapshot.docs.length,
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         return getFirestoreRequest(
  //           longitude: searchSnapshot.docs[index]["longitude"],
  //           latitude: searchSnapshot.docs[index]["latitude"],
  //         );
  //       });
  // }
  //
  // Widget getFirestoreRequest ({latitude, longitude}){
  //   GoogleMapScreen(latitude: latitude, longitude: longitude,);
  //   return Container();
  // }
}