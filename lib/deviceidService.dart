import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceIdService {
  static Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await deviceInfo.androidInfo;
      return android.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo ios = await deviceInfo.iosInfo;
      return ios.identifierForVendor ?? "unknown_ios";
    }

    return "unknown_device";
  }
}
