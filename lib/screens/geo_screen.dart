import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../device_info.dart';
import '../model/geo_data.dart';
import './geo_list_view.dart';
import '../shared/user_phone_data.dart';
import '../shared/user_shared_prefs.dart';
import '../shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';

class GeoScreen extends StatefulWidget {
  const GeoScreen({Key? key}) : super(key: key);

  @override
  State<GeoScreen> createState() => _Geo();
}

class _Geo extends State<GeoScreen> {
  Position? _currentPosition;
  var positions = <GeoData>[];
  LocationPermission? _lp;
  bool _isSendChecked = false;
  MqttServerClient? _client;

  _Geo() {
    print('_Geo constructor');
    _getPermission();
    _getMqtt();
  }

  _getMqtt() async {
    _client = MqttServerClient(UserSharedPrefs.getMqttServer() ?? '', 'x');
    if (_client != null) {
      MqttClientConnectionStatus? connStatus = await _client!.connect(
          UserSharedPrefs.getMqttUser(), UserSharedPrefs.getMqttPassword());
      print(connStatus);
    }
  }

  _sendMqttMsg(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    if (builder != null) {
      var myPayload = builder.payload;
      builder.addString(message);
      var publishMessage = _client!
          .publishMessage("phone_location", MqttQos.atLeastOnce, myPayload!);
      print(publishMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Geo')),
      drawer: MenuDrawer(),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DeviceInfo(),
          Row(
            children: [
              const Text('Send to Server?: '),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: _isSendChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isSendChecked = value!;
                  });
                },
              )
            ],
          ),
          ElevatedButton(
            child: Text("Get location"),
            onPressed: () {
              _getCurrentLocation();
            },
          ),
          if (_currentPosition != null)
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text(
                      'Lat:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Card(
                      child: Text(
                        _currentPosition!.latitude.toString(),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Lon:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Card(
                      child: Text(_currentPosition!.longitude.toString()),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Speed',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Card(child: Text(_currentPosition!.speed.toString()))
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Altitude',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Card(child: Text(_currentPosition!.altitude.toString()))
                  ],
                )
              ],
            )
          else
            const Text(
              'No location yet',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          GeoListView(positions)
        ],
      ),
      bottomNavigationBar: const MenuBottom(),
    );
  }

  _getPermission() {
    Geolocator.requestPermission().then((LocationPermission lp) {
      setState(() {
        _lp = lp;
        print('Got permission response');
        print(lp);

        final okPerms = [
          LocationPermission.always,
          LocationPermission.whileInUse
        ];
      });
    });
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        print(position);
        _currentPosition = position;

        print("Position count: ${positions.length}");

        var posMap = position.toJson();
        posMap['device_name'] = UserPhoneData.getName();
        posMap['device_id'] = UserPhoneData.getVendorID();
        posMap['event_ts'] = DateTime.now().toIso8601String();
        print(posMap);

        var gd = GeoData.fromJson(posMap);
        positions.add(gd);

        if (_isSendChecked) {
          var json = jsonEncode(gd);
          print(json);
          _sendMqttMsg(json);
        }
      });
    }).catchError((e) {
      print(e);
    });
  }
}
