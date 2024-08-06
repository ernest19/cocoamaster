import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../controller/entity/farmer_from_server.dart';
import '../../controller/global_controller.dart';
import '../global_components/globals.dart';
import '../home/home_controller.dart';
import '../utils/style.dart';
import 'components/farmer_bottomsheet.dart';

class FarmerListController extends GetxController {
  BuildContext? farmerListScreenContext;

  HomeController homeController = Get.find();

  GlobalController globalController = Get.find();

  Globals globals = Globals();

  // PersonnelAssignmentApiInterface personnelAssignmentApiInterface =
  //     PersonnelAssignmentApiInterface();

  TextEditingController? searchTC = TextEditingController();

  final farmerRepository = Get.put(FarmerRepository());

  // TabController? tabController;
  // var activeTabIndex = 0.obs;

  final PagingController<int, FarmerFromServer> pagingController =
      PagingController(firstPageKey: 0);
  final int _pageSize = 10;

  // INITIALISE

  Future<void> fetchData(
      {required String searchTerm,
      required int pageKey,
      required PagingController controller}) async {
    try {
      final data = searchTerm.trim().isEmpty
          ? await globalController.database!.farmerFromServerDao
              .findFarmersFromServerWithLimit(_pageSize, pageKey * _pageSize)
          : await globalController.database!.farmerFromServerDao
              .findFarmersFromServerWithSearchAndLimit(
                  "%${searchTerm.trim()}%".toLowerCase(),
                  _pageSize,
                  pageKey * _pageSize);
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

  viewFarmer(FarmerFromServer farmerFromServer) {
    showModalBottomSheet<void>(
      elevation: 5,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppBorderRadius.md),
        ),
      ),
      context: farmerListScreenContext!,
      builder: (context) {
        return FarmerBottomSheet(farmerFromServer: farmerFromServer);
      },
    );
  }
}

class FarmerRepository {
  GlobalController globalController = Get.find();
  final _farmerFromServerList = RxList<FarmerFromServer>();
  final _filteredFarmerList = RxList<FarmerFromServer>();

  List<FarmerFromServer> get farmerFromServerList => _filteredFarmerList;

  Future<void> initializeData() async {
    final farmerData = await globalController.database!.farmerFromServerDao
        .findAllFarmersFromServer();
    _farmerFromServerList.addAll(farmerData);
    _filteredFarmerList.addAll(farmerData);
  }

  void search(String farmerName) {
    final filteredList = _farmerFromServerList
        .where((farmerFromServer) =>
            farmerFromServer.farmerFullName!
                .toLowerCase()
                .contains(farmerName.toLowerCase()) ||
            farmerFromServer.societyName!
                .toLowerCase()
                .contains(farmerName.toLowerCase()))
        .toList();
    _filteredFarmerList.clear();
    _filteredFarmerList.addAll(filteredList);
  }
}
