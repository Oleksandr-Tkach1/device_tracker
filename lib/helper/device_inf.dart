import 'dart:io';
import 'package:device_info/device_info.dart';

class DeviceInfo {
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  getModel() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');
      //return HomeScreen(deviceName: androidInfo.model, name: '',);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');
      return iosInfo.utsname.machine;
    }
  }
}