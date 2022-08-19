import 'dart:io';
import 'package:device_info/device_info.dart';

class DeviceInfo {
  String? androidF;

  static final DeviceInfoPlugin deviceInform = DeviceInfoPlugin();

  Future<String> getModelResult() async {
    var valueDeviceInfo = await getDeviceInfo();
    print(valueDeviceInfo);
    return valueDeviceInfo!;
  }

  Future<String?> getDeviceInfo() async {
    if (Platform.isAndroid) {
      //var androidInfo = Text("iphone");
      var androidInfo = await deviceInform.androidInfo;
      String android = androidInfo.model.toString();
      print(androidInfo.model.toString());
      return androidF;
    }
    return '';
  }
}