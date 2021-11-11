import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:device_tracker/services/firebase_data_transfer.dart';
import 'package:workmanager/workmanager.dart';

const simplePeriodicTask = "simplePeriodicTask";

Future<void> callbackDispatcher() async {
  late double? longitude;
  late double? latitude;

  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case simplePeriodicTask:
          BackgroundLocation.getLocationUpdates((location) {
            longitude = location.longitude;
            latitude = location.latitude;
            print(longitude);
            print(latitude);
            // return firebaseDataTransfer(latitude: latitude, longitude: longitude);
          });
          ///
          break;
    }
    return Future.value(true);
  });
  return await firebaseDataTransfer(latitude: latitude, longitude: longitude);
}