import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

import '../controller/api_interface/user_info_apis.dart';
import 'auth/login/login.dart';
import 'home/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // late Animation<Alignment> _topAnimation;
  late Animation<Offset> _leftAnimation;
  late Animation<Offset> _rightAnimation;
  late Animation<double> _animation;

  UserInfoApiInterface userInfoApiInterface = UserInfoApiInterface();
  DateTime now = DateTime.now();

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  void navigationPage() async {
    var userIsLoggedIn = await userInfoApiInterface.userIsLoggedIn() ?? false;

    if (userIsLoggedIn == true) {
      // Get.offAll(() => Index());
      Get.offAll(() => const Home(), arguments: {});
    } else {
      Get.offAll(() => const Login());
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // _topAnimation = Tween<Alignment>(
    //   begin: const Alignment(-0.0, -1), // Start off the screen
    //   end: const Alignment(-0.0, -0.5),
    // ).animate(_animationController);

    _leftAnimation = Tween<Offset>(
      begin: const Offset(-2.0, 4.6),
      end: const Offset(-0.45, 4.6),
    ).animate(_animationController);

    _rightAnimation = Tween<Offset>(
      begin: const Offset(1.0, 3.65),
      end: const Offset(0.4, 3.65),
    ).animate(_animationController);

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(223, 187, 134, 1.0),
          ),
          Image.asset(
            "assets/images/cocoa_monitor/imc2.png",
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height,
          ),
          Align(
            alignment: const Alignment(-0.0, -0.5),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, child) {
                return Opacity(
                  opacity: _animation.value,
                  child: Text(
                    "Cocoa Master",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 40,
                      color: Colors.brown[900],
                    ),
                  ),
                );
              },
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 600,
            child: Center(
              child: Text(
                'POWERED BY',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Align(
            // alignment: Alignment.center,
            // (-0.3, 0.7), // Align to the bottom left
            child: SlideTransition(
              position: _leftAnimation,
              child: Image.asset(
                "assets/images/cocoa_monitor/af_logo.png",
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
          ),
          Align(
            // alignment: Alignment.center, // Align to the bottom right
            child: SlideTransition(
              position: _rightAnimation,
              child: Image.asset(
                "assets/images/cocoa_monitor/cj2.png",
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.width * 0.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'dart:async';
// import 'dart:ui';

// import 'package:cocoa_master/view/utils/style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:get/get.dart';

// class Splash extends StatefulWidget {
//   const Splash({Key? key}) : super(key: key);

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash>  with SingleTickerProviderStateMixin {
//   // UserInfoApiInterface userInfoApiInterface = UserInfoApiInterface();
//   // DateTime now = DateTime.now();

//   // startTime() async {
//   //   var duration = const Duration(seconds: 2);
//   //   return Timer(duration, navigationPage);
//   // }

//   // void navigationPage() async {
//   //   var userIsLoggedIn = await userInfoApiInterface.userIsLoggedIn() ?? false;

//   //   if (userIsLoggedIn == true) {
//   //     // Get.offAll(() => Index());
//   //     Get.offAll(() => const Home(), arguments: {});
//   //   } else {
//   //     Get.offAll(() => const Login());
//   //   }

//   // }


//   late AnimationController _animationController;
//   late Animation<Alignment> _topAnimation;
//   late Animation<Offset> _leftAnimation;
//   late Animation<Offset> _rightAnimation;

//   @override
//   void initState() {
//     super.initState();
//     // startTime();
//     _animationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     _topAnimation = Tween<Alignment>(
//       begin: const Alignment(-1, -1), // Start off the screen
//       end: const Alignment(-0.0, -0.1),
//     ).animate(_animationController);

//     _leftAnimation = Tween<Offset>(
//       begin: const Offset(-1.0, 0.0),
//       end: const Offset(-0.6, 0.0),
//     ).animate(_animationController);

//     _rightAnimation = Tween<Offset>(
//       begin: const Offset(1.0, 0.0),
//       end: const Offset(0.6, 0.0),
//     ).animate(_animationController);

//     _animationController.forward();
//   }

//    @override
// //   void dispose() {
// //     _animationController.dispose();
// //     super.dispose();
// //   }

//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     //   statusBarColor: Colors.white,
//     //   statusBarBrightness: Brightness.dark,
//     //   statusBarIconBrightness: Brightness.dark,
//     // ));

//     return Material(
//       child: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//           statusBarColor: AppColor.lightBackground,
//           statusBarIconBrightness: Brightness.dark,
//           systemNavigationBarColor: Colors.white,
//           systemNavigationBarIconBrightness: Brightness.dark,
//         ),
//         child: Scaffold(
//           backgroundColor: AppColor.lightBackground,
//           body: Stack(
//             children: [
//               // Positioned(
//               //   bottom: 0,
//               //   right: 0,
//               //   left: 0,
//               //   child: Image.asset("assets/images/cocoa_monitor/cocoa_beans.jpg"),
//               // ),

//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 left: 0,
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * 0.05,
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage(
//                             'assets/images/cocoa_monitor/cacao_beans.jpg',
//                           ),
//                           fit: BoxFit.cover)),
//                 ),
//               ),

//               BackdropFilter(
//                 // filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//                 filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
//                 child: SizedBox(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Expanded(
//                           child: SizedBox(
//                             height: 0,
//                           ),
//                         ),
//                         Expanded(
//                           // flex: 2,
//                           child: Align(f
//                               alignment: Alignment.bottomCenter,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(bottom: 10.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Hero(
//                                       tag: "welcomeHero",
//                                       child: Image.asset(
//                                         "assets/images/cocoa_monitor/cocoa_monitor.png",
//                                         fit: BoxFit.contain,
//                                         height:
//                                             MediaQuery.of(context).size.width *
//                                                 0.2,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Text(
//                                       "Cocoa Rehab Monitor",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w900,
//                                           fontSize: 25,
//                                           color: AppColor.black),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                         ),
//                         Expanded(
//                           // child: Container(),
//                           child: Align(
//                               alignment: FractionalOffset.bottomCenter,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(bottom: 0.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     const SizedBox(
//                                       height: 6,
//                                     ),
//                                     const Text(
//                                       'POWERED BY',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                           color: Colors.black54),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Image.asset(
//                                           "assets/images/cocoa_monitor/af_logo.png",
//                                           fit: BoxFit.contain,
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.2,
//                                         ),
//                                         const SizedBox(width: 10),
//                                         Image.asset(
//                                           "assets/images/cocoa_monitor/cj2.png",
//                                           fit: BoxFit.contain,
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.25,
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.07),
//                                     // Text(
//                                     //   'Copyright \u00a9 ${now.year}',
//                                     //   style: TextStyle(
//                                     //       fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black),
//                                     // ),
//                                   ],
//                                 ),
//                               )),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
