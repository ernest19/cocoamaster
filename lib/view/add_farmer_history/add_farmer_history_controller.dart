import 'package:cocoa_master/controller/api_interface/farmer_api.dart';
import 'package:cocoa_master/controller/entity/farmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/global_controller.dart';
import '../global_components/globals.dart';
import '../home/home_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AddFarmerHistoryController extends GetxController {
  BuildContext? addFarmHistoryScreenContext;

  HomeController homeController = Get.find();

  GlobalController globalController = Get.find();

  Globals globals = Globals();

  FarmerApiInterface farmerApiInterface = FarmerApiInterface();

  TabController? tabController;
  var activeTabIndex = 0.obs;

  final PagingController<int, Farmer> pendingRecordsController =
      PagingController(firstPageKey: 0);
  final PagingController<int, Farmer> submittedRecordsController =
      PagingController(firstPageKey: 0);
  final int _pageSize = 10;

  // INITIALISE

  Future<void> fetchData(
      {required int status,
      required int pageKey,
      required PagingController controller}) async {
    try {
      final data = await globalController.database!.farmerDao
          .findFarmerByStatusWithLimit(status, _pageSize, pageKey * _pageSize);

      final isLastPage = data.length < _pageSize;
      if (isLastPage) {
        controller.appendLastPage(data);
      } else {
        final nextPageKey = pageKey + 1;
        controller.appendPage(data, nextPageKey);
      }
    } catch (error) {
      controller.error = error;
    }
  }

  confirmDeleteMonitoring(Farmer contractorCertificate) async {
    globals.primaryConfirmDialog(
        context: addFarmHistoryScreenContext,
        title: 'Delete Record',
        image: 'assets/images/cocoa_monitor/question.png',
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
              "This action is irreversible. Are you sure you want to delete this record?",
              textAlign: TextAlign.center),
        ),
        cancelTap: () {
          Get.back();
        },
        okayTap: () {
          Get.back();
          globalController.database!.farmerDao
              .deletePeFarmerUID(contractorCertificate.uid!);
          // update();
          pendingRecordsController.itemList!.remove(contractorCertificate);
          update(['pendingRecordsBuilder']);
        });
  }
}
