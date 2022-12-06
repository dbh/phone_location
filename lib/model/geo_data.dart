class GeoData {
  final String deviceId;
  final String deviceName;

  final double latitude;
  final double longitude;

  final double altitude;
  final double speed;

  final int timestamp;
  final String eventTs;

  GeoData(this.deviceId, this.deviceName, this.latitude, this.longitude,
      this.altitude, this.speed, this.timestamp, this.eventTs);

  GeoData.fromJson(Map<String, dynamic> json)
      : deviceId = json['device_id'],
        deviceName = json['device_name'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        altitude = json['altitude'],
        speed = json['speed'],
        timestamp = json['timestamp'],
        eventTs = json['event_ts'];

  Map<String, dynamic> toJson() => {
        'device_id': deviceId,
        'device_name': deviceName,
        'latitude': latitude,
        'longitude': longitude,
        'altitude': altitude,
        'speed': speed,
        'timestamp': timestamp,
        'event_ts': eventTs
      };
}
