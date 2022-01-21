import 'package:device_tracker/helper/database.dart';
import 'package:uuid/uuid.dart';

firebaseDataTransfer ({required longitude, required latitude}){
  var chatRoomId = Uuid().v1();
  //List<double> location = [longitude, latitude];

  Map<String, dynamic> location = {
    'latitude': latitude,
    'longitude': longitude,
    //'location': location,
    'chatRoomId': chatRoomId,
  };
  DatabaseMethods().createChatRoom(chatRoomId, location);
}