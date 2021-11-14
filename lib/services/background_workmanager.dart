import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:device_tracker/services/firebase_data_transfer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

const simplePeriodicTask = "simplePeriodicTask";

Future<void> callbackDispatcher() async {
  late double? longitude;
  late double? latitude;

  Workmanager().executeTask((task, inputData) async{
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
    switch (task) {
      case simplePeriodicTask:
         await BackgroundLocation.getLocationUpdates((location) async {
            longitude = location.longitude;
            latitude = location.latitude;
            print(longitude);
            print(latitude);
            return await firebaseDataTransfer(latitude: latitude, longitude: longitude);
          });
          ///
          break;
    }
    return Future.value(true);
  });
  //return await firebaseDataTransfer(latitude: latitude, longitude: longitude);
}