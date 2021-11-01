import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:workmanager/workmanager.dart';

class LocationInfo {
  late double? longitude;
  late double? latitude;

  Future<void> getUserLocationData() async {
      BackgroundLocation.getLocationUpdates((location) {
        longitude = location.longitude;
        latitude = location.latitude;
      });
    //await BackgroundLocation.startLocationService(distanceFilter: 5);
  }

  static const fetchBackground = "fetchBackground";

  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case fetchBackground:
          BackgroundLocation.startLocationService(forceAndroidLocationManager: true);
          ///
          BackgroundLocation.getLocationUpdates((location) {
            longitude = location.longitude;
            latitude = location.latitude;
          });
          print(longitude);
          print(latitude);
          break;
      }
      return Future.value(true);
    });
  }
}