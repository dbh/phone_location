import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../shared/device_info.dart';
import '../model/geo_data.dart';
import '../components/geo_list_view.dart';
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
  String? mqttEventMsg;

  _Geo() {
    print('_Geo constructor');
    _getPermission();
    // _getMqtt();
  }

  _onMqttEvent(String eventType) {
    print('_onMqttEvent ${eventType}');
    if (mounted)
      setState(() {
        mqttEventMsg = eventType;
      });
  }

  _getMqtt() async {
    _client = MqttServerClient(UserSharedPrefs.getMqttServer() ?? '', 'x');

    if (_client != null) {
      _client!.onConnected = _onMqttEvent('onConnected');
      _client!.onAutoReconnected = _onMqttEvent('onAutoReconnected');
      _client!.onDisconnected = _onMqttEvent('onDisconnected');
      _client!.onAutoReconnect = _onMqttEvent('onAutoReconnect');

      _client!.doAutoReconnect(force: true);

      MqttClientConnectionStatus? connStatus = await _client!.connect(
          UserSharedPrefs.getMqttUser(), UserSharedPrefs.getMqttPassword());

      print(connStatus);
    }
  }

  _sendMqttMsg(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();

    var myPayload = builder.payload;
    builder.addString(message);
    var publishMessage = _client!
        .publishMessage("phone_location", MqttQos.atLeastOnce, myPayload!);
    print(publishMessage);
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
      appBar: AppBar(title: const Text('Geo')),
      drawer: const MenuDrawer(),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DeviceInfo(),
          Row(
            children: [
              const Text('Send to Server?: '),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: _isSendChecked,
                onChanged: (bool? value) {
                  print('Checkbox changed');
                  setState(() {
                    _isSendChecked = value!;
                    if (_isSendChecked == false && _client != null) {
                      _client!.disconnect();
                      _client = null;
                    }
                  });
                },
              ),
            ],
          ),
          ElevatedButton(
            child: const Text("Get location"),
            onPressed: () {
              if (_isSendChecked && _client == null) {
                _getMqtt();
              }
              _getCurrentLocation();
            },
          ),
          Text(
            mqttEventMsg ?? '',
            style: TextStyle(color: Colors.red),
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
        print(_lp);

        // final okPerms = [
        //   LocationPermission.always,
        //   LocationPermission.whileInUse
        // ];
      });
    });
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        mqttEventMsg = null;
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
      setState(() {
        mqttEventMsg = e.toString();
      });
    });
  }
}
