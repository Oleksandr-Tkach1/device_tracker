import 'package:device_tracker/google_map/models/location_model.dart';
import 'package:equatable/equatable.dart';

abstract class GoogleMapEvent extends Equatable{
  const GoogleMapEvent();
  List <Object> get props => [];
}

class LoadGoogleMap extends GoogleMapEvent{}

class UpdateGoogleMap extends GoogleMapEvent{
  final List<LocationModel> locationModel;
  UpdateGoogleMap(this.locationModel);

  List <Object> get props => [locationModel];
}