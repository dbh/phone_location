// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:phone_location/model/geo_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeoListView extends StatelessWidget {
  List<GeoData> positions = [];

  GeoListView(List<GeoData> pos, {Key? key}) : super(key: key) {
    positions = List.from(pos.reversed);
  }

  @override
  Widget build(BuildContext context) {
    print("GeoListView ${positions.length}");
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.purple,
                  width: 2,
                )),
                padding: const EdgeInsets.all(10),
                child: Text(
                  DateFormat('Hms').format(DateTime.fromMillisecondsSinceEpoch(
                      positions[index].timestamp)),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
              Column(
                children: [
                  Text(positions[index].latitude.toString()),
                  Text(positions[index].longitude.toString())
                ],
              )
            ],
          );
        }),
        itemCount: positions.length,
      ),
    );
  }
}
