// import 'package:cocoa_master/view/saved_area_calculations/saved_area_calculations.dart';
import 'package:cocoa_master/view/utils/style.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/api_interface/user_info_apis.dart';
import '../global_components/round_icon_button.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  Widget buildLisTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Roboto Condensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        tapHandler;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin:
                            EdgeInsets.only(right: appMainHorizontalPadding),
                        child: CircleIconButton(
                            icon: Builder(builder: (context) {
                              return Icon(
                                appIconClose,
                                color: appColorButtonTextBlack,
                                size: 15,
                              );
                            }),
                            backgroundColor: Colors.white,
                            hasShadow: false,
                            onTap: () => Navigator.of(context).pop()),
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: const [
                          Text(
                            'Hello, ',
                            style: TextStyle(fontSize: 14),
                          ),
                          Flexible(
                            child: Text(
                              'User',
                              // "${indexController.userInfo.value.firstName!} ${indexController.userInfo.value.lastName!}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Logout',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      minLeadingWidth: 10,
                      leading: appIconSignOut(color: AppColor.black, size: 25),
                      onTap: () {
                        Navigator.of(context).pop();
                        UserInfoApiInterface().logout();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Build No.1',
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.black,
                      border: Border(
                          top: BorderSide(color: AppColor.primary, width: 3))),
                  child: Column(
                    children: [
                      const Text(
                        "Cocoa Master",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Powered by',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                AppColor.black, BlendMode.plus),
                            child: Image.asset(
                              "assets/images/cocoa_monitor/af_logo.png",
                              fit: BoxFit.contain,
                              height: 80,
                            ),
                          ),
                          Image.asset(
                            "assets/images/cocoa_monitor/cj2.png",
                            fit: BoxFit.contain,
                            height: 80,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '\u00a9 Copyright ${currentYear()}',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  currentYear() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy');
    String year = formatter.format(now);
    return year;
  }

  // shareApp() {
  //   String toShare =
  //       "Download the Cocoa Rehab Monitor App now on Google Play Store : \nhttp://play.google.com/store/apps/details?id=com.afarinick.kumad.cocoamonitor";
  //   Share.share(toShare);
  // }
}
