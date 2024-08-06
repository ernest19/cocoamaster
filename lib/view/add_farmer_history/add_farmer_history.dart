import 'package:cocoa_master/controller/entity/farmer.dart';
import 'package:cocoa_master/view/add_farmer_history/components/farmer_card.dart';
import 'package:cocoa_master/view/edit_farmer_record/edit_farmer_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../controller/global_controller.dart';
import '../global_components/round_icon_button.dart';
import '../utils/constants.dart';
import '../utils/style.dart';
import 'add_farmer_history_controller.dart';

class AddFarmerHistory extends StatefulWidget {
  const AddFarmerHistory({Key? key}) : super(key: key);

  @override
  State<AddFarmerHistory> createState() => _AddFarmerHistoryState();
}

class _AddFarmerHistoryState extends State<AddFarmerHistory>
    with SingleTickerProviderStateMixin {
  AddFarmerHistoryController addFarmerHistoryController =
      Get.put(AddFarmerHistoryController());
  GlobalController globalController = Get.find();

  @override
  void initState() {
    addFarmerHistoryController.pendingRecordsController
        .addPageRequestListener((pageKey) {
      addFarmerHistoryController.fetchData(
          status: SubmissionStatus.pending,
          pageKey: pageKey,
          controller: addFarmerHistoryController.pendingRecordsController);
    });

    addFarmerHistoryController.submittedRecordsController
        .addPageRequestListener((pageKey) {
      addFarmerHistoryController.fetchData(
          status: SubmissionStatus.submitted,
          pageKey: pageKey,
          controller: addFarmerHistoryController.submittedRecordsController);
    });

    addFarmerHistoryController.tabController =
        TabController(length: 2, vsync: this);
    addFarmerHistoryController.tabController!.addListener(() {
      addFarmerHistoryController.activeTabIndex.value =
          addFarmerHistoryController.tabController!.index;
    });
    super.initState();
  }

  @override
  void dispose() {
    addFarmerHistoryController.pendingRecordsController.dispose();
    addFarmerHistoryController.submittedRecordsController.dispose();
    addFarmerHistoryController.tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    addFarmerHistoryController.addFarmHistoryScreenContext = context;

    return Material(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColor.lightBackground,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: AppColor.lightBackground,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // decoration: BoxDecoration(
                  //   border: Border(bottom: BorderSide(color: AppColor.lightText.withOpacity(0.5)))
                  // ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 15,
                        left: AppPadding.horizontal,
                        right: AppPadding.horizontal),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoundedIconButton(
                          icon: appIconBack(color: AppColor.black, size: 25),
                          size: 45,
                          backgroundColor: Colors.transparent,
                          onTap: () => Get.back(),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text('Farmer Registration History',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black)),
                        ),
                      ],
                    ),
                  ),
                ),

                // SizedBox(height: 8),

                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppColor.lightText.withOpacity(0.5)))),
                  child: Obx(
                    () => TabBar(
                      onTap: (index) {
                        addFarmerHistoryController.activeTabIndex.value = index;
                      },
                      labelColor: AppColor.black,
                      unselectedLabelColor: Colors.black87,
                      indicatorSize: TabBarIndicatorSize.label,
                      // indicator: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(AppBorderRadius.xl),
                      //     color: AppColor.primary
                      // ),
                      indicator: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                              bottom: BorderSide(
                                  width: 3.0, color: AppColor.primary))),
                      controller: addFarmerHistoryController.tabController,
                      tabs: [
                        Tab(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Submitted',
                              style: TextStyle(
                                  fontWeight: addFarmerHistoryController
                                              .activeTabIndex.value ==
                                          0
                                      ? FontWeight.bold
                                      : FontWeight.w400),
                            ),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                  fontWeight: addFarmerHistoryController
                                              .activeTabIndex.value ==
                                          1
                                      ? FontWeight.bold
                                      : FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: TabBarView(
                    controller: addFarmerHistoryController.tabController,
                    children: [
                      GetBuilder(
                          init: addFarmerHistoryController,
                          builder: (ctx) {
                            return PagedListView<int, Farmer>(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 20, top: 15),
                              pagingController: addFarmerHistoryController
                                  .submittedRecordsController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<Farmer>(
                                itemBuilder:
                                    (context, farmer, index) {
                                  return FarmerCard(
                                    farmer: farmer,
                                    onViewTap: () => Get.to(
                                        () => EditFarmerRecord(
                                            farmer: farmer,
                                            isViewMode: true),
                                        transition: Transition.fadeIn),
                                    onEditTap: () => Get.to(
                                        () => EditFarmerRecord(
                                            farmer: farmer,
                                            isViewMode: false),
                                        transition: Transition.fadeIn),
                                    onDeleteTap: () =>
                                        addFarmerHistoryController
                                            .confirmDeleteMonitoring(
                                                farmer),
                                    allowDelete: false,
                                    allowEdit: false,
                                  );
                                },
                                noItemsFoundIndicatorBuilder: (context) =>
                                    Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.horizontal),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 50),
                                      Image.asset(
                                        'assets/images/cocoa_monitor/empty-box.png',
                                        width: 60,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "No data found",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 13),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      GetBuilder(
                          init: addFarmerHistoryController,
                          id: 'pendingRecordsBuilder',
                          builder: (ctx) {
                            return PagedListView<int, Farmer>(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 20, top: 15),
                              pagingController: addFarmerHistoryController
                                  .pendingRecordsController,
                              builderDelegate: PagedChildBuilderDelegate<
                                      Farmer>(
                                  itemBuilder:
                                      (context, farmer, index) {
                                    return FarmerCard(
                                      farmer: farmer,
                                      onViewTap: () => Get.to(
                                          () => EditFarmerRecord(
                                              farmer: farmer,
                                              isViewMode: true),
                                          transition: Transition.fadeIn),
                                      onEditTap: () {
                                        Get.to(
                                                () => EditFarmerRecord(
                                                    farmer:
                                                        farmer,
                                                    isViewMode: false),
                                                transition: Transition.fadeIn)
                                            ?.then((data) {
                                          if (data != null) {
                                            var item =
                                                data['farmer'];
                                            bool submitted = data['submitted'];

                                            final index =
                                                addFarmerHistoryController
                                                    .pendingRecordsController
                                                    .itemList
                                                    ?.indexWhere((p) =>
                                                        p.uid == item.uid);
                                            if (index != -1) {
                                              if (submitted) {
                                                addFarmerHistoryController
                                                    .pendingRecordsController
                                                    .itemList!
                                                    .remove(
                                                        farmer);
                                                addFarmerHistoryController
                                                    .update([
                                                  'pendingRecordsBuilder'
                                                ]);
                                                addFarmerHistoryController
                                                    .submittedRecordsController
                                                    .refresh();
                                              } else {
                                                addFarmerHistoryController
                                                    .pendingRecordsController
                                                    .itemList![index!] = item;
                                                addFarmerHistoryController
                                                    .update([
                                                  'pendingRecordsBuilder'
                                                ]);
                                              }
                                            }
                                          }
                                        });
                                      },
                                      onDeleteTap: () =>
                                          addFarmerHistoryController
                                              .confirmDeleteMonitoring(
                                                  farmer),
                                      allowDelete: true,
                                      allowEdit: true,
                                    );
                                  },
                                  noItemsFoundIndicatorBuilder: (context) =>
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppPadding.horizontal),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 50),
                                            Image.asset(
                                              'assets/images/cocoa_monitor/empty-box.png',
                                              width: 60,
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              "No data found",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 13),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      )),
                            );
                          }),
                    ],
                  ),
                ),

                /*GetBuilder(
                    init: contractorCertificateHistoryController,
                    builder: (context) {
                      return Expanded(
                        child: TabBarView(
                          controller: contractorCertificateHistoryController.tabController,
                          children: [

                            personnelStream(globalController, contractorCertificateHistoryController, SubmissionStatus.submitted),

                            personnelStream(globalController, contractorCertificateHistoryController, SubmissionStatus.pending),

                          ],
                        ),
                      );
                    }
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget personnelStream(GlobalController globalController,
      addFarmerHistoryController, int status) {
    final farmerDao = globalController.database!.farmerDao;
    return StreamBuilder<List<Farmer>>(
      stream: farmerDao.findFarmerByStatusStream(status),
      builder: (BuildContext context, AsyncSnapshot<List<Farmer>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Image.asset('assets/gif/loading2.gif', height: 60),
          );
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Oops.. Something went wrong'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 85),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 10,),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Farmer farmer = snapshot.data![index];
                        return FarmerCard(
                          farmer: farmer,
                          onViewTap: () => Get.to(
                              () => EditFarmerRecord(
                                  farmer: farmer, isViewMode: true),
                              transition: Transition.fadeIn),
                          onEditTap: () => Get.to(
                              () => EditFarmerRecord(
                                  farmer: farmer, isViewMode: false),
                              transition: Transition.fadeIn),
                          onDeleteTap: () => addFarmerHistoryController
                              .confirmDeleteMonitoring(farmer),
                          allowDelete: status != SubmissionStatus.submitted,
                          allowEdit: status != SubmissionStatus.submitted,
                          // allowDelete: status == SubmissionStatus.submitted,
                          // allowEdit: status == SubmissionStatus.submitted,
                        );
                      }),
                ],
              ),
            );
          } else {
            return Center(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppPadding.horizontal),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      'assets/images/cocoa_monitor/empty-box.png',
                      width: 80,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "There is nothing to display here",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          return Center(
            child: Image.asset('assets/gif/loading2.gif', height: 60),
          );
        }
      },
    );
  }
}
