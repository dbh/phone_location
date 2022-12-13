import 'package:device_info_plus/device_info_plus.dart';

class UserPhoneData {
  static late BaseDeviceInfo _baseDeviceInfo;
  static late String _name;
  static late String _model;
  static late String _systemName;
  static late String _vendorID;

  static Future init() async {
    final devInfoPlugin = DeviceInfoPlugin();
    _baseDeviceInfo = await devInfoPlugin.deviceInfo;

    _name = _baseDeviceInfo.data['name'] ?? '';
    _model = _baseDeviceInfo.data['model'] ?? '';
    _systemName = _baseDeviceInfo.data['systemName'] ?? '';
    _vendorID = _baseDeviceInfo.data['identifierForVendor'] ?? '';
  }

  static String getName() {
    return _name;
  }

  static String getModel() {
    return _model;
  }

  static String getSystemName() {
    return _systemName;
  }

  static String getVendorID() {
    return _vendorID;
  }
}
