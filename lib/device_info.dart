import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phone_location/shared/user_phone_data.dart';

class DeviceInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("name: ${UserPhoneData.getName()}"),
        Text("model: ${UserPhoneData.getModel()}"),
        Text("systemName: ${UserPhoneData.getSystemName()}"),
        Text("id: ${UserPhoneData.getVendorID()}",
            style: TextStyle(fontSize: 10)),
      ],
    );
  }
}
