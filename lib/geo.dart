// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:phone_location/shared/user_shared_prefs.dart';

class Geo extends StatefulWidget {
  const Geo({Key? key}) : super(key: key);

  @override
  State<Geo> createState() => _Geo();
}

class _Geo extends State<Geo> {
  Position? _currentPosition;
  LocationPermission? _lp;
  bool _isSendChecked = false;
  MqttServerClient? _client;

  _Geo() {
    print('_Geo constructor');
    _getPermission();
    _getMqtt();
  }

  _getMqtt() async {
    var server = UserSharedPrefs.getMqttServer();
    print(server);

    var user = UserSharedPrefs.getMqttUser();
    print(user);

    var pw = UserSharedPrefs.getMqttPassword();
    print('pw ${pw}');

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Text('Send to Server?: '),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
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
                  Text(
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
                  Text(
                    'Speed',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Card(child: Text(_currentPosition!.speed.toString()))
                ],
              ),
              Row(
                children: [
                  Text(
                    'Altitude',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Card(child: Text(_currentPosition!.altitude.toString()))
                ],
              )
            ],
          )
        else
          Text(
            'No location yet',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          )
      ],
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
        if (_isSendChecked) {
          var posMap = position.toJson();
          posMap['device_name'] = 'NULL';
          _sendMqttMsg(posMap.toString());
        }
      });
    }).catchError((e) {
      print(e);
    });
  }
}
