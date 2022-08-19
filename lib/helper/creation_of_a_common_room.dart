import 'package:device_tracker/helper/database.dart';
import 'package:device_tracker/helper/device_inf.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

creationOfACommonRoom ({required String deviceName, BuildContext? context}) {

  DeviceInfo deviceInfo = DeviceInfo();
  if (deviceName != deviceInfo.androidF) {
    //String chatRoomId = getChatRoomId(userName, Constants.myName);
    var chatRoomId = Uuid().v1();

    //String user = jsonEncode(User(userName, userEmail));
    //String me = jsonEncode(User(Constants.myName, Constants.myEmail));

    //List<User> chatUsers =(json.decode('[{"userName":"Sasha","email":"k@gmail.com"},{"userName":"4ELOVEK","email":"sasha228023@gmail.com"}]') as List).map((i) => User.fromJson(i)).toList();

    //User me;
    //chatUsers.forEach((chatUser) {
    //  if(chatUser.email != Constants.myEmail) {
    //    me = chatUser;
    //  }
    // if(me != null) {
    //   print('Ура я нашел своего юзера' + me.userName);
    // } else {
    //   print('Oy noy ((');
    // }

    //});
    List<String> users = [deviceName, deviceInfo.androidF.toString()];

    Map<String, dynamic> chatRoomMap = {
      'chatName': deviceName +', '+ deviceInfo.androidF.toString(),
      'users': users,
      'chatRoomId': chatRoomId,
    };
    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    // Navigator.push(context!, MaterialPageRoute(
    //   // builder: (context) => ConversationScreen(
    //   //   chatRoomId,
    //   //   deviceName,
    //   //   ),
    //   ),
    // );
  } else {
    print('you cannot send message to yourself');
  }
}