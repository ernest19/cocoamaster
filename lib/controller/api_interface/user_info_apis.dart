// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/auth/login/login.dart';
import '../../view/utils/connection_verify.dart';
import '../../view/utils/constants.dart';
import '../../view/utils/view_constants.dart';
import '../global_controller.dart';
import '../model/cm_user.dart';
import '../model/user_info.dart';
import 'parse_image.dart';

class UserInfoApiInterface {
  ///Check if phone number is registered
  accountLookup(phone) async {
    Dio? dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    if (await ConnectionVerify.connectionIsAvailable()) {
      try {
        var response = await dio.post(URLs.baseUrl + URLs.lookupUserAccount,
            data: {'telephone': phone});
        print('THE LOGIN RESPONSE::: $response');
        print('THE LOGIN RESPONSE STATUS::: ${response.data['status']}');

        if (response.data['status'] == RequestStatus.True) {
          var data = response.data['data'];
          print('THE LOGIN RESPONSE DATA::: $data');

          CmUser userInfo = CmUser(
              userId: data['user_id'],
              firstName: data['first_name'],
              lastName: data["last_name"],
              district: data['district'],
              group: data["group"]);

          GlobalController indexController = Get.find();
          await saveUserDataToSharedPrefs(userInfo);
          indexController.userInfo.value =
              await retrieveUserInfoFromSharedPrefs();

          return {
            'status': true,
            'connectionAvailable': true,
            'userInfo': userInfo
          };
        } else {
          print('THE LOGIN RESPONSE NOT TRUE::: $response');

          return {
            'status': false,
            'message': response.data['msg'],
            'connectionAvailable': true
          };
        }
        // if (response.data['status'] == true){
        //   String token = response.data['token'];
        //   return {
        //     'status': true,
        //     'connectionAvailable': true,
        //     'token': token
        //   };
        // }else{
        //   return {
        //     'status': false,
        //     'connectionAvailable': true
        //   };
        // }
      } catch (e) {
        print(e);
      }
    } else {
      print('CONECTION IS NOT AVAILABLE');
      return {'status': false, 'connectionAvailable': false};
    }
  }
// ===================================================================================
// End Check if phone number is registered
// ===================================================================================

// check if user is registered
  accountLookupUsername(username, password) async {
    Dio? dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    if (await ConnectionVerify.connectionIsAvailable()) {
      try {
        var response = await dio.post(URLs.baseUrl + URLs.lookupUserAccount_v2,
            data: {'telephone': username, "password": password});
        print('THE LOGIN RESPONSE::: $response');
        print('THE LOGIN RESPONSE STATUS::: ${response.data['status']}');

        if (response.data['status'] == RequestStatus.True) {
          var data = response.data['data'];
          print('THE LOGIN RESPONSE DATA::: $data');

          CmUser userInfo = CmUser(
              userId: data['user_id'],
              firstName: data['first_name'],
              lastName: data["last_name"],
              district: data['district'],
              group: data["group"]);

          GlobalController indexController = Get.find();
          await saveUserDataToSharedPrefs(userInfo);
          indexController.userInfo.value =
              await retrieveUserInfoFromSharedPrefs();

          return {
            'status': true,
            'connectionAvailable': true,
            'userInfo': userInfo
          };
        } else {
          print('THE LOGIN RESPONSE NOT TRUE::: $response');

          return {
            'status': false,
            'message': response.data['msg'],
            'connectionAvailable': true
          };
        }
        // if (response.data['status'] == true){
        //   String token = response.data['token'];
        //   return {
        //     'status': true,
        //     'connectionAvailable': true,
        //     'token': token
        //   };
        // }else{
        //   return {
        //     'status': false,
        //     'connectionAvailable': true
        //   };
        // }
      } catch (e) {
        print(e);
      }
    } else {
      print('CONECTION IS NOT AVAILABLE');
      return {'status': false, 'connectionAvailable': false};
    }
  }
// ===================================================================================
// End Check if user is registered
// ===================================================================================

