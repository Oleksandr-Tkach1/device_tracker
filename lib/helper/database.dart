import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
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
}