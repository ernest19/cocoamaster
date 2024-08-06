// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, avoid_print
import 'dart:io' as io;

import 'package:cocoa_master/controller/model/picked_media.dart';
import 'package:cocoa_master/view/home/home_controller.dart';
import 'package:cocoa_master/view/utils/bytes_to_size.dart';
import 'package:cocoa_master/view/utils/view_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../controller/entity/farmer.dart';
import '../../../../controller/global_controller.dart';
import '../../controller/entity/society.dart';
import '../global_components/globals.dart';
import '../../controller/api_interface/farmer_api.dart';
import '../utils/constants.dart';

class AddFarmerController extends GetxController {
  late BuildContext addFarmerScreenContext;

  final addFarmerFormKey = GlobalKey<FormState>();

  Globals globals = Globals();

  FarmerApiInterface farmerApiInterface = FarmerApiInterface();

  HomeController homeController = Get.find();
  GlobalController globalController = Get.find();

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  TextEditingController? farmerFirstNameTC = TextEditingController();
  TextEditingController? farmerLastNameTC = TextEditingController();

  List<String> idType = ['Ghana Card'];
  var selectedIdType = ''.obs;

  PickedMedia? farmerPhoto;

  TextEditingController? farmerIdNumberTC =
      MaskedTextController(mask: 'AAA-000000000-0');

  TextEditingController? farmerPhoneNumberTC = TextEditingController();

  TextEditingController? idExpiryDataTC = TextEditingController();

  Society? society = Society();

  TextEditingController? cocoaFarmsNumberTC = TextEditingController();

  TextEditingController? certifiedCropsNumberTC = TextEditingController();

  TextEditingController? totalPreviousYearHarvestedCocoa =
      TextEditingController();

  TextEditingController? totalPreviousYearsBagsSoldToGroup =
      TextEditingController();

  TextEditingController? currentYearBagYieldEstimate = TextEditingController();

  final ImagePicker mediaPicker = ImagePicker();

  // INITIALISE
  @override
  void onInit() async {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  // ==============================================================================
  // START ADD FARMER
  // ==============================================================================
  handleAddFarmer() async {
    DateTime now = DateTime.now();
    String formattedReportingDate = DateFormat('yyyy-MM-dd').format(now);

    Uint8List? pictureOfFarmer;
    if (farmerPhoto?.file != null) {
      final bytes = await io.File(farmerPhoto!.path!).readAsBytes();
      // pictureOfFarm = base64Encode(bytes);
      pictureOfFarmer = bytes;
    } else {
      pictureOfFarmer =
          Uint8List(0); // Assign empty Uint8List when pictureOfFarm is null
    }

    globals.startWait(addFarmerScreenContext);

    Farmer farmerData = Farmer(
      uid: const Uuid().v4(),
      agent: globalController.userInfo.value.userId,
      currentFarmerPic: pictureOfFarmer,
      firstName: farmerFirstNameTC!.text.trim(),
      lastName: farmerLastNameTC!.text.trim(),
      phoneNumber: farmerPhoneNumberTC!.text.trim(),
      idType: selectedIdType.value,
      idNumber: farmerIdNumberTC!.text.trim(),
      idExpiryDate: idExpiryDataTC!.text.trim(),
      society: society?.societyCode,
      submissionDate: formattedReportingDate,
      cocoaFarmNumberCount: cocoaFarmsNumberTC!.text.trim(),
      certifiedCropsNumber: certifiedCropsNumberTC!.text.trim(),
      totalPreviousYearsBagsSoldToGroup:
          totalPreviousYearsBagsSoldToGroup!.text.trim(),
      totalPreviousYearHarvestedCocoa:
          totalPreviousYearHarvestedCocoa!.text.trim(),
      currentYearBagYieldEstimate: currentYearBagYieldEstimate!.text.trim(),
      status: SubmissionStatus.submitted,
    );

    Map<String, dynamic> data = farmerData.toJson();

    data.remove('status');

    // print('DATADATADATA ;;; $data');
    print('FARMER ::: $farmerData');
    print('DATA ::: $data');
    print('FARMER.TOJSON::: ${farmerData.toJson()}');

    // print('DATADATADATA ;;; ${farmer.toJson}');
    var postResult = await farmerApiInterface.saveFarmer(farmerData, data);
    globals.endWait(addFarmerScreenContext);

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
          context: addFarmerScreenContext,
          content: Text(
            postResult['msg'],
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          status: AlertDialogStatus.error);
    } else {}
    // }
    // else {
    //   isButtonDisabled.value = false;
    //   globals.showSnackBar(
    //       title: 'Alert',
    //       message:
    //           'Your location accuracy is too low. It must not be greater than ${MaxLocationAccuracy.max} meters');
    //   locationData = position;
    //   update();
    // }
    // }
    //  else {
    //   isButtonDisabled.value = false;
    //   globals.showSnackBar(
    //       title: 'Alert',
    //       message:
    //           'Operation could not be completed. Turn on your location and try again');
    // }
    // });
  }

