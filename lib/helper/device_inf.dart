import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:device_tracker/login_system/register/screen/register_form.dart';

class DeviceInfo {
  String? android;
  var ios;
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  getModel() async {
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      android = androidInfo.model.toString();
      print('Running onFFFFF ${androidInfo.model.toString()}');
      //print('Running on ${androidInfo.model}');
      return RegisterForm(deviceName: android,);
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      ios = iosInfo.utsname.machine;
      print('Running on ${iosInfo.utsname.machine}');
    }
  }
}