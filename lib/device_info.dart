import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeviceInfo extends StatefulWidget {
  // const DeviceInfo({Key key}) : super(key: key);

  @override
  State<DeviceInfo> createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  Map<String, Object> _info = Map<String, Object>();

  _DeviceInfoState() {
    _getInfo();
  }

  Future<String> _getInfo() async {
    final devInfoPlugin = DeviceInfoPlugin();
    final devInfo = await devInfoPlugin.deviceInfo;
    print(devInfo);
    setState(() {
      _info = devInfo.toMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_info.isNotEmpty)
          Column(
            children: [
              Text("name: ${_info['name']}"),
              Text("model: ${_info['model']}"),
              Text("systemName: ${_info['systemName']}"),
              Text("identifierForVendor: ${_info['identifierForVendor']}"),
            ],
          )
      ],
    );
  }
}
