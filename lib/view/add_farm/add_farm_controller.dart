// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, avoid_print

import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cocoa_master/controller/entity/farmer_from_server.dart';
import 'package:cocoa_master/controller/entity/society.dart';
import 'package:cocoa_master/view/utils/double_value_trimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

import '../../controller/api_interface/farmer_api.dart';
import '../../controller/entity/farm.dart';
import '../../controller/global_controller.dart';
import '../global_components/globals.dart';
import '../home/home_controller.dart';
import '../polygon_drawing_tool/polygon_drawing_tool.dart';
import '../utils/constants.dart';
import '../utils/style.dart';
import '../utils/user_current_location.dart';
import '../utils/view_constants.dart';

class AddFarmController extends GetxController {
  late BuildContext addFarmScreenContext;

  final addFarmFormKey = GlobalKey<FormState>();

  HomeController homeController = Get.find();

  GlobalController globalController = Get.find();

  Globals globals = Globals();

  FarmerApiInterface farmerApiInterface = FarmerApiInterface();

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  // var isButtonDisabled = false.obs;
  // var isSaveButtonDisabled = false.obs;

  TextEditingController? farmAreaTC = TextEditingController();
  var idType;

  LocationData? locationData;

  Society? society = Society();
  FarmerFromServer? farmerFromServer = FarmerFromServer();

  Set<Marker>? markers;
  Polygon? polygon;

