import 'package:equatable/equatable.dart';

abstract class GeolocationProcessEvent extends Equatable {
  const GeolocationProcessEvent();
}
class WeatherEventRequested extends GeolocationProcessEvent {
  final double longitude;
  final double latitude;
  const WeatherEventRequested({required this.longitude, required this.latitude}) : assert(longitude != null, latitude != null);
  @override
  List<Object> get props => [longitude, latitude];
}