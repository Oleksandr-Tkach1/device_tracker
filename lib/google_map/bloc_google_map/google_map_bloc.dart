import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:device_tracker/google_map/bloc_google_map/google_map_event.dart';
import 'package:device_tracker/google_map/bloc_google_map/google_map_state.dart';
import '../todos_repository.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState>{
  final LocationRepository _locationRepository;
  StreamSubscription? _locationSubscription;

  GoogleMapBloc({required LocationRepository locationRepository}) : _locationRepository = locationRepository, super(GoogleMapLoading());

  Stream<GoogleMapState> mapEventToState(GoogleMapEvent event) async*{
    if (event is LoadGoogleMap){
      yield* _mapLoadGoogleMapToState();
    }
    if (event is UpdateGoogleMap){
      yield* _mapUpdateGoogleMapToState(event);
    }
  }

  Stream<GoogleMapState> _mapLoadGoogleMapToState() async*{
    _locationSubscription?.cancel();
      _locationSubscription = _locationRepository.getLocation().listen(
          (location) =>
              add(UpdateGoogleMap(location),
              ),
    );
  }

  Stream<GoogleMapState> _mapUpdateGoogleMapToState(UpdateGoogleMap event) async* {
    yield GoogleMapLoaded(locationModel: event.locationModel);
  }
}