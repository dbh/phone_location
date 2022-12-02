class GeoData {
  final String device_id;
  final String device_name;

  final double latitude;
  final double longitude;

  final double altitude;
  final double speed;

  final int timestamp;
  final String event_ts;

  GeoData(this.device_id, this.device_name, this.latitude, this.longitude,
      this.altitude, this.speed, this.timestamp, this.event_ts);

  GeoData.fromJson(Map<String, dynamic> json)
      : device_id = json['device_id'],
        device_name = json['device_name'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        altitude = json['altitude'],
        speed = json['speed'],
        timestamp = json['timestamp'],
        event_ts = json['event_ts'];

  Map<String, dynamic> toJson() => {
        'device_id': device_id,
        'device_name': device_name,
        'latitude': latitude,
        'longitude': longitude,
        'altitude': altitude,
        'speed': speed,
        'timestamp': timestamp,
        'event_ts': event_ts
      };
}
