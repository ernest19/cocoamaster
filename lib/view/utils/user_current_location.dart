import 'package:cocoa_master/view/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ndialog/ndialog.dart';

import '../global_components/custom_button.dart';
// import 'custom_button.dart';

typedef OnLocationEnabledCallback = Function(
    bool? locationEnabled, LocationData? currentPosition);

/// Use the function [getUserLocation] to get the current location
class UserCurrentLocation {
  UserCurrentLocation({@required this.context});

  BuildContext? context;

  // OnLocationEnabledCallback? onLocationEnabled;

  // Location location = Location();
  LocationData? currentPosition;

// ============================================================
// START REQUEST USER LOCATION
// ============================================================
  getUserLocation(
      {bool? forceEnableLocation = false,
      OnLocationEnabledCallback? onLocationEnabled}) async {
    final permission = await getPermissionStatus();
    if (permission == PermissionStatus.authorizedAlways ||
        permission == PermissionStatus.authorizedWhenInUse) {
      currentPosition = await getLocation(
          settings: LocationSettings(useGooglePlayServices: false));
      onLocationEnabled!(true, currentPosition);
    } else {
      if (forceEnableLocation == true) {
        openLocationRequestPopup(context, onLocationEnabled);
      } else {
        onLocationEnabled!(false, currentPosition);
      }
    }

    /*Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    _permissionGranted = await location.hasPermission();
    if (_serviceEnabled && (_permissionGranted == PermissionStatus.granted || _permissionGranted == PermissionStatus.grantedLimited) ) {
      // SET LAT LONG HERE
      currentPosition = await location.getLocation();
      onLocationEnabled!(true, currentPosition);
    }else{
      if (forceEnableLocation == true){
        openLocationRequestPopup(context, onLocationEnabled);
      }else{
        onLocationEnabled!(false, currentPosition);
      }
    }*/
  }
  // ============================================================
  // END REQUEST USER LOCATION
  // ============================================================

  // ============================================================
  // START OPEN LOCATION REQUEST POPUP
  // ============================================================
  openLocationRequestPopup(
      context, OnLocationEnabledCallback? onLocationEnabled) {
    AlertDialog(
      scrollable: true,
      insetPadding: const EdgeInsets.all(20.0),
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.none,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0))),
      content: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 55),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                  child: Column(
                    children: const [
                      Text(
                        'Location Request',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Please enable your location to proceed',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    isFullWidth: true,
                    backgroundColor: Colors.black12,
                    verticalPadding: 0.0,
                    horizontalPadding: 8.0,
                    onTap: () async {
                      Navigator.of(context).pop();

                      final permission = await requestPermission();
                      if (permission == PermissionStatus.authorizedAlways ||
                          permission == PermissionStatus.authorizedWhenInUse) {
                        currentPosition = await getLocation(
                            settings:
                                LocationSettings(useGooglePlayServices: false));
                        onLocationEnabled!(true, currentPosition);
                      } else {
                        openLocationRequestPopup(context, onLocationEnabled);
                      }

                      /*_serviceEnabled = await location.serviceEnabled();
                      if (!_serviceEnabled) {
                        _serviceEnabled = await location.requestService();
                        if (!_serviceEnabled) {
                          return;
                        }
                      }

                      _permissionGranted = await location.hasPermission();
                      if (_permissionGranted == PermissionStatus.denied || _permissionGranted == PermissionStatus.deniedForever) {
                        _permissionGranted = await location.requestPermission();
                        if (_permissionGranted == PermissionStatus.granted || _permissionGranted == PermissionStatus.grantedLimited) {
                          // SET LOCATION DATA HERE
                          currentPosition = await location.getLocation();
                          onLocationEnabled!(true, currentPosition);
                        }else{
                          return;
                        }
                      }else{
                        // SET LOCATION DATA HERE
                        currentPosition = await location.getLocation();
                        onLocationEnabled!(true, currentPosition);
                      }*/
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.black, fontSize: 11),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Positioned(
              top: -40,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.red.shade50,
                child: Icon(
                  appIconMapPin,
                  size: 30,
                  color: Colors.red,
                ),
              )),
        ],
      ),
    ).show(context!,
        dialogTransitionType: DialogTransitionType.Bubble,
        barrierDismissible: false);
  }
// ===========================================
// END OPEN LOCATION REQUEST POPUP
// ==========================================
}
