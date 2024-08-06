// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, avoid_print

import 'dart:io' as io;

import 'package:cocoa_master/controller/api_interface/farmer_list_api.dart';
import 'package:cocoa_master/controller/api_interface/general_apis.dart';
import 'package:cocoa_master/controller/entity/farmer.dart';
import 'package:cocoa_master/controller/entity/farmer_from_server.dart';
import 'package:cocoa_master/controller/model/picked_media.dart';
import 'package:cocoa_master/view/utils/bytes_to_size.dart';
import 'package:cocoa_master/view/widgets/_media_source_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:uuid/uuid.dart';

import '../../controller/entity/society.dart';
import '../../controller/global_controller.dart';
import '../global_components/globals.dart';
import '../home/home_controller.dart';
import '../utils/constants.dart';
import '../utils/view_constants.dart';

class EditFarmerListRecordController extends GetxController {
  late BuildContext editFarmerListRecordScreenContext;

  final editFarmerListRecordFormKey = GlobalKey<FormState>();

  GeneralCocoaRehabApiInterface generalCocoaRehabApiInterface =
      GeneralCocoaRehabApiInterface();

  FarmerFromServer? farmer;
  bool? isViewMode;

  HomeController homeController = Get.find();

  Globals globals = Globals();

  FarmerListApiInterface farmerListApiInterface = FarmerListApiInterface();

  GlobalController globalController = Get.find();

  final ImagePicker mediaPicker = ImagePicker();

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

