// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Geo extends StatefulWidget {
  // const Geo({Key key}) : super(key: key);

  @override
  State<Geo> createState() => _Geo();
}

class _Geo extends State<Geo> {
  Position _currentPosition;
  LocationPermission _lp;

  _Geo() {
    print('_Geo constructor');
    _getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
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
                      _currentPosition.latitude.toString(),
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
                    child: Text(_currentPosition.longitude.toString()),
                  )
                ],
              ),
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
      });
    }).catchError((e) {
      print(e);
    });
  }
}
