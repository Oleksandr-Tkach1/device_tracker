import 'package:equatable/equatable.dart';

abstract class GeolocationProcessState extends Equatable {
  const GeolocationProcessState();
  @override
  List<Object> get props => [];
}
class WeatherStateInitial extends GeolocationProcessState {}
class WeatherStateLoading extends GeolocationProcessState {}
class WeatherStateSuccess extends GeolocationProcessState {
  // final Main weatherGeolocation;
  // const WeatherStateSuccess({@required this.weatherGeolocation}) : assert(weatherGeolocation != null);
  //@override
  //List<Object> get props => [weatherGeolocation];
}
class WeatherStateFailure extends GeolocationProcessState {}