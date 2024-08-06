// To parse this JSON data, do
//
//     final outbreakFarm = outbreakFarmFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

import 'package:floor/floor.dart';

Farm farmFromJson(String str) => Farm.fromJson(json.decode(str));

String farmToJson(Farm data) => json.encode(data.toJson());

@entity
class Farm {
  Farm({
    this.uid,
    this.agent,
    this.farmboundary,
    this.farmer,
    this.farmArea,
    this.registrationDate,
    this.status,
    this.societyCode,
  });

  @primaryKey
  String? uid;
  String? agent;
  Uint8List? farmboundary;
  int? farmer;
  double? farmArea;
  String? registrationDate;
  int? status;
  int? societyCode;

  factory Farm.fromJson(Map<String, dynamic> json) => Farm(
        uid: json["uid"],
        agent: json["agent"],
        farmboundary: Uint8List.fromList(utf8.encode(json["farm_boundary"])),
        farmer: json["farmer"],
        farmArea: json["farm_area"],
        registrationDate: json["registration_date"],
        status: json["status"],
        societyCode: json["society_code"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "agent": agent,
        "farm_boundary":
            jsonDecode(const Utf8Decoder().convert(farmboundary ?? [])),
        "farmer": farmer,
        "farm_area": farmArea,
        "registration_date": registrationDate,
        "status": status,
        "society_code": societyCode,
      };
}