  // INITIALISE
  @override
  void onInit() async {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      UserCurrentLocation? userCurrentLocation =
          UserCurrentLocation(context: addFarmScreenContext);
      userCurrentLocation.getUserLocation(
          forceEnableLocation: true,
          onLocationEnabled: (isEnabled, pos) {
            if (isEnabled == true) {
              locationData = pos!;
              update();
            }
          });
    });
  }

  usePolygonDrawingTool() {
    Set<Polygon> polys = HashSet<Polygon>();
    if (polygon != null) polys.add(polygon!);
    Get.to(
        () => PolygonDrawingTool(
              layers: polys,
              initialPolygon: polygon,
              viewInitialPolygon: polygon != null,
              // layers: HashSet<Polygon>(),
              useBackgroundLayers: false,
              allowTappingInputMethod: false,
              allowTracingInputMethod: false,
              maxAccuracy: MaxLocationAccuracy.max,
              persistMaxAccuracy: true,
              onSave: (poly, mkr, area) {
                if (mkr.isNotEmpty) {
                  polygon = poly;
                  markers = mkr;
                  farmAreaTC?.text = area.truncateToDecimalPlaces(6).toString();
                  update();
                  globals.showOkayDialog(
                    context: addFarmScreenContext,
                    title: 'Measurement Result',
                    image: 'assets/images/cocoa_monitor/ruler-combined.png',
                    content: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('measured area estimates in hectares',
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
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
        transition: Transition.fadeIn);
  }

  // ==============================================================================
  // START ADD PERSONNEL
  // ==============================================================================
  handleAddFarm() async {
    // UserCurrentLocation? userCurrentLocation =
    //     UserCurrentLocation(context: addFarmScreenContext);
    // isButtonDisabled.value = true;

    polygon!.points.add(polygon!.points.first);
    var boundaryCoordinates = polygon!.points
        .map((e) => {'latitude': e.latitude, 'longitude': e.longitude})
        .toList();

    // userCurrentLocation.getUserLocation(
    //     forceEnableLocation: true,
    //     onLocationEnabled: (isEnabled, position) async {
    //       if (isEnabled == true) {
    //         locationData = position;

    //         isButtonDisabled.value = false;

    globals.startWait(addFarmScreenContext);

    DateTime now = DateTime.now();
    String formattedReportingDate = DateFormat('yyyy-MM-dd').format(now);

    Farm farmData = Farm(
        uid: const Uuid().v4(),
        agent: globalController.userInfo.value.userId!,
        farmboundary:
            Uint8List.fromList(utf8.encode(jsonEncode(boundaryCoordinates))),
        farmer: farmerFromServer!.farmerId,
        farmArea: double.parse(farmAreaTC!.text.trim()),
        registrationDate: formattedReportingDate,
        status: SubmissionStatus.submitted,
        societyCode: society?.societyCode);

    Map<String, dynamic> data = farmData.toJson();
    data.remove('status');
    data.remove('societyCode');

    var postResult = await farmerApiInterface.saveFarm(farmData, data);
    globals.endWait(addFarmScreenContext);

    if (postResult['status'] == RequestStatus.True ||
        postResult['status'] == RequestStatus.Exist ||
        postResult['status'] == RequestStatus.NoInternet) {
      Get.back();
      globals.showSecondaryDialog(
          context: homeController.homeScreenContext,
          content: Text(
            postResult['msg'],
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          status: AlertDialogStatus.success,
          okayTap: () => Navigator.of(homeController.homeScreenContext).pop());
    } else if (postResult['status'] == RequestStatus.False) {
      globals.showSecondaryDialog(
          context: addFarmScreenContext,
          content: Text(
            postResult['msg'],
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          status: AlertDialogStatus.error);
    } else {}
    //   } else {
    //     isButtonDisabled.value = false;
    //     globals.showSnackBar(
    //         title: 'Alert',
    //         message:
    //             'Operation could not be completed. Turn on your location and try again');
    //   }
    // });
  }
  // ==============================================================================
  // END ADD PERSONNEL
  // ==============================================================================

  // ==============================================================================
  // START OFFLINE SAVE OUTBREAK FARM
  // ==============================================================================
  handleSaveOfflineFarm() async {
    // UserCurrentLocation? userCurrentLocation =
    //     UserCurrentLocation(context: addFarmScreenContext);
    // isSaveButtonDisabled.value = true;

    polygon!.points.add(polygon!.points.first);
    var boundaryCoordinates = polygon!.points
        .map((e) => {'latitude': e.latitude, 'longitude': e.longitude})
        .toList();

    // userCurrentLocation.getUserLocation(
    //     forceEnableLocation: true,
    //     onLocationEnabled: (isEnabled, position) async {
    //       if (isEnabled == true) {
    //         locationData = position;

    //         isSaveButtonDisabled.value = false;

    globals.startWait(addFarmScreenContext);

    DateTime now = DateTime.now();
    String formattedReportingDate = DateFormat('yyyy-MM-dd').format(now);

    Farm farmData = Farm(
        uid: const Uuid().v4(),
        agent: globalController.userInfo.value.userId!,
        farmboundary:
            Uint8List.fromList(utf8.encode(jsonEncode(boundaryCoordinates))),
        farmer: farmerFromServer!.farmerId,
        farmArea: double.parse(farmAreaTC!.text.trim()),
        registrationDate: formattedReportingDate,
        status: SubmissionStatus.pending,
        societyCode: society?.societyCode);
    Map<String, dynamic> data = farmData.toJson();
    data.remove('status');
    data.remove('societyCode');

    print('THIS IS Farm DETAILS:::: $data');

    final farmDao = globalController.database!.farmDao;
    await farmDao.insertFarm(farmData);

    globals.endWait(addFarmScreenContext);

    Get.back(result: {'farm': farmData, 'submitted': false});
    globals.showSecondaryDialog(
        context: homeController.homeScreenContext,
        content: const Text(
          'Farm Record saved',
          style: TextStyle(fontSize: 13),
          textAlign: TextAlign.center,
        ),
        status: AlertDialogStatus.success,
        okayTap: () => Navigator.of(homeController.homeScreenContext).pop());
    //   } else {
    //     isSaveButtonDisabled.value = false;
    //     globals.showSnackBar(
    //         title: 'Alert',
    //         message:
    //             'Operation could not be completed. Turn on your location and try again');
    //   }
    // });
  }
  // ==============================================================================
  // END OFFLINE SAVE OUTBREAK FARM
  // ==============================================================================
}
