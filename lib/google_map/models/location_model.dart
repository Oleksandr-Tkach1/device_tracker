import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_tracker/google_map/entities/todo_entity.dart';
import 'package:meta/meta.dart';

@immutable
class LocationModel {
  //final String chatRoomId;
  final double latitude;
  final double longitude;

  const LocationModel({
    //required this.chatRoomId,
    required this.latitude,
    required this.longitude,});

  List <Object?> get props => [
    //chatRoomId,
    latitude,
    longitude];
  // @override
  // int get hashCode => complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'Todo { '
        //'task: $chatRoomId,'
        ' lat: $latitude,'
        ' lon: $longitude }';
  }

  // TodoEntity toEntity() {
  //   return TodoEntity(complete, chatRoomId, latitude, longitude);
  // }

//   static LocationModel fromEntity(TodoEntity entity) {
//     return LocationModel(
//       //entity.task,
//       complete: entity.complete ?? false,
//       note: entity.note,
//       id: entity.id,
//     );
//   }
  static LocationModel fromSnapshot(DocumentSnapshot snap) {
    LocationModel locationModel = LocationModel(
      //chatRoomId: snap['chatRoomId'],
      latitude: snap['latitude'],
      longitude: snap['longitude'],
    );
    return locationModel;
  }
}