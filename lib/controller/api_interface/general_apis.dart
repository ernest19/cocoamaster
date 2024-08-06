// ignore_for_file: avoid_print

import 'dart:convert';

// import 'package:dio/adapter.dart';
// import 'package:dio/dio.dart';
import 'package:cocoa_master/controller/entity/assigned_farm.dart';
import 'package:cocoa_master/controller/entity/society.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view/global_components/globals.dart';
import '../../view/utils/constants.dart';
import '../../view/utils/dio_singleton_instance.dart';
import '../entity/farmer_from_server.dart';
import '../global_controller.dart';

typedef OnOperationCompletedCallback = Function();

class GeneralCocoaRehabApiInterface {
  GlobalController indexController = Get.find();
  Globals globals = Globals();

  // ==============================================================================
  // =========================== START GET SOCIETIES  ===============================
  // ==============================================================================

  Future loadSocieties() async {
    final societyDao = indexController.database!.societyDao;
    print(' USERID: ${indexController.userInfo.value.userId}');

    try {
      var response = await DioSingleton.instance.post(
          URLs.baseUrl + URLs.loadSocieties,
          data: {"user_id": indexController.userInfo.value.userId});
      if (response.data['status'] == true && response.data['data'] != null) {
        List resultList = response.data['data'];
        List<Society> listOfSociety =
            resultList.map((e) => socieryFromJson(jsonEncode(e))).toList();
        await societyDao.deleteAllSociety();
        await societyDao.bulkInsertSociety(listOfSociety);
        debugPrint(
            'LOADING Society TO LOCAL DB SHOULD BE SUCCESSFUL ::: ${response.data?['status']}');

        return true;
      } else {
        debugPrint(
            'RESPONSE DATA FAILED IN LOAD Society ::: ${response.data?['status']}');

        // return false;
      }
    } catch (e) {
      print(' LOAD Society TO LOCAL DB ERROR ${e.toString()}');
    }
    // }
  }

// ==============================================================================
// ============================  END GET SOCIETIES  ===============================
// ==============================================================================

  // ==============================================================================
  // =========================== START GET FARMERS  ===============================
  // ==============================================================================

  Future loadFarmers() async {
    final farmerFromServerDao = indexController.database!.farmerFromServerDao;

    try {
      var response = await DioSingleton.instance.post(
          URLs.baseUrl + URLs.loadFarmers,
          data: {'user_id': indexController.userInfo.value.userId});

      if (response.data['status'] == true && response.data['data'] != null) {
        List resultList = response.data['data'];

        List<FarmerFromServer> farmerList = resultList.map((e) {
          return farmerFromServerFromJson(jsonEncode(e));
        }).toList();
        await farmerFromServerDao.deleteAllFarmersFromServer();
        await farmerFromServerDao.bulkInsertFarmersFromServer(farmerList);
        debugPrint(
            'LOADING Farmer TO LOCAL DB SHOULD BE SUCCESSFUL ::: ${response.data?['status']}');

        return true;
      } else {
        // return false;
        debugPrint(
            'RESPONSE DATA FAILED IN Farmer ASSISTANTS ::: ${response.data?['status']}');
      }
    } catch (e) {
      print(' LOAD Farmer TO LOCAL DB ERROR ${e.toString()}');
    }
  }

// ==============================================================================
// ============================  END GET FARMERS  ===============================
// ==============================================================================

  // ==============================================================================
  // =========================== START GET ASSIGNED FARMS  ========================
  // ==============================================================================

  Future loadAssignedFarms() async {
    final assignedFarmDao = indexController.database!.assignedFarmDao;
    // Dio? dio = Dio();
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient dioClient) {
    //   dioClient.badCertificateCallback =
    //       ((X509Certificate cert, String host, int port) => true);
    //   return dioClient;
    // };

    // if (await ConnectionVerify.connectionIsAvailable()) {
    try {
      var response = await DioSingleton.instance.post(
          URLs.baseUrl + URLs.loadAssignedFarms,
          data: {'user_id': indexController.userInfo.value.userId});
      debugPrint(
          'LOADING USER ID ==> ASSIGNED FARMS ::: ${indexController.userInfo.value.userId}');
      if (response.data['status'] == true && response.data['data'] != null) {
        List resultList = response.data['data'];
        List<AssignedFarm> farmList =
            resultList.map((e) => assignedFarmFromJson(jsonEncode(e))).toList();
        await assignedFarmDao.deleteAllAssignedFarms();
        await assignedFarmDao.bulkInsertAssignedFarms(farmList);
        debugPrint(
            'LOADING ASSIGNED FARM  TO LOCAL DB SHOULD BE SUCCESSFUL ::: ${response.data?['status']}');

        return true;
      } else {
        debugPrint(
            'RESPONSE DATA FAILED IN LOAD ASSIGNED FARM::: ${response.data?['status']}');

        // return false;
      }
    } catch (e, stackTrace) {
      print(' LOAD ASSIGNED FARM TO LOCAL DB ERROR ${e.toString()}');
      // FirebaseCrashlytics.instance.recordError(e, stackTrace);
      // FirebaseCrashlytics.instance.log('loadAssignedFarms');
    }
    // }
  }

// ==============================================================================
// ============================  END GET ASSIGNED FARMS ===============================
// ==============================================================================

// ===================================================================================
// START SEND FEEDBACK
// ===================================================================================
  /* submitIssue(data) async {
    // if (await ConnectionVerify.connectionIsAvailable()) {
      try {
        var response = await DioSingleton.instance
            .post(URLs.baseUrl + URLs.sendIssue, data: data);
        if (response.data['status'] == RequestStatus.True) {
          return {
            'status': response.data['status'],
            'connectionAvailable': true,
            'msg': response.data['msg']
          };
        } else {
          return {
            'status': response.data['status'],
            'connectionAvailable': true,
            'msg': response.data['msg'],
          };
        }
      } catch (e) {
        print(e);
        return {
          'status': RequestStatus.False,
          'connectionAvailable': true,
          'msg':
              'There was an error submitting your request. Kindly contact your supervisor',
        };
      }
    // } else {
    //   return {
    //     'status': RequestStatus.NoInternet,
    //     'connectionAvailable': false,
    //     'msg': 'You do not have an active internet connection',
    //   };
    // }
  }*/
// ===================================================================================
// END SEND FEEDBACK
// ===================================================================================

// ==============================================================================
  // =========================== START GET FINANCIAL REPORTS  ===============================
  // ==============================================================================

  // Future loadFinacialReport() async {
  //   Dio? dio = Dio();
  //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //       (HttpClient dioClient) {
  //     dioClient.badCertificateCallback =
  //         ((X509Certificate cert, String host, int port) => true);
  //     return dioClient;
  //   };

  //   if (await ConnectionVerify.connectionIsAvailable()) {
  //     try {
  //       var response = await dio.post(URLs.baseUrl + URLs.loadPayments,
  //           data: {'userid': indexController.userInfo.value.userId,
  //           'month' : 'May',
  //           'week' : '3',
  //           'year' : '2023'
  //           });
  //       if (response.data['status'] == true && response.data['data'] != null) {
  //         // var decodedData =
  //         //     json.decode(response.data).cast<Map<String, dynamic>>();
  //         // List resultList = response.data['data'];
  //         // return true;
  //       } else {
  //         // return false;
  //       }
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  // }

// ==============================================================================
// ============================  END GET FINANCIAL REPORTS  ===============================
// ==============================================================================
}
