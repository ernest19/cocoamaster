// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:collection';

import 'package:cocoa_master/view/utils/constants.dart';
import 'package:cocoa_master/view/utils/double_value_trimmer.dart';
import 'package:cocoa_master/view/polygon_drawing_tool/polygon_drawing_tool.dart';
import 'package:cocoa_master/view/utils/style.dart';
import 'package:cocoa_master/view/global_components/text_input_decoration.dart';
import 'package:cocoa_master/view/utils/view_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../controller/api_interface/farmer_api.dart';
import '../../controller/api_interface/general_apis.dart';
import '../global_components/custom_button.dart';
import '../../controller/entity/calculated_area.dart';
import '../../controller/entity/po_location.dart';
import '../../controller/global_controller.dart';
import '../global_components/globals.dart';
// import '../update_compulsion/mandatory_update.dart';
import '../utils/connection_verify.dart';
// import '../utils/constants.dart';

class HomeController extends GetxController {
  late BuildContext homeScreenContext;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final saveCalculatedAreaFormKey = GlobalKey<FormState>();
  TextEditingController? calculatedAreaTitleTC = TextEditingController();

  Globals globals = Globals();
  GlobalController globalController = Get.find();
  var loadingInitialData = true.obs;
  GeneralCocoaRehabApiInterface generalCocoaRehabApiInterface =
      GeneralCocoaRehabApiInterface();
  SharedPreferences? prefs;
  bool? isFirstLaunch;
  int? storedTimestamp;

  @override
  void onInit() async {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // checkFirstLaunch();
      syncData();
    });
    // Timer.periodic(const Duration(minutes: 5), (timer) {
    //   checkFirstLaunch();
    // });
  }

  // void checkFirstLaunch() async {
  //   prefs = await SharedPreferences.getInstance();
  //   isFirstLaunch = prefs?.getBool('isFirstLaunch') ?? true;

  //   if (isFirstLaunch!) {
  //     int timestamp = DateTime.now().millisecondsSinceEpoch;
  //     await prefs?.setInt('timestamp', timestamp);
  //     await prefs?.setBool('isFirstLaunch', false);
  //   }

  //   storedTimestamp = prefs?.getInt('timestamp');

  //   if (isFirstLaunch! && storedTimestamp != null) {
  //     DateTime launchDateTime =
  //         DateTime.fromMillisecondsSinceEpoch(storedTimestamp!);
  //     DateTime now = DateTime.now();
  //     Duration difference = now.difference(launchDateTime);

  //     if (difference.inSeconds >= 30) {
  //       showDialog(
  //         context: homeScreenContext,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text('Dialog Title'),
  //             content: const Text(
  //                 'This dialog is shown on the third day after the first launch.'),
  //             actions: [
  //               TextButton(
  //                 child: const Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   }
  // }
  /*void checkFirstLaunch() async {
    SharedPreferences? prefs = ShareP.preferences;
    String? storedTimestamp = prefs?.getString(SharedPref.activationTimestamp);
    if (storedTimestamp != null) {
      DateTime storedTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').parse(storedTimestamp);

      Duration difference = DateTime.now().difference(storedTime);

      if (difference.inSeconds >= 259200) {
        Get.offAll(() => const MandatoryUpdateScreen());
      }
    }
  }*/

// ===========================================
// START SYNC
// ==========================================
  syncData() async {
    if (await ConnectionVerify.connectionIsAvailable()) {
      loadingInitialData.value = true;
      if (homeScreenContext.mounted) {
        globals.startWait(homeScreenContext);
      }
      var futures = await Future.wait([
        generalCocoaRehabApiInterface.loadSocieties(),
        generalCocoaRehabApiInterface.loadFarmers(),
        generalCocoaRehabApiInterface.loadAssignedFarms(),

        // userInfoApiInterface.setUserFirebaseNotificationToken()
      ]).catchError((error) {
        print('ERROR ERROR ERROR ::: $error');
        throw (error);
      });
      debugPrint(futures.toString());
      if (homeScreenContext.mounted) {
        globals.endWait(homeScreenContext);
      }
      loadingInitialData.value = false;
    }
  }
// ===========================================
// END SYNC
// ==========================================

  usePolygonDrawingTool() {
    Get.to(
        () => PolygonDrawingTool(
              layers: HashSet<Polygon>(),
              useBackgroundLayers: false,
              allowTappingInputMethod: false,
              allowTracingInputMethod: false,
              maxAccuracy: MaxLocationAccuracy.max,
              persistMaxAccuracy: true,
              onSave: (polygon, markers, area) {
                if (markers.isNotEmpty) {
                  globals.primaryConfirmDialog(
                      context: homeScreenContext,
                      title: 'Measurement Result',
                      image: 'assets/images/cocoa_monitor/ruler-combined.png',
                      content: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Demarcated area estimate in hectares',
                                style: TextStyle(color: AppColor.black),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 15),
                            Text(
                                '${area.truncateToDecimalPlaces(6).toString()} ha',
                                style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 20),
                            Text('Would you like to save this measurement?',
                                style: TextStyle(color: AppColor.black),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      cancelTap: () {
                        Get.back();
                      },
                      okayTap: () {
                        Get.back();
                        showSaveMeasurementResultDialog(
                            '${area.truncateToDecimalPlaces(6).toString()} ha');
                      });

                  final poLocationDao =
                      globalController.database!.poLocationDao;
                  PoLocation poLocation = PoLocation(
                    lat: markers.first.position.latitude,
                    lng: markers.first.position.longitude,
                    accuracy: 0,
                    uid: const Uuid().v4(),
                    userid: 1,
                    // int.parse(globalController.userInfo.value.userId!),
                    inspectionDate: DateTime.now(),
                  );
                  poLocationDao.insertPOLocation(poLocation);
                  // saveUserLocation();

                  /*globals.showOkayDialog(
                    context: homeScreenContext,
                    title: 'Measurement Result',
                    image: 'assets/images/cocoa_monitor/ruler-combined.png',
                    content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                   child: Column(
                    mainAxisSize: MainAxisSize.min,
                     children: [
                    Text('Demarcated area estimates in hectares',
                        style: TextStyle(color: AppColor.black),
                        textAlign: TextAlign.center
                    ),
                    SizedBox(height: 15),
                    Text('${area.truncateToDecimalPlaces(6).toString()} ha',
                        style: TextStyle(color: AppColor.black, fontSize: 20, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center
                    ),
                     ],
                     ),
                    ),
                   );*/
                }
              },
            ),
        transition: Transition.fadeIn);
  }

