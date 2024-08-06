import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../controller/entity/farm.dart';
import '../../controller/global_controller.dart';
import '../global_components/globals.dart';
import '../home/home_controller.dart';

class FarmHistoryController extends GetxController {
  BuildContext? farmHistoryScreenContext;

  HomeController homeController = Get.find();

  GlobalController globalController = Get.find();

  Globals globals = Globals();

  TabController? tabController;
  var activeTabIndex = 0.obs;

  final PagingController<int, Farm> pendingRecordsController =
      PagingController(firstPageKey: 0);
  final PagingController<int, Farm> submittedRecordsController =
      PagingController(firstPageKey: 0);
  final int _pageSize = 10;

  // INITIALISE

  Future<void> fetchData(
      {required int status,
      required int pageKey,
      required PagingController controller}) async {
    try {
      final data = await globalController.database!.farmDao
          .findFarmByStatusWithLimit(status, _pageSize, pageKey * _pageSize);
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

  confirmDeleteRecord(Farm farm) async {
    globals.primaryConfirmDialog(
        context: farmHistoryScreenContext,
        title: 'Delete Entry',
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
          globalController.database!.farmDao.deleteFarmByUID(farm.uid!);

          pendingRecordsController.itemList!.remove(farm);
          update(['pendingRecordsBuilder']);
        });
  }
}
