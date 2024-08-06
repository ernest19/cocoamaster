// To parse this JSON data, do
//
//     final rehabAssistant = rehabAssistantFromJson(jsonString);

import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/services.dart';

FarmerFromServer farmerFromServerFromJson(String str) =>
    FarmerFromServer.fromJson(json.decode(str));

String farmerFromServerToJson(FarmerFromServer data) =>
    json.encode(data.toJson());

@entity
class FarmerFromServer {
  FarmerFromServer({
    this.id,
    this.farmerFullName,
    this.farmerFirstName,
    this.farmerLastName,
    this.farmerId,
    this.farmerCode,
    this.phoneNumber,
    this.societyName,
    this.nationalIdNumber,
    this.numberOfCocoaFarms,
    this.numberOfCertifiedCrops,
    this.cocoaBagsHarvestedPreviousYear,
    this.cocoaBagsSoldToGroup,
    this.currentYearYieldEstimate,

    //

    this.farmerPhoto,
    this.idType,
    this.idExpiryDate,
  });

  @PrimaryKey(autoGenerate: true)
  final int? id;

  String? farmerFullName;

  String? farmerFirstName;
  String? farmerLastName;
  int? farmerId;
  String? farmerCode;
  String? phoneNumber;

  String? societyName;
  String? nationalIdNumber;
  int? numberOfCocoaFarms;
  int? numberOfCertifiedCrops;
  int? cocoaBagsHarvestedPreviousYear;
  int? cocoaBagsSoldToGroup;
  int? currentYearYieldEstimate;

  Uint8List? farmerPhoto;
  String? idType;
  String? idExpiryDate;

  // String? idType;
  // String? idNumber;
  // String? districtName;

  factory FarmerFromServer.fromJson(Map<String, dynamic> json) =>
      FarmerFromServer(
        farmerFullName: json["farmer_name"],
        farmerFirstName: json["first_name"],
        farmerLastName: json["last_name"],
        farmerId: json["farmerid"],
        farmerCode: json["farmer_code"],
        phoneNumber: json["contact"],
        societyName: json["society_name"],
        nationalIdNumber: json["national_id_no"],
        numberOfCocoaFarms: json["no_of_cocoa_farms"],
        numberOfCertifiedCrops: json["no_of_certified_crop"],
        cocoaBagsHarvestedPreviousYear:
            json["total_cocoa_bags_harvested_previous_year"],
        cocoaBagsSoldToGroup: json["total_cocoa_bags_sold_group_previous_year"],
        currentYearYieldEstimate: json["current_year_yeild_estimate"],
        farmerPhoto: Uint8List.fromList(utf8.encode(json["farmer_photo"])),
        idType: json["id_type"],
        idExpiryDate: json["id_expiry_date"],
      );

  Map<String, dynamic> toJson() => {
        "farmer_name": farmerFullName,
        "first_name": farmerFirstName,
        "last_name": farmerLastName,
        "farmerid": farmerId,
        "farmer_code": farmerCode,
        "contact": phoneNumber,
        "society_name": societyName,
        "national_id_no": nationalIdNumber,
        "no_of_cocoa_farms": numberOfCocoaFarms,
        "no_of_certified_crop": numberOfCertifiedCrops,
        "total_cocoa_bags_harvested_previous_year":
            cocoaBagsHarvestedPreviousYear,
        "total_cocoa_bags_sold_group_previous_year": cocoaBagsSoldToGroup,
        "current_year_yeild_estimate": currentYearYieldEstimate,
        "farmer_photo": base64Encode(farmerPhoto ?? []),
        "id_type": idType,
        "id_expiry_date": idExpiryDate,
      };

  // jsonDecode(const Utf8Decoder().convert(farmboundary ?? []))
}

FarmerFromServerUpdate farmerFromServerUpdateFromJson(String str) =>
    FarmerFromServerUpdate.fromJson(json.decode(str));

String farmerFromServerUpdateToJson(FarmerFromServerUpdate data) =>
    json.encode(data.toJson());

@entity
class FarmerFromServerUpdate {
  FarmerFromServerUpdate({
    this.pk,
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
  String? pk;
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

  factory FarmerFromServerUpdate.fromJson(Map<String, dynamic> json) =>
      FarmerFromServerUpdate(
        pk: json["pk"],
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
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
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
      };
}