  // INITIALISE
  @override
  void onInit() async {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      idExpiryDataTC?.text = farmer!.idExpiryDate ?? '';
      selectedIdType.value = farmer!.idType ?? '';

      // farmerPhoto = farmer!.currentFarmerPic;

      farmerFirstNameTC?.text = farmer!.farmerFirstName ?? '';
      farmerLastNameTC?.text = farmer!.farmerLastName ?? '';
      farmerIdNumberTC?.text = farmer!.nationalIdNumber ?? '';
      farmerPhoneNumberTC?.text = farmer!.phoneNumber ?? '';

      cocoaFarmsNumberTC?.text = farmer!.numberOfCocoaFarms.toString();
      certifiedCropsNumberTC?.text = farmer!.numberOfCertifiedCrops.toString();
      totalPreviousYearHarvestedCocoa?.text =
          farmer!.cocoaBagsHarvestedPreviousYear.toString();
      totalPreviousYearsBagsSoldToGroup?.text =
          farmer!.cocoaBagsSoldToGroup.toString();
      currentYearBagYieldEstimate?.text =
          farmer!.currentYearYieldEstimate.toString();

      List? societyDataList = await globalController.database!.societyDao
          .findSocietyBySocietyName(farmer!.societyName!);
      society = societyDataList.first;
      update();

      Future.delayed(const Duration(seconds: 3), () async {
        update();
      });
    });
  }

  // ==============================================================================
  // START ADD MONITORING RECORD
  // ==============================================================================
  handleAddFarmerRecord() async {
    globals.startWait(editFarmerListRecordScreenContext);

    DateTime now = DateTime.now();
    String formattedReportingDate = DateFormat('yyyy-MM-dd').format(now);

    Uint8List? pictureOfFarmer = farmer!.farmerPhoto;
    if (farmerPhoto?.file != null && pictureOfFarmer != null) {
      final bytes = await io.File(farmerPhoto!.path!).readAsBytes();
      // pictureOfFarm = base64Encode(bytes);
      pictureOfFarmer = bytes;
      debugPrint("Farmer picture empty no");
    } else {
      pictureOfFarmer =
          Uint8List(0); // Assign empty Uint8List when pictureOfFarm is null

      debugPrint("Farmer picture empty na");
    }

    FarmerFromServerUpdate farmerData = FarmerFromServerUpdate(
      pk: farmer?.farmerId.toString(),
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
      // status: SubmissionStatus.submitted,
    );

    Map<String, dynamic> data = farmerData.toJson();
    data.remove('status');

    print('THIS IS Farmer LIST MODIFIED DETAILS:::: $data');

    print('DATADATADATA ;;; $data');
    var postResult = await farmerListApiInterface.saveFarmerListRecord(data);
    // globals.endWait(editFarmerListRecordScreenContext);

// if (postResult['status'] == RequestStatus.True ||
//         postResult['status'] == RequestStatus.Exist ||
//         postResult['status'] == RequestStatus.NoInternet) // complete check

    if (postResult['status'] == RequestStatus.True) {
      await generalCocoaRehabApiInterface.loadFarmers();

      globals.endWait(editFarmerListRecordScreenContext);

      Get.back(result: {'farmer': farmerData, 'submitted': true});

      globals.showSecondaryDialog(
          context: homeController.homeScreenContext,
          content: Text(
            postResult['msg'],
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          status: AlertDialogStatus.success,
          okayTap: () => Navigator.of(homeController.homeScreenContext).pop());

      Navigator.pop(editFarmerListRecordScreenContext);
    } else if (postResult['status'] == RequestStatus.NoInternet) {
      globals.endWait(editFarmerListRecordScreenContext);

      // Get.back(result: {'farmer': farmerData, 'submitted': true});

      globals.showSecondaryDialog(
          context: homeController.homeScreenContext,
          content: Text(
            postResult['msg'],
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          status: AlertDialogStatus.error,
          okayTap: () => Navigator.of(homeController.homeScreenContext).pop());
    } else if (postResult['status'] == RequestStatus.False) {
      globals.endWait(editFarmerListRecordScreenContext);

      globals.showSecondaryDialog(
          context: editFarmerListRecordScreenContext,
          content: Text(
            postResult['msg'],
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          status: AlertDialogStatus.error);
    }
  }

  // ==============================================================================
  // END ADD MONITORING RECORD
  // ==============================================================================

  // ==============================================================================
  // START OFFLINE SAVE MONITORING RECORD
  // ==============================================================================
  handleSaveOfflineFarmerRecord() async {
    globals.startWait(editFarmerListRecordScreenContext);

    DateTime now = DateTime.now();
    String formattedReportingDate = DateFormat('yyyy-MM-dd').format(now);

    Uint8List? pictureOfFarmer;
    if (farmerPhoto?.file != null) {
      final bytes = await io.File(farmerPhoto!.path!).readAsBytes();
      // pictureOfFarm = base64Encode(bytes);
      pictureOfFarmer = bytes;

      debugPrint("Farmer picture empty no");
    } else {
      // pictureOfFarmer = farmer?.currentFarmerPic ??
      //     Uint8List(0); // Assign empty Uint8List when pictureOfFarm is null

      debugPrint("Farmer picture empty na");
    }

    Farmer farmerData = Farmer(
      // uid: farmer?.uid,
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

    Map<String, dynamic> data = farmerData.toJson();
    data.remove('status');

    print('THIS IS Farmer DETAILS:::: $data');

    final farmerDao = globalController.database!.farmerDao;
    await farmerDao.updateFarmer(farmerData);

    globals.endWait(editFarmerListRecordScreenContext);

    // Get.back();
    Get.back(result: {'farmer': farmerData, 'submitted': false});
    globals.showSecondaryDialog(
        context: homeController.homeScreenContext,
        content: const Text(
          'Farmer record saved',
          style: TextStyle(fontSize: 13),
          textAlign: TextAlign.center,
        ),
        status: AlertDialogStatus.success,
        okayTap: () => Navigator.of(homeController.homeScreenContext).pop());
  }

  // ==============================================================================
  // END OFFLINE SAVE MONITORING RECORD
  // ==============================================================================

// ===========================================
// START SHOW MEDIA SOURCE BOTTOM SHEET
// ==========================================
  chooseMediaSource() {
    AlertDialog(
      scrollable: true,
      // insetPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(10.0),
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0))),
      content: MediaSourceDialog(
        mediaType: FileType.image,
        onCameraSourceTap: (source, mediaType) => pickMedia(source: source),
        onGallerySourceTap: (source, mediaType) => pickMedia(source: source),
      ),
    ).show(editFarmerListRecordScreenContext);
  }
// ===========================================
// END SHOW MEDIA SOURCE BOTTOM SHEET
// ==========================================

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
