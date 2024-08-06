// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../controller/entity/farmer_from_server.dart';
import '../../utils/style.dart';

class RAListCard extends StatelessWidget {
  final FarmerFromServer farmerFromServer;
  final Function? onTap;
  const RAListCard({Key? key, required this.farmerFromServer, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;

    // GlobalController globalController = Get.find();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap!();
      },
      child: Container(
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
        child: Row(
          children: [
            /*   CachedNetworkImage(
              imageUrl: "${farmerFromServer.image}",
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) => Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  // borderRadius: BorderRadius.circular(AppBorderRadius.md),
                ),
              ),
              placeholder: (context, url) => Image.asset(
                'assets/images/user_avatar_default.png',
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/user_avatar_default.png',
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
            ),*/
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    '${farmerFromServer.farmerFirstName} ${farmerFromServer.farmerLastName}',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColor.black),
                    toolbarOptions: const ToolbarOptions(
                      copy: true,
                      selectAll: true,
                    ),
                    showCursor: true,
                    cursorWidth: 2,
                    cursorColor: Colors.red,
                    cursorRadius: const Radius.circular(5),
                  ),
                  const SizedBox(height: 2),
                  SelectableText(
                    '${farmerFromServer.farmerCode}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: AppColor.black),
                    toolbarOptions: const ToolbarOptions(
                      copy: true,
                      selectAll: true,
                    ),
                    showCursor: true,
                    cursorWidth: 2,
                    cursorColor: Colors.red,
                    cursorRadius: const Radius.circular(5),
                  ),
                  // if (rehabAssistant.designation != null &&
                  // rehabAssistant.designation != "")
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                        color:
                            // rehabAssistant.designation ==
                            //         PersonnelDesignation.rehabAssistant
                            // ?
                            AppColor.primary
                        // : AppColor.black
                        ,
                        borderRadius:
                            BorderRadius.circular(AppBorderRadius.sm)),
                    child: Text(
                      '${farmerFromServer.societyName}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: AppColor.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
