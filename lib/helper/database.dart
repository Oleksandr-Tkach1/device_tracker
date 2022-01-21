import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByData() async {
    return await FirebaseFirestore.instance
        .collection('Location')
        .get();
  }

  getUserByUserEmail(String userEmail) async {
  return await FirebaseFirestore.instance
      .collection('users')
      .where("email", isEqualTo: userEmail)
      .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, location) {
    FirebaseFirestore.instance
        .collection('Location')
        .doc(chatRoomId)
        .set(location)
        .catchError((e) {
      print(e.toString());
    });
  }
}