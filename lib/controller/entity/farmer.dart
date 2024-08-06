// To parse this JSON data, do
//
//     final personnel = personnelFromJson(jsonString);

import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/services.dart';

Farmer farmerFromJson(String str) => Farmer.fromJson(json.decode(str));

String farmerToJson(Farmer data) => json.encode(data.toJson());

@entity
class Farmer {
  Farmer({
    this.uid,
    this.agent,
    this.submissionDate,
    this.currentFarmerPic,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.idType,
    this.idNumber,
    this.idExpiryDate,
    this.society,
    this.cocoaFarmNumberCount,
    this.certifiedCropsNumber,
    this.totalPreviousYearsBagsSoldToGroup,
    this.totalPreviousYearHarvestedCocoa,
    this.currentYearBagYieldEstimate,
    this.status,
  });

  @primaryKey
  String? uid;
  String? agent;
  String? submissionDate;
  Uint8List? currentFarmerPic;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? idType;
  String? idNumber;
  String? idExpiryDate;
  int? society;
  String? cocoaFarmNumberCount;
  String? certifiedCropsNumber;
  String? totalPreviousYearsBagsSoldToGroup;
  String? totalPreviousYearHarvestedCocoa;
  String? currentYearBagYieldEstimate;
  int? status;

  factory Farmer.fromJson(Map<String, dynamic> json) => Farmer(
        uid: json["uid"],
        agent: json["agent"],
        submissionDate: json["submission_date"],
        currentFarmerPic: json["photo_farmer"],
        firstName: json["fname"],
        lastName: json["lname"],
        phoneNumber: json["phone_number"],
        idType: json["idType"],
        idNumber: json["idNumber"],
        idExpiryDate: json["idExpiryDate"],
        society: json["society"],
        cocoaFarmNumberCount: json["cocoaFarmNumberCount"],
        certifiedCropsNumber: json["certifiedCropsNumber"],
        totalPreviousYearsBagsSoldToGroup:
            json["totalPreviousYearsBagsSoldToGroup"],
        totalPreviousYearHarvestedCocoa:
            json["totalPreviousYearHarvestedCocoa"],
        currentYearBagYieldEstimate: json["currentYearBagYieldEstimate"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "agent": agent,
        "submission_date": submissionDate,
        "photo_farmer": base64Encode(currentFarmerPic ?? []),
        "fname": firstName,
        "lname": lastName,
        "phone_number": phoneNumber,
        "idType": idType,
        "idNumber": idNumber,
        "idExpiryDate": idExpiryDate,
        "society": society,
        "cocoaFarmNumberCount": cocoaFarmNumberCount,
        "certifiedCropsNumber": certifiedCropsNumber,
        "totalPreviousYearsBagsSoldToGroup": totalPreviousYearsBagsSoldToGroup,
        "totalPreviousYearHarvestedCocoa": totalPreviousYearHarvestedCocoa,
        "currentYearBagYieldEstimate": currentYearBagYieldEstimate,
        "status": status,
      };
}