// ===========================================
// START Show Menu Options
// ==========================================
  /*showMenuOptions(String title, String menuItem){
    showModalBottomSheet<void>(
      elevation: 5,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppBorderRadius.md),
        ),
      ),
      context: homeScreenContext!,
      builder: (context) {
        // return MenuOptionsBottomSheet(title: title, menuItem: menuItem,);
        return OBMenuOptionsBottomSheet(title: title, menuItem: menuItem,);
      },
    );
  }*/
  showMenuOptions(Widget widget) {
    showModalBottomSheet<void>(
      elevation: 5,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppBorderRadius.md),
        ),
      ),
      context: homeScreenContext,
      builder: (context) {
        // return MenuOptionsBottomSheet(title: title, menuItem: menuItem,);
        return widget;
      },
    );
  }
// ===========================================
// END Show Menu Options
// ==========================================

  syncFarmerData() async {
    FarmerApiInterface farmerApiInterface = FarmerApiInterface();
    if (await ConnectionVerify.connectionIsAvailable()) {
      if (homeScreenContext.mounted) {
        globals.startWait(homeScreenContext);
      }
      await farmerApiInterface.syncFarmer();
      if (homeScreenContext.mounted) {
        globals.endWait(homeScreenContext);
        globals.showSecondaryDialog(
            context: homeScreenContext,
            content: const Text(
              'Data synced',
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
            status: AlertDialogStatus.success);
      }
    } else {
      globals.showSnackBar(
          title: 'Alert', message: 'Not connected to the internet');
    }
  }

  syncFarmData() async {
    FarmerApiInterface farmerApiInterface = FarmerApiInterface();
    if (await ConnectionVerify.connectionIsAvailable()) {
      if (homeScreenContext.mounted) {
        globals.startWait(homeScreenContext);
      }
      await farmerApiInterface.syncFarm();
      if (homeScreenContext.mounted) {
        globals.endWait(homeScreenContext);
        globals.showSecondaryDialog(
            context: homeScreenContext,
            content: const Text(
              'Data synced',
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
            status: AlertDialogStatus.success);
      }
    } else {
      globals.showSnackBar(
          title: 'Alert', message: 'Not connected to the internet');
    }
  }

  showSaveMeasurementResultDialog(String result) {
    AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white,
      scrollable: false,
      insetPadding: const EdgeInsets.all(20.0),
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppBorderRadius.sm))),
      content: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(homeScreenContext).viewInsets.bottom),
        padding: EdgeInsets.symmetric(
            vertical: 30, horizontal: AppPadding.horizontal),
        child: Form(
          key: saveCalculatedAreaFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                result,
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
              ),
              const SizedBox(height: 15),
              const Text(
                'Title of area calculated',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: calculatedAreaTitleTC,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  enabledBorder: inputBorder,
                  focusedBorder: inputBorderFocused,
                  errorBorder: inputBorder,
                  focusedErrorBorder: inputBorderFocused,
                  filled: true,
                  fillColor: AppColor.xLightBackground,
                ),
                textInputAction: TextInputAction.next,
                validator: (String? value) =>
                    value!.trim().isEmpty ? "Title is required" : null,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    isFullWidth: false,
                    backgroundColor: AppColor.lightBackground,
                    verticalPadding: 0.0,
                    horizontalPadding: 8.0,
                    onTap: () => Get.back(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: AppColor.black, fontSize: 11),
                    ),
                  ),
                  CustomButton(
                    isFullWidth: false,
                    backgroundColor: AppColor.primary,
                    verticalPadding: 0.0,
                    horizontalPadding: 8.0,
                    onTap: () async {
                      if (saveCalculatedAreaFormKey.currentState!.validate()) {
                        CalculatedArea calculatedArea = CalculatedArea(
                            date: DateTime.now(),
                            title: calculatedAreaTitleTC!.text.trim(),
                            value: result);

                        final calculatedAreaDao =
                            globalController.database!.calculatedAreaDao;
                        await calculatedAreaDao
                            .insertCalculatedArea(calculatedArea);

                        Get.back();
                        if (homeScreenContext.mounted) {}
                        globals.showSecondaryDialog(
                          context: homeScreenContext,
                          content: const Text(
                            'Calculated area saved',
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                          status: AlertDialogStatus.success,
                        );
                      } else {}
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).show(homeScreenContext,
        dialogTransitionType: DialogTransitionType.NONE,
        barrierDismissible: true,
        barrierColor: AppColor.black.withOpacity(0.8));
  }
}
