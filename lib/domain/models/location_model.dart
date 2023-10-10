// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

List<LocationModel> locationModelFromJson(List data) => List<LocationModel>.from(data.map((x) => LocationModel.fromJson(x)));

String locationModelToJson(List<LocationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
  String? uniqueId;
  double? latitude;
  double? longitude;
  int? speed;
  double? distance;
  bool? powerOn;
  bool? valid;
  DateTime? serverTime;
  DateTime? deviceTime;
  int? extBatteryVoltage;
  Attributes? attributes;
  String? address;

  LocationModel({
    this.uniqueId,
    this.latitude,
    this.longitude,
    this.speed,
    this.distance,
    this.powerOn,
    this.valid,
    this.serverTime,
    this.deviceTime,
    this.extBatteryVoltage,
    this.attributes,
    this.address
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    uniqueId: json["UniqueId"],
    latitude: json["Latitude"]?.toDouble(),
    longitude: json["Longitude"]?.toDouble(),
    speed: json["Speed"],
    distance: json["Distance"],
    powerOn: json["PowerOn"],
    valid: json["Valid"],
    serverTime: json["ServerTime"] == null ? null : DateTime.parse(json["ServerTime"]),
    deviceTime: json["DeviceTime"] == null ? null : DateTime.parse(json["DeviceTime"]),
    extBatteryVoltage: json["ExtBatteryVoltage"],
    attributes: json["Attributes"] == null ? null : Attributes.fromJson(json["Attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "UniqueId": uniqueId,
    "Latitude": latitude,
    "Longitude": longitude,
    "Speed": speed,
    "Distance": distance,
    "PowerOn": powerOn,
    "Valid": valid,
    "ServerTime": serverTime?.toIso8601String(),
    "DeviceTime": deviceTime?.toIso8601String(),
    "ExtBatteryVoltage": extBatteryVoltage,
    "Attributes": attributes?.toJson(),
  };
}

class Attributes {
  Attributes();

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
  );

  Map<String, dynamic> toJson() => {
  };
}
