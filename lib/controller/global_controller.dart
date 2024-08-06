
import 'package:get/get.dart';

import 'api_interface/user_info_apis.dart';
import 'database/database.dart';
import 'model/cm_user.dart';


// import 'model/cm_user.dart';

class GlobalController extends GetxController{

  UserInfoApiInterface userInfoApiInterface = UserInfoApiInterface();
  // String serverUrl = 'https://cocoarehabmonitor.com';
  String serverUrl = 'https://cj.cocoarehabmonitor.com';

  late final AppDatabase? database;

 // Rx<UserInfo> userInfo = UserInfo().obs;
  Rx<CmUser> userInfo = CmUser().obs;
  RxBool userIsLoggedIn = false.obs;


  
 


  buildAppDB() async{
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }



  loadUserInfo() async{
    userIsLoggedIn.value = await userInfoApiInterface.userIsLoggedIn() ?? false;
    if (userIsLoggedIn.value == true){
      userInfo.value = await userInfoApiInterface.retrieveUserInfoFromSharedPrefs();
    }
  }
 clearSavedTimestamp() async {
    await userInfoApiInterface.clearTimestamp();
  }
  // checkFirstLaunch() async {
  //   await userInfoApiInterface.checkFirstLaunch();
  // }

}