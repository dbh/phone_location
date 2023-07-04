import 'package:flutter/material.dart';
import 'package:phone_location/shared/user_phone_data.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone Info',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("name: ${UserPhoneData.getName()}"),
        Text("model: ${UserPhoneData.getModel()}"),
        Text("systemName: ${UserPhoneData.getSystemName()}"),
        Text("id: ${UserPhoneData.getVendorID()}",
            style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
