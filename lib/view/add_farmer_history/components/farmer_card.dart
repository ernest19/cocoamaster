import 'package:cocoa_master/controller/entity/farmer.dart';
import 'package:cocoa_master/controller/entity/society.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/global_controller.dart';
import '../../global_components/round_icon_button.dart';
import '../../utils/style.dart';

class FarmerCard extends StatelessWidget {
  final Farmer farmer;
  final Function? onViewTap;
  final Function? onEditTap;
  final Function? onDeleteTap;
  final bool allowEdit;
  final bool allowDelete;
  const FarmerCard(
      {Key? key,
      required this.farmer,
      this.onViewTap,
      this.onEditTap,
      this.onDeleteTap,
      required this.allowEdit,
      required this.allowDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    GlobalController globalController = Get.find();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppButtonProps.borderRadius),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(2, 41, 10, 0.08),
              blurRadius: 80,
              offset: Offset(0, -4),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${farmer.firstName} ${farmer.lastName}",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColor.black),
                ),
              ),
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              //   decoration: BoxDecoration(
              //       color: AppColor.lightText,
              //       borderRadius: BorderRadius.circular(AppBorderRadius.md)),
              //   child: Text(
              //     farmer.society ?? '',
              //     style: const TextStyle(
              //         fontSize: 13,
              //         fontWeight: FontWeight.w600,
              //         color: Colors.white),
              //   ),
              // ),

              FutureBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      List<Society> dataList = snapshot.data as List<Society>;

                      return Text(
                        dataList.first.societyName ?? '',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      );
                    }
                  }

                  // Displaying LoadingSpinner to indicate waiting state
                  return const Center(
                    child: Text('...'),
                  );
                },
                future: globalController.database!.societyDao
                    .findSocietyBySocietyCode(farmer.society!),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Container(
            height: 2,
            width: width * 0.05,
            color: AppColor.black.withOpacity(0.3),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(farmer.idNumber ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: AppColor.black)),
              const SizedBox(width: 15),
              Text('Cocoa Farms: ${farmer.cocoaFarmNumberCount ?? ''}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: AppColor.black)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: CircleIconButton(
                  icon: appIconEye(color: Colors.white, size: 17),
                  size: 45,
                  backgroundColor: AppColor.primary,
                  onTap: () => onViewTap!(),
                ),
              ),
              if (allowEdit)
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: CircleIconButton(
                    icon: appIconEdit(color: Colors.white, size: 17),
                    size: 45,
                    backgroundColor: AppColor.black,
                    onTap: () => onEditTap!(),
                  ),
                ),
              if (allowDelete)
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: CircleIconButton(
                    icon: appIconTrash(color: Colors.white, size: 17),
                    size: 45,
                    backgroundColor: Colors.red,
                    onTap: () => onDeleteTap!(),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
