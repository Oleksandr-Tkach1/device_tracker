import 'package:device_tracker/google_map/models/location_model.dart';
import 'package:equatable/equatable.dart';

abstract class GoogleMapState extends Equatable{
  const GoogleMapState();

  @override
  List <Object> get props => [];
}

class GoogleMapLoading extends GoogleMapState{}

class GoogleMapLoaded extends GoogleMapState{
  final List<LocationModel> locationModel;
  GoogleMapLoaded({this.locationModel = const <LocationModel>[]});

  List <Object> get props => [locationModel];
}