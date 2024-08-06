// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../global_components/round_icon_button.dart';
import '../utils/style.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

class InternalInspection extends StatefulWidget {
  const InternalInspection({Key? key}) : super(key: key);

  @override
  State<InternalInspection> createState() => _InternalInspectionState();
}

class _InternalInspectionState extends State<InternalInspection> {
  @override
  void initState() {
    super.initState();
  }

  // void openTwitter() async {
  //   //
  //   String packageName = 'com.afarinick.kumad.cocoamonitor';
  //   bool isTwitterInstalled = await canLaunch(packageName);

  //   if (isTwitterInstalled) {
  //     await launch('package:$packageName');
  //   } else {
  //     // Twitter app is not installed, handle the case accordingly
  //     print('Twitter app is not installed on the device.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
                        bottom: 10,
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
                          child: Text('Internal Inspection',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('coming soon...'),
                        Center(
                            child: ElevatedButton(
                          onPressed: () async {
                            await LaunchApp.openApp(
                                androidPackageName: 'org.koboc.collect.android',
                                // iosUrlScheme: 'pulsesecure://',
                                // appStoreLink: 'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
                                openStore: false);
                          },
                          child: const Text('Tap to launch KoboCollect'),
                        )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
