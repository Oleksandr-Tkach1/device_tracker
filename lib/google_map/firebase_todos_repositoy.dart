import 'package:device_tracker/google_map/models/location_model.dart';

abstract class LocRep{
  Stream<List<LocationModel>> getLocation();
}