// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/global_controller.dart';

const String googlePlacesApiKey = 'AIzaSyB-I85PyI0Hn_73pLQnZnF2I-lY2erlXoQ';
// final String googlePlacesApiKey = 'AIzaSyBTFoUzCdhGIfUZTHy52TjwwMeKIQ77Sjs';

const String debugModePasscode = '0248823823';

class URLs {
  static String baseUrl = Get.find<GlobalController>().serverUrl;
  static String lookupUserAccount = '/api/v1/auth/login/';
  static String lookupUserAccount_v2 = '/api/v2/auth/login/';
  static String loadSocieties = '/api/v1/fetchsociety/';
  static String saveFarmer = '/api/v1/savefarmerdetails/';
  static String saveFarm = '/api/v1/savefarm/';
  static String loadAssignedFarms = '/api/v1/fetchassignedfarms/';
  static String loadFarmers = '/api/v1/fetchfarmerlist/';
  static String createAccount = '';
  static String changePassword = '/api/v1/auth/changepasword/';
  static String getUserInfo = '';
  static String updateProfilePhoto = '';
  static String updateAccountDetails = '';
  static String sendIssue = '';
  // static String updateAccountDetails = '';
  static String updateFarmerFromServer = '/api/v1/updatefarmerdetails/';
}

class YesNo {
  static String yes = "Yes";
  static String no = "No";
}

class PersonnelImageData {
  static String personnelImage = "PersonnelImage";
  static String idImage = "IDImage";
  static String sSNITCardImage = "SSNITCardImage";
}

class SubmissionStatus {
  static int pending = 0;
  static int submitted = 1;
}

class RequestStatus {
  static int False = 0;
  static int True = 1;
  static int Exist = 2;
  static int NoInternet = 3;
}

class MaxLocationAccuracy {
  // static double max = 15.0;
  // static double max = 25.0; // for testing
  static double max = 3.0;
}

class Build {
  static int buildNumber = 10;
}

class ShareP {
  static SharedPreferences? preferences;
}

class FileType {
  static String image = "Image";
  static String video = "Video";
  static String audio = "Audio";
}
