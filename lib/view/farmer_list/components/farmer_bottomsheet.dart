// ignore_for_file: avoid_print, deprecated_member_use

import 'package:cocoa_master/view/edit_farmer_list/edit_farmer_list_record.dart';
import 'package:cocoa_master/view/global_components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/entity/farmer_from_server.dart';
import '../../utils/style.dart';

class FarmerBottomSheet extends StatelessWidget {
  final FarmerFromServer farmerFromServer;
  const FarmerBottomSheet({Key? key, required this.farmerFromServer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppBorderRadius.md),
              topRight: Radius.circular(AppBorderRadius.md)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 5, //spread radius
              blurRadius: 7, // blur radius
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: 4,
                decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.horizontal),
                      child: const Center(
                        child: Text(
                          'Farmers Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),

                    /*       Center(
                      child: CachedNetworkImage(
                        imageUrl: "${farmerFromServer.image}",
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                          height: size.width * 0.5,
                          width: size.width * 0.5,
                          decoration: BoxDecoration(
                            // shape: BoxShape.rectangle,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            // borderRadius: BorderRadius.circular(AppBorderRadius.md),
                          ),
                        ),
                        placeholder: (context, url) => Image.asset(
                          'assets/images/user_avatar_default.png',
                          fit: BoxFit.cover,
                          height: size.width * 0.5,
                          width: size.width * 0.5,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/user_avatar_default.png',
                          fit: BoxFit.cover,
                          height: size.width * 0.5,
                          width: size.width * 0.5,
                        ),
                      ),
                    ),*/

                    const SizedBox(
                      height: 10.0,
                    ),
                    if (farmerFromServer.farmerFirstName != null)
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        title: const Text(
                          'Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: SelectableText(
                          '${farmerFromServer.farmerFirstName} ${farmerFromServer.farmerLastName}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                          toolbarOptions: const ToolbarOptions(
                            copy: true,
                            selectAll: true,
                          ),
                          showCursor: true,
                          cursorWidth: 2,
                          cursorColor: Colors.red,
                          cursorRadius: const Radius.circular(5),
                        ),
                      ),
                    if (farmerFromServer.farmerCode != null)
                      Divider(
                        indent: AppPadding.horizontal,
                        endIndent: AppPadding.horizontal,
                        height: 0,
                      ),
                    if (farmerFromServer.farmerCode != null)
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        title: const Text(
                          'Farmers ID',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: SelectableText(
                          '${farmerFromServer.farmerCode}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                    if (farmerFromServer.phoneNumber != null)
                      Divider(
                        indent: AppPadding.horizontal,
                        endIndent: AppPadding.horizontal,
                        height: 0,
                      ),
                    if (farmerFromServer.phoneNumber != null)
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        title: const Text(
                          'Farmers Contact',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: SelectableText(
                          '${farmerFromServer.phoneNumber}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                    if (farmerFromServer.societyName != null)
                      Divider(
                        indent: AppPadding.horizontal,
                        endIndent: AppPadding.horizontal,
                        height: 0,
                      ),
                    if (farmerFromServer.societyName != null)
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        title: const Text(
                          'Society',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: SelectableText(
                          '${farmerFromServer.societyName}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                          toolbarOptions: const ToolbarOptions(
                            copy: true,
                            selectAll: true,
                          ),
                          showCursor: true,
                          cursorWidth: 2,
                          cursorColor: Colors.red,
                          cursorRadius: const Radius.circular(5),
                        ),
                      ),
                    if (farmerFromServer.nationalIdNumber != null)
                      Divider(
                        indent: AppPadding.horizontal,
                        endIndent: AppPadding.horizontal,
                        height: 0,
                      ),
                    if (farmerFromServer.nationalIdNumber != null)
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        title: const Text(
                          'ID Number',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: Text(
                          '${farmerFromServer.nationalIdNumber}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                    if (farmerFromServer.numberOfCocoaFarms != null)
                      Divider(
                        indent: AppPadding.horizontal,
                        endIndent: AppPadding.horizontal,
                        height: 0,
                      ),
                    if (farmerFromServer.numberOfCocoaFarms != null)
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        title: const Text(
                          'Number of Cocoa Farms',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: Text(
                          '${farmerFromServer.numberOfCocoaFarms}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                    if (farmerFromServer.numberOfCertifiedCrops != null)
                      Divider(
                        indent: AppPadding.horizontal,
                        endIndent: AppPadding.horizontal,
                        height: 0,
                      ),
                    if (farmerFromServer.numberOfCertifiedCrops != null)
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        title: const Text(
                          'Number of Certified Crops',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: Text(
                          '${farmerFromServer.numberOfCertifiedCrops}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                    if (farmerFromServer.cocoaBagsHarvestedPreviousYear != null)
                      Divider(
                        indent: AppPadding.horizontal,
                        endIndent: AppPadding.horizontal,
                        height: 0,
                      ),
                    if (farmerFromServer.cocoaBagsHarvestedPreviousYear != null)
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        title: const Text(
                          'Cocoa Bags Harvested (Previous Year)',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: Text(
                          '${farmerFromServer.cocoaBagsHarvestedPreviousYear}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                    if (farmerFromServer.cocoaBagsSoldToGroup != null)
                      Divider(
                        indent: AppPadding.horizontal,
                        endIndent: AppPadding.horizontal,
                        height: 0,
                      ),
                    if (farmerFromServer.cocoaBagsSoldToGroup != null)
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        title: const Text(
                          'Cocoa Bags Sold To Group (Previous Year)',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: Text(
                          '${farmerFromServer.cocoaBagsSoldToGroup}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                    if (farmerFromServer.currentYearYieldEstimate != null)
                      Divider(
                        indent: AppPadding.horizontal,
                        endIndent: AppPadding.horizontal,
                        height: 0,
                      ),
                    if (farmerFromServer.currentYearYieldEstimate != null)
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal),
                        title: const Text(
                          'Current Year Yield Estimate',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: Text(
                          '${farmerFromServer.currentYearYieldEstimate}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            CustomButton(
              isFullWidth: true,
              backgroundColor: AppColor.primary,
              verticalPadding: 0.0,
              horizontalPadding: 8.0,
              onTap: () async {
                // if (addFarmerController
                //     .addFarmerFormKey.currentState!
                //     .validate()) {
                //   addFarmerController.handleAddFarmer();
                // } else {
                //   addFarmerController.globals.showSnackBar(
                //       title: 'Alert',
                //       message:
                //           'Kindly provide all required information');
                // }

                Navigator.pop(context);

                Get.to(
                        () => EditFarmerListRecord(
                            farmer: farmerFromServer, isViewMode: false),
                        transition: Transition.fadeIn)
                    ?.then((data) {
                  if (data != null) {
                    var item = data['farmer'];
                    bool submitted = data['submitted'];

                    // final index =
                    //     addFarmerHistoryController
                    //         .pendingRecordsController
                    //         .itemList
                    //         ?.indexWhere((p) =>
                    //             p.uid == item.uid);
                    // if (index != -1) {
                    //   if (submitted) {
                    //     addFarmerHistoryController
                    //         .pendingRecordsController
                    //         .itemList!
                    //         .remove(
                    //             farmer);
                    //     addFarmerHistoryController
                    //         .update([
                    //       'pendingRecordsBuilder'
                    //     ]);
                    //     addFarmerHistoryController
                    //         .submittedRecordsController
                    //         .refresh();
                    //   } else {
                    //     addFarmerHistoryController
                    //         .pendingRecordsController
                    //         .itemList![index!] = item;
                    //     addFarmerHistoryController
                    //         .update([
                    //       'pendingRecordsBuilder'
                    //     ]);
                    //   }
                    // }
                  }
                });
              },
              child: Text(
                'Edit',
                style: TextStyle(color: AppColor.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
