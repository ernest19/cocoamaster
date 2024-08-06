// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, avoid_print

import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cocoa_master/controller/api_interface/farmer_api.dart';
import 'package:cocoa_master/view/utils/double_value_trimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../../controller/entity/farm.dart';
import '../../controller/entity/farmer_from_server.dart';
import '../../controller/entity/society.dart';
import '../../controller/global_controller.dart';
import '../global_components/globals.dart';
import '../home/home_controller.dart';
import '../polygon_drawing_tool/polygon_drawing_tool.dart';
import '../utils/constants.dart';
import '../utils/style.dart';
import '../utils/view_constants.dart';

class EditOutbreakFarmController extends GetxController {
  late BuildContext editFarmScreenContext;

  final formKey = GlobalKey<FormState>();

  Farm? farm;

  HomeController homeController = Get.find();

  GlobalController globalController = Get.find();

  Globals globals = Globals();

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  FarmerApiInterface farmerApiInterface = FarmerApiInterface();

  final ImagePicker mediaPicker = ImagePicker();

  // var isButtonDisabled = false.obs;
  // var isSaveButtonDisabled = false.obs;

  TextEditingController? farmAreaTC = TextEditingController();

  LocationData? locationData;

  Society? society = Society();
  FarmerFromServer? farmerFromServer = FarmerFromServer();

  Set<Marker>? markers;
  Polygon? polygon;

  Color polygonStrokeColour = Colors.green;
  Color polygonFillColour = AppColor.primary.withOpacity(0.2);

  // INITIALISE
  @override
  void onInit() async {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      farmAreaTC?.text = farm!.farmArea.toString();

      List? societyList = await globalController.database!.societyDao
          .findSocietyBySocietyCode(farm!.societyCode!);
      society = societyList.first;
      update();

      var polygonPointsString =
          const Utf8Decoder().convert(farm!.farmboundary ?? []);
      List polygonPoints = jsonDecode(polygonPointsString) as List;

      if (polygonPoints.isNotEmpty) {
        polygonPoints.removeLast();
      }

      if (polygonPoints.isNotEmpty) {
        polygon = Polygon(
          polygonId: const PolygonId('001'),
          fillColor: polygonFillColour,
          strokeColor: polygonStrokeColour,
          strokeWidth: 2,
          points: polygonPoints
              .map((e) => LatLng(e['latitude'], e['longitude']))
              .toList(),
        );
      }

      update();

      List? farmerFromServerDataList = await globalController
          .database!.farmerFromServerDao
          .findFarmerFromServerByFarmerId(farm!.farmer!);
      farmerFromServer = farmerFromServerDataList.first;
      update();
    });
  }

  // ==============================================================================
  // START ADD OUTBREAK FARM
  // ==============================================================================
  handleAddFarm() async {
    // UserCurrentLocation? userCurrentLocation =
    //     UserCurrentLocation(context: editFarmScreenContext);
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

    globals.startWait(editFarmScreenContext);

    DateTime now = DateTime.now();
    String formattedReportingDate = DateFormat('yyyy-MM-dd').format(now);

    Farm farmData = Farm(
        uid: farm?.uid,
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
    globals.endWait(editFarmScreenContext);
    if (postResult['status'] == RequestStatus.True ||
        postResult['status'] == RequestStatus.Exist ||
        postResult['status'] == RequestStatus.NoInternet) {
      // Get.back();
      Get.back(result: {'farm': farmData, 'submitted': true});
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
          context: editFarmScreenContext,
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
  // END ADD OUTBREAK FARM
  // ==============================================================================

  // ==============================================================================
  // START OFFLINE SAVE OUTBREAK FARM
  // ==============================================================================
  handleSaveOfflineFarm() async {
    // UserCurrentLocation? userCurrentLocation =
    //     UserCurrentLocation(context: editFarmScreenContext);
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

    globals.startWait(editFarmScreenContext);

    DateTime now = DateTime.now();
    String formattedReportingDate = DateFormat('yyyy-MM-dd').format(now);

    Farm farmData = Farm(
        uid: farm?.uid,
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
    await farmDao.updateFarm(farmData);

    globals.endWait(editFarmScreenContext);

    // Get.back();
    Get.back(result: {'farm': farmData, 'submitted': false});
    globals.showSecondaryDialog(
        context: homeController.homeScreenContext,
        content: const Text(
          'Record saved',
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

  usePolygonDrawingTool() {
    Set<Polygon> polys = HashSet<Polygon>();
    if (polygon != null) polys.add(polygon!);
    Get.to(
        () => PolygonDrawingTool(
              layers: polys,
              // layers: HashSet<Polygon>(),
              useBackgroundLayers: false,
              allowTappingInputMethod: false,
              allowTracingInputMethod: false,
              maxAccuracy: MaxLocationAccuracy.max,
              persistMaxAccuracy: true,
              onSave: (poly, mkr, area) {},
            ),
        transition: Transition.fadeIn);
  }

  usePolygonDrawingToolViewOnly() {
    Set<Polygon> polys = HashSet<Polygon>();
    if (polygon != null) polys.add(polygon!);
    Get.to(
        () => PolygonDrawingTool(
              layers: polys,
              // layers: HashSet<Polygon>(),
              useBackgroundLayers: false,
              allowTappingInputMethod: false,
              allowTracingInputMethod: false,
              maxAccuracy: MaxLocationAccuracy.max,
              persistMaxAccuracy: true,
              initialPolygon: polygon,
              viewInitialPolygon: true, viewOnlyMap: true,
              onSave: (poly, mkr, area) {},
            ),
        transition: Transition.fadeIn);
  }
}