  ///Create a new user account
  createAccount(userData) async {
    Dio? dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    if (await ConnectionVerify.connectionIsAvailable()) {
      try {
        var response =
            await dio.post(URLs.baseUrl + URLs.createAccount, data: userData);
        var data = response.data;
        return {
          'status': data['status'],
          'connectionAvailable': true,
          'message': data['msg'],
          'token': data['token']
        };
      } catch (e) {
        print(e);
      }
    } else {
      return {'status': false, 'connectionAvailable': false};
    }
  }
// ===================================================================================
// End create new user account
// ===================================================================================

  /// Change account password
  changePassword(userData) async {
    Dio? dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    if (await ConnectionVerify.connectionIsAvailable()) {
      try {
        var response =
            await dio.post(URLs.baseUrl + URLs.changePassword, data: userData);
        var data = response.data;
        return {
          'status': data['status'],
          'connectionAvailable': true,
          'message': data['msg'],
          'token': data['token']
        };
      } catch (e, stackTrace) {
        print("Caught $e");
        debugPrint("Stacktrace $stackTrace");
        // FirebaseCrashlytics.instance.recordError(e, stackTrace);
        // FirebaseCrashlytics.instance.log('resetPassword');
      }
    } else {
      return {'status': false, 'connectionAvailable': false};
    }
  }
// ===================================================================================
// End change account password
// ===================================================================================

  ///Retrieve user account information from server
  getUserInfo(token) async {
    Dio? dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    if (await ConnectionVerify.connectionIsAvailable()) {
      try {
        var response = await dio
            .post(URLs.baseUrl + URLs.getUserInfo, data: {'token': token});
        if (response.data['status'] == true) {
          var data = response.data['data'];

          UserInfo userInfo = UserInfo(
            id: data['id'],
            token: token,
            name: data["name"],
            phone: data["phone"],
            image: parseImage(data["image"]),
            email: data["email"],
            country: data["country"],
            sex: data["sex"],
            loginId: data["Login.id"],
            loginUname: data["Login.uname"],
            loginRole: data["Login.role"],
            loginLastLogin: data["Login.last_login"],
            loginStatus: data["Login.status"],
            loginNotificationToken: data["Login.notification_token"],
          );

          GlobalController indexController = Get.find();
          await saveUserDataToSharedPrefs(userInfo);
          indexController.userInfo.value =
              await retrieveUserInfoFromSharedPrefs();

          return {
            'status': true,
            'connectionAvailable': true,
            'userInfo': userInfo
          };
        } else {
          return {
            'status': false,
            'message': response.data['msg'],
            'connectionAvailable': true
          };
        }
      } catch (e) {
        print(e);
      }
    } else {
      return {'status': false, 'connectionAvailable': false};
    }
  }
// ===================================================================================
// End retrieve user account information
// ===================================================================================

  // ===================================================================================
// START UPDATE PROFILE PHOTO
// ===================================================================================
  updateProfilePhoto(data, token) async {
    Dio? dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    GlobalController indexController = Get.find();

    if (await ConnectionVerify.connectionIsAvailable()) {
      try {
        var response =
            await dio.post(URLs.baseUrl + URLs.updateProfilePhoto, data: data);
        if (response.data['status'] == true) {
          var userData = await getUserInfo(token);

          saveUserDataToSharedPrefs(userData['userInfo']);
          indexController.userInfo.value =
              await retrieveUserInfoFromSharedPrefs();

          return {
            'status': true,
            'connectionAvailable': true,
            'msg': response.data['msg']
          };
        } else {
          return {
            'status': false,
            'connectionAvailable': true,
            'msg': response.data['msg'],
          };
        }
      } catch (e) {
        print(e);
      }
    } else {
      return {
        'status': false,
        'connectionAvailable': false,
      };
    }
  }
// ===================================================================================
// END UPDATE PROFILE PHOTO
// ===================================================================================

// ===================================================================================
  ///Update account details
// ===================================================================================
  updateAccountDetails(userData, token) async {
    Dio? dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    GlobalController indexController = Get.find();

    if (await ConnectionVerify.connectionIsAvailable()) {
      try {
        var response = await dio.post(URLs.baseUrl + URLs.updateAccountDetails,
            data: userData);
        var data = response.data;

        var profileInfo = await getUserInfo(token);
        await saveUserDataToSharedPrefs(profileInfo['userInfo']);
        indexController.userInfo.value =
            await retrieveUserInfoFromSharedPrefs();

        return {
          'status': data['status'],
          'connectionAvailable': true,
          'message': data['msg'],
          'token': data['token']
        };
      } catch (e) {
        print(e);
      }
    } else {
      return {'status': false, 'connectionAvailable': false};
    }
  }
// ===================================================================================
// End Update Account Details
// ===================================================================================

