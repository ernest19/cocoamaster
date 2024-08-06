// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cocoa_master/controller/api_interface/user_info_apis.dart';
import 'package:cocoa_master/controller/global_controller.dart';
import 'package:cocoa_master/view/global_components/globals.dart';
import 'package:cocoa_master/view/utils/view_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  // ResetPasswordController loginController = Get.put(ResetPasswordController());
  // IndexController indexController = Get.put(IndexController());
  // TMTIndexController tmtIndexController = Get.put(TMTIndexController());
//  LoginController loginController = Get.find();
  GlobalController indexController = Get.find();

  // final auth = FirebaseAuth.instance;
  Globals globals = Globals();
  UserInfoApiInterface userInfoApiInterface = UserInfoApiInterface();

  final resetFormKey = GlobalKey<FormState>();
  var telephoneTextController = TextEditingController(text: "");
  var passwordTextController = TextEditingController(text: "");
  var passwordConfirmTextController = TextEditingController(text: "");

  var otpVerificationID;

  var gender = Gender.none.obs;
  // bool _value = false;
  // int genderVal = -1.obs;

  var resetScreenContext;
  // var firstName, lastName, username, phoneNumber;

  /// ==============================================================================
  /// START CHANGE PASSWORD
  /// ==============================================================================
  changePassword() async {
    globals.startWait(resetScreenContext);
    var resetStatus = await userInfoApiInterface.changePassword({
      'telephone': telephoneTextController.text.trim(),
      'oldpassword': passwordTextController.text.trim(),
      'newpassword': passwordConfirmTextController.text.trim(),
    });
    globals.endWait(resetScreenContext);

    if (resetStatus['connectionAvailable'] == true) {
      if (resetStatus['status'] == 1) {
        var token = resetStatus['token'];
        globals.startWait(resetScreenContext);
        // var userData = await userInfoApiInterface.getUserInfo(token);
        globals.endWait(resetScreenContext);

        // if (userData['status'] == true &&
        //     userData['connectionAvailable'] == true) {
        //   await userInfoApiInterface
        //       .saveUserDataToSharedPrefs(userData['userInfo']);
        // indexController.userInfo.value =
        //     await userInfoApiInterface.retrieveUserInfoFromSharedPrefs();
        // indexController.userIsLoggedIn.value = true;
        globals
            .showToast(resetStatus['message'] ?? 'Password reset successfully');

        // Navigator.of(registerScreenContext)
        //     .pushNamedAndRemoveUntil(route.trackMyTreeIndex, (Route<dynamic> route) => false);
        int count = 0;
        Navigator.of(resetScreenContext).popUntil((_) => count++ >= 1);
        // } else {
        //   globals.showToast('Password reset successful, login to continue');
        // }
      } else {
        globals.showToast(resetStatus['message']);
      }
    } else {
      globals.showToast("Check your internet connection");
    }
  }
// ==============================================================================
// END CHANGE PASSWORD
// ==============================================================================
}
