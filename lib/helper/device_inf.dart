import 'dart:io';
import 'package:device_info/device_info.dart';

class DeviceInfo {
  String? android;
  static final DeviceInfoPlugin deviceInform = DeviceInfoPlugin();

  Future<String?> getModel() async {
    if (Platform.isAndroid) {
      var androidInfo = await deviceInform.androidInfo;
      android = androidInfo.model.toString();
      print('Running onFFFFF ${androidInfo.model.toString()}');
      return android;
    }
    // else if (Platform.isIOS) {
    //   var iosInfo = await deviceInfo.iosInfo;
    //   ios = iosInfo.utsname.machine;
    //   print('Running on ${iosInfo.utsname.machine}');
    // }
  }
}