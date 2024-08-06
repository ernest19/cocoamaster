import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../controller/entity/farmer_from_server.dart';
import '../../controller/global_controller.dart';
import '../global_components/round_icon_button.dart';
import '../global_components/text_input_decoration.dart';
import '../utils/style.dart';
import 'components/farmer_list_card.dart';
import 'farmer_list_controller.dart';

class FarmerList extends StatefulWidget {
  const FarmerList({Key? key}) : super(key: key);

  @override
  State<FarmerList> createState() => _FarmerListState();
}

class _FarmerListState extends State<FarmerList>
    with SingleTickerProviderStateMixin {
  FarmerListController farmerListController = Get.put(FarmerListController());
  GlobalController globalController = Get.find();

  @override
  void initState() {
    farmerListController.pagingController.addPageRequestListener((pageKey) {
      farmerListController.fetchData(
          searchTerm: farmerListController.searchTC!.text,
          pageKey: pageKey,
          controller: farmerListController.pagingController);
    });
    // raListController.rehabAssistantRepository.initializeData();
    super.initState();
  }

  @override
  void dispose() {
    farmerListController.pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    farmerListController.farmerListScreenContext = context;

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
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppColor.lightText.withOpacity(0.5)))),
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
                          child: Text('Farmer List',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextFormField(
                    controller: farmerListController.searchTC,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      enabledBorder: inputBorder,
                      focusedBorder: inputBorderFocused,
                      errorBorder: inputBorder,
                      focusedErrorBorder: inputBorderFocused,
                      filled: true,
                      fillColor: AppColor.white,
                      hintText: 'Search name or society name',
                      hintStyle:
                          TextStyle(color: AppColor.lightText, fontSize: 13),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child:
                            appIconSearch(color: AppColor.lightText, size: 15),
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    // onChanged: (val){
                    //   raListController.update();
                    // },
                    onChanged: (value) {
                      farmerListController.pagingController.refresh();
                      // raListController.rehabAssistantRepository.search(value);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: GetBuilder(
                      init: farmerListController,
                      builder: (ctx) {
                        return PagedListView<int, FarmerFromServer>(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 20, top: 15),
                          pagingController:
                              farmerListController.pagingController,
                          builderDelegate:
                              PagedChildBuilderDelegate<FarmerFromServer>(
                                  itemBuilder:
                                      (context, rehabAssistant, index) {
                                    return RAListCard(
                                      farmerFromServer: rehabAssistant,
                                      onTap: () {
                                        debugPrint(
                                            "Selected farmer from list ${rehabAssistant.farmerId} and ${rehabAssistant.id}");

                                        FocusScope.of(context).unfocus();

                                        farmerListController
                                            .viewFarmer(rehabAssistant);
                                      },
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
                ),

                /*Expanded(
                  child: Obx(
                        () {
                      final rehabAssistantList = raListController.rehabAssistantRepository.rehabAssistantList;

                      if (rehabAssistantList.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontal),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50),
                                Image.asset(
                                  'assets/images/cocoa_monitor/empty-box.png',
                                  width: 60,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "No data found",
                                  style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 13),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 5),
                        itemCount: rehabAssistantList.length,
                        itemBuilder: (context, index) {
                          final rehabAssistant = rehabAssistantList[index];
                          return RAListCard(
                            rehabAssistant: rehabAssistant,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              raListController.viewRA(rehabAssistant);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
