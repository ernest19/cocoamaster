import 'package:cocoa_master/view/widgets/main_drawer.dart';
import 'package:cocoa_master/view/global_components/round_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:transparent_image/transparent_image.dart';

// import 'adaptive_progress_indicator.dart';
import '../../controller/global_controller.dart';
import '../add_dm_fund_request/add_dm_fund_request.dart';
import '../farmer_list/farmer_list.dart';
import '../internal_inspection/internal_inspection.dart';
import 'components/farmer_options_bottomsheet.dart';
import 'components/map_farms_options_bottomsheet.dart';
import 'home_controller.dart';
import 'package:cocoa_master/view/utils/style.dart';

import 'components/menu_card2.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  GlobalController globalController = Get.put(GlobalController());

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    homeController.homeScreenContext = context;

    String hexColor = "#895937";
    String hexColor2 = "#f0ded0";
    Color nudeBrown =
        Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
    Color nudeBrown2 =
        Color(int.parse(hexColor2.substring(1, 7), radix: 16) + 0xFF000000);

    return Material(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor:
              const Color.fromARGB(255, 246, 219, 251).withOpacity(0.1),
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: nudeBrown2,
          key: homeController.scaffoldKey,
          drawer: const MainDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: const BorderRadius.only(
                      // bottomLeft: Radius.circular(AppBorderRadius.md),
                      bottomRight: Radius.circular(55)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.1), //color of shadow
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 15,
                      bottom: 10,
                      left: AppPadding.horizontal,
                      right: AppPadding.horizontal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RoundedIconButton(
                            icon: appIconMenu(color: nudeBrown, size: 17),
                            size: 45,
                            backgroundColor: AppColor.white,
                            onTap: () => homeController
                                .scaffoldKey.currentState!
                                .openDrawer(),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: homeController.syncData,
                                child: Container(
                                  height: 45,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: nudeBrown,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "Sync",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              // const SizedBox(width: 20),
                              /* Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  CircleIconButton(
                                    icon: appIconBell(
                                        color: AppColor.white, size: 20),
                                    size: 45,
                                    backgroundColor: nudeBrown,
                                    hasShadow: false,
                                    // onTap: () => Get.to(() => const Notifications(),
                                    //     transition: Transition.fadeIn),
                                  ),
                                  // GetBuilder(
                                  //     init: homeController,
                                  //     builder: (context) {
                                  //       return notificationStream(globalController);
                                  //     })
                                ],
                              ),*/
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: AppPadding.sectionDividerSpace),
                      Text('Welcome',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColor.black)),
                      const SizedBox(height: 5),
                      Text(
                        '${globalController.userInfo.value.firstName} - ${globalController.userInfo.value.district}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  // padding: const EdgeInsets.only(bottom: 50, top: 10),
                  // padding: EdgeInsets.only(left: AppPadding.horizontal, right: AppPadding.horizontal, bottom: 50, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Padding(
                        padding: EdgeInsets.all(AppPadding.horizontal),
                        child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(AppBorderRadius.md)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple
                                      .withOpacity(0.1), //color of shadow
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                            ),
                            child: TileButtonDetached(
                              icon:
                                  appIconRuler(color: Colors.purple, size: 120),
                              onTap: () =>
                                  homeController.usePolygonDrawingTool(),
                            )),
                      ),*/
                      SizedBox(height: AppPadding.sectionDividerSpace),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        child: MenuCard2(
                          image:
                              'assets/images/cocoa_monitor/new_log_entry.png',
                          label: 'Register Farmer',
                          onTap: () => homeController.showMenuOptions(
                              const FarmerMenuOptionsBottomSheet()),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        child: MenuCard2(
                          image:
                              'assets/images/cocoa_monitor/new_log_entry.png',
                          label: 'Map Farms',
                          onTap: () => homeController.showMenuOptions(
                              const MapFarmsMenuOptionsBottomSheet()),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: AppPadding.horizontal),
                      //   child: MenuCard2(
                      //     image: 'assets/images/cocoa_monitor/cocoa.png',
                      //     label: 'Calculated Areas',
                      //     onTap: () {
                      //       Get.to(() => const SavedAreaCalculations(),
                      //           transition: Transition.fadeIn);
                      //     },
                      //   ),
                      // ),
                      // SizedBox(height: AppPadding.sectionDividerSpace),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        child: MenuCard2(
                          image:
                              'assets/images/cocoa_monitor/new_log_entry.png',
                          label: 'Farmer List',
                          onTap: () => Get.to(() => const FarmerList(),
                              transition: Transition.fadeIn),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        child: MenuCard2(
                          image:
                              'assets/images/cocoa_monitor/new_log_entry.png',
                          label: 'Internal Inspection',
                          onTap: () => Get.to(() => const InternalInspection(),
                              transition: Transition.fadeIn),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        child: MenuCard2(
                          image:
                              'assets/images/cocoa_monitor/new_log_entry.png',
                          label: 'DM Fund Request',
                          onTap: () => Get.to(() => const DMFundRequest(),
                              transition: Transition.fadeIn),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: AppPadding.horizontal),
                      //   child: MenuCard2(
                      //       image: 'assets/images/cocoa_monitor/binoculars.png',
                      //       label: 'Registered Farms',
                      //       onTap: () {}),
                      // ),
                      // SizedBox(height: AppPadding.sectionDividerSpace),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
