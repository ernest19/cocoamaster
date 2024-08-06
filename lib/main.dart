import 'package:cocoa_master/view/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/global_controller.dart';
import 'firebase_options.dart';
import 'package:cocoa_master/view/routes.dart' as route;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  GlobalController indexController = Get.put(GlobalController());
  await indexController.buildAppDB();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  ShareP.preferences = sharedPreferences;
  await indexController.loadUserInfo();
  await indexController.clearSavedTimestamp();
  // await indexController.checkFirstLaunch();
  


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final MaterialColor customBrown = const MaterialColor(
    0xFF795548,
    <int, Color>{
      50: Color(0xFFFBE9E7),
      100: Color(0xFFFFCCBC),
      200: Color(0xFFFFAB91),
      300: Color(0xFFFF8A65),
      400: Color(0xFFFF7043),
      500: Color(0xFF795548), // Use Colors.brown[500] here
      600: Color(0xFF6D4C41),
      700: Color(0xFF5D4037),
      800: Color(0xFF4E342E),
      900: Color(0xFF3E2723),
    },
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cocoa Master',
      theme: ThemeData(
        primarySwatch: customBrown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: route.splashScreen,
      onGenerateRoute: route.controller,
      // home: const Home(),
    );
  }
}