  /// Save user details in shared prefs
  Future saveUserDataToSharedPrefs(user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPref.loggedIn, true);
    await prefs.setString(SharedPref.user, jsonEncode(user));
  }
// ===================================================================================
// End Save user details in shared prefs
// ===================================================================================

  /// Retrieve user info from shared prefs
  Future retrieveUserInfoFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString(SharedPref.user);
    CmUser userInfo = CmUser.fromJson(json.decode(user!));
    return userInfo;
  }
// ===================================================================================
// End Retrieve user info from shared prefs
// ===================================================================================

  /// Retrieve user login status from shared prefs
  Future<bool?> userIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loginStatus = prefs.getBool(SharedPref.loggedIn);
    return loginStatus;
  }
// ===================================================================================
// End Retrieve user login status from shared prefs
// ===================================================================================

  /// Remove shared Preferences app update activation timestamp
  Future clearTimestamp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? storedBuildNumber = prefs.getInt(SharedPref.buildNumber);
    int? currentVersion = Build.buildNumber;

    if (storedBuildNumber != null) {
      if (currentVersion > storedBuildNumber) {
        prefs.remove(SharedPref.activationTimestamp);
        prefs.setInt(SharedPref.buildNumber, Build.buildNumber);
      }
    }
    prefs.setInt(SharedPref.buildNumber, Build.buildNumber);
  }

// ===================================================================================
// End Retrieve user login status from shared prefs
// ===================================================================================

// ===================================================================================
//
// ===================================================================================

  /* Future checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      
      await prefs.setString(SharedPref.activationTimestamp,
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
      await prefs.setBool('isFirstLaunch', false);
    }
  }*/

// ===================================================================================
//
// ===================================================================================

// ========================================================
// START SET USER FIREBASE NOTIFICATION TOKEN
// ========================================================
  /* Future setUserFirebaseNotificationToken() async {
    GlobalController indexController = Get.find();

    // Dio? dio = Dio();
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient dioClient) {
    //   dioClient.badCertificateCallback =
    //       ((X509Certificate cert, String host, int port) => true);
    //   return dioClient;
    // };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.containsKey('addedFirebaseNotificationToken') == false){
    if (indexController.userIsLoggedIn.value == true) {
      // if (await ConnectionVerify.connectionIsAvailable()) {
        try {
          FirebaseMessaging messaging = FirebaseMessaging.instance;
          String? token = await messaging.getToken();

          var response = await DioSingleton.instance.post(URLs.baseUrl + URLs.updateFirebaseToken,
              data: {
                'token': token,
                'userid': indexController.userInfo.value.userId
              });
          if (response.data['status'] == true) {
            await prefs.setBool('addedFirebaseNotificationToken', true);
          }
        } catch (e) {
          print('SETUSERFIREBASENOTIFICATIONTOKEN ERROR ::: ${e.toString()}');
        }
      // }
    }
    // }
  }*/
// ========================================================
// END SET USER FIREBASE NOTIFICATION TOKEN
// ========================================================

  /// ===================================================================================
// START LOGOUT
// ===================================================================================
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(() => const Login(), transition: Transition.zoom);
  }
// ===================================================================================
// END LOGOUT
  /// ===================================================================================
}