  // ==============================================================================
  // END ADD FARMER
  // ==============================================================================

  // ==============================================================================
  // START OFFLINE SAVE FARMER
  // ==============================================================================
  handleSaveOfflineMonitoringRecord() async {
    Uint8List? pictureOfFarmer;
    if (farmerPhoto?.file != null) {
      final bytes = await io.File(farmerPhoto!.path!).readAsBytes();
      // pictureOfFarm = base64Encode(bytes);
      pictureOfFarmer = bytes;
    } else {
      pictureOfFarmer =
          Uint8List(0); // Assign empty Uint8List when pictureOfFarm is null
    }

    globals.startWait(addFarmerScreenContext);
    DateTime now = DateTime.now();
    String formattedReportingDate = DateFormat('yyyy-MM-dd').format(now);

    Farmer farmer = Farmer(
      uid: const Uuid().v4(),
      agent: globalController.userInfo.value.userId,
      currentFarmerPic: pictureOfFarmer,
      firstName: farmerFirstNameTC!.text.trim(),
      lastName: farmerLastNameTC!.text.trim(),
      phoneNumber: farmerPhoneNumberTC!.text.trim(),
      idType: selectedIdType.value,
      idNumber: farmerIdNumberTC!.text,
      idExpiryDate: idExpiryDataTC!.text,
      society: society?.societyCode,
      submissionDate: formattedReportingDate,
      cocoaFarmNumberCount: cocoaFarmsNumberTC!.text,
      certifiedCropsNumber: certifiedCropsNumberTC!.text,
      totalPreviousYearsBagsSoldToGroup:
          totalPreviousYearsBagsSoldToGroup!.text,
      totalPreviousYearHarvestedCocoa: totalPreviousYearHarvestedCocoa!.text,
      currentYearBagYieldEstimate: currentYearBagYieldEstimate!.text,
      status: SubmissionStatus.pending,
    );
    Map<String, dynamic> data = farmer.toJson();

    data.remove('status');

    print('THIS IS Farmer DETAILS:::: $data');

    final farmerDao = globalController.database!.farmerDao;
    await farmerDao.insertFarmer(farmer);

    globals.endWait(addFarmerScreenContext);

    Get.back();
    globals.showSecondaryDialog(
        context: homeController.homeScreenContext,
        content: const Text(
          'Farmer saved',
          style: TextStyle(fontSize: 13),
          textAlign: TextAlign.center,
        ),
        status: AlertDialogStatus.success,
        okayTap: () => Navigator.of(homeController.homeScreenContext).pop());
    // }
    //  else {
    //   isSaveButtonDisabled.value = false;
    //   globals.showSnackBar(
    //       title: 'Alert',
    //       message:
    //           'Your location accuracy is too low. It must not be greater than ${MaxLocationAccuracy.max} meters');
    //   locationData = position;
    //   update();
    // }
    // }
    // else {
    //   isSaveButtonDisabled.value = false;
    //   globals.showSnackBar(
    //       title: 'Alert',
    //       message:
    //           'Operation could not be completed. Turn on your location and try again');
    // }
    // });
  }
  // ==============================================================================
  // END OFFLINE SAVE FARMER
  // ==============================================================================

// ===========================================
// START PICK MEDIA
// ==========================================
  pickMedia({int? source}) async {
    final XFile? mediaFile;
    var fileType = FileType.image;
    if (source == 0) {
      mediaFile = await mediaPicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
    } else {
      mediaFile = await mediaPicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);
    }

    if (mediaFile != null) {
      var fileSize = await mediaFile.length();
      PickedMedia pickedMedia = PickedMedia(
        name: mediaFile.name,
        path: mediaFile.path,
        type: fileType,
        size: fileSize,
        file: io.File(mediaFile.path),
      );
      // print('haaaaaaaaaaaaaaaa');
      // print(bytesToSize(fileSize));
      farmerPhoto = pickedMedia;
      update();
      print(bytesToSize(fileSize));
    } else {
      return null;
    }
  }
// ===========================================
// END PICK MEDIA
// ==========================================
}
