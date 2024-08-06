import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/entity/farm.dart';
import '../../controller/entity/farmer_from_server.dart';
import '../../controller/entity/society.dart';
import '../../controller/global_controller.dart';
import '../global_components/custom_button.dart';
import '../global_components/round_icon_button.dart';
import '../global_components/text_input_decoration.dart';
import '../utils/style.dart';
import 'edit_farm_controller.dart';

class EditFarm extends StatefulWidget {
  final Farm farm;
  final bool isViewMode;
  const EditFarm({Key? key, required this.farm, required this.isViewMode})
      : super(key: key);

  @override
  State<EditFarm> createState() => _EditFarmState();
}

class _EditFarmState extends State<EditFarm> {
  EditOutbreakFarmController editFarmController =
      Get.put(EditOutbreakFarmController());
  GlobalController globalController = Get.find();

  @override
  void initState() {
    super.initState();

    editFarmController.farm = widget.farm;
  }

  @override
  Widget build(BuildContext context) {
    editFarmController.editFarmScreenContext = context;

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
                          child: Text(
                              widget.isViewMode
                                  ? 'View Map Farm'
                                  : 'Edit Map Farm',
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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        left: AppPadding.horizontal,
                        right: AppPadding.horizontal,
                        bottom: AppPadding.vertical,
                        top: 10),
                    child: Column(
                      children: [
                        AbsorbPointer(
                          absorbing: widget.isViewMode,
                          child: GetBuilder(
                              init: editFarmController,
                              builder: (ctx) {
                                return Form(
                                  key: editFarmController.formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Society',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      DropdownSearch<Society>(
                                        popupProps: PopupProps.modalBottomSheet(
                                            showSelectedItems: true,
                                            showSearchBox: true,
                                            itemBuilder:
                                                (context, item, selected) {
                                              return ListTile(
                                                title: Text(
                                                    item.societyName.toString(),
                                                    style: selected
                                                        ? TextStyle(
                                                            color: AppColor
                                                                .primary)
                                                        : const TextStyle()),
                                                subtitle: Text(
                                                  item.societyCode.toString(),
                                                ),
                                              );
                                            },
                                            title: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: Center(
                                                child: Text(
                                                  'Select Society',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            disabledItemFn: (Society s) =>
                                                false,
                                            modalBottomSheetProps:
                                                ModalBottomSheetProps(
                                              elevation: 6,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          AppBorderRadius.md),
                                                      topRight: Radius.circular(
                                                          AppBorderRadius.md))),
                                            ),
                                            searchFieldProps: TextFieldProps(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 15),
                                                enabledBorder: inputBorder,
                                                focusedBorder:
                                                    inputBorderFocused,
                                                errorBorder: inputBorder,
                                                focusedErrorBorder:
                                                    inputBorderFocused,
                                                filled: true,
                                                fillColor:
                                                    AppColor.xLightBackground,
                                              ),
                                            )),
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 15),
                                            enabledBorder: inputBorder,
                                            focusedBorder: inputBorderFocused,
                                            errorBorder: inputBorder,
                                            focusedErrorBorder:
                                                inputBorderFocused,
                                            filled: true,
                                            fillColor:
                                                AppColor.xLightBackground,
                                          ),
                                        ),
                                        // items: ['Greater Accra', 'Volta', 'Western'],
                                        asyncItems: (String filter) async {
                                          var response =
                                              await editFarmController
                                                  .globalController
                                                  .database!
                                                  .societyDao
                                                  .findAllSociety();
                                          return response;
                                        },
                                        itemAsString: (Society d) =>
                                            d.societyName ?? '',
                                        // filterFn: (regionDistrict, filter) => RegionDistrict.userFilterByCreationDate(filter),
                                        compareFn: (d, filter) =>
                                            d.societyName == filter.societyName,
                                        onChanged: (val) {
                                          editFarmController.society = val;
                                          editFarmController.update();
                                        },
                                        selectedItem:
                                            editFarmController.society,

                                        autoValidateMode:
                                            AutovalidateMode.always,
                                        validator: (item) {
                                          if (item == null) {
                                            return 'Society is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      GetBuilder(
                                        init: editFarmController,
                                        builder: (ctx) {
                                          return editFarmController.society !=
                                                  null
                                              ? Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      'Farmer',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    DropdownSearch<
                                                        FarmerFromServer>(
                                                      popupProps: PopupProps
                                                          .modalBottomSheet(
                                                              showSelectedItems:
                                                                  true,
                                                              showSearchBox:
                                                                  true,
                                                              itemBuilder:
                                                                  (context, item,
                                                                      selected) {
                                                                return ListTile(
                                                                  title: Text(
                                                                      "${item.farmerFirstName} ${item.farmerLastName}",
                                                                      style: selected
                                                                          ? TextStyle(
                                                                              color: AppColor.primary)
                                                                          : const TextStyle()),
                                                                  subtitle:
                                                                      Text(
                                                                    item.farmerCode
                                                                        .toString(),
                                                                  ),
                                                                );
                                                              },
                                                              title:
                                                                  const Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            15),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Select farmer',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                              ),
                                                              disabledItemFn:
                                                                  (FarmerFromServer
                                                                          s) =>
                                                                      false,
                                                              modalBottomSheetProps:
                                                                  ModalBottomSheetProps(
                                                                elevation: 6,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(AppBorderRadius
                                                                                .md),
                                                                        topRight:
                                                                            Radius.circular(AppBorderRadius.md))),
                                                              ),
                                                              searchFieldProps:
                                                                  TextFieldProps(
                                                                decoration:
                                                                    InputDecoration(
                                                                  contentPadding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          4,
                                                                      horizontal:
                                                                          15),
                                                                  enabledBorder:
                                                                      inputBorder,
                                                                  focusedBorder:
                                                                      inputBorderFocused,
                                                                  errorBorder:
                                                                      inputBorder,
                                                                  focusedErrorBorder:
                                                                      inputBorderFocused,
                                                                  filled: true,
                                                                  fillColor:
                                                                      AppColor
                                                                          .xLightBackground,
                                                                ),
                                                              )),
                                                      dropdownDecoratorProps:
                                                          DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 4,
                                                                  horizontal:
                                                                      15),
                                                          enabledBorder:
                                                              inputBorder,
                                                          focusedBorder:
                                                              inputBorderFocused,
                                                          errorBorder:
                                                              inputBorder,
                                                          focusedErrorBorder:
                                                              inputBorderFocused,
                                                          filled: true,
                                                          fillColor: AppColor
                                                              .xLightBackground,
                                                        ),
                                                      ),
                                                      asyncItems: (String
                                                          filter) async {
                                                        var response = await editFarmController
                                                            .globalController
                                                            .database!
                                                            .farmerFromServerDao
                                                            .findFarmersFromServerInSociety(
                                                                editFarmController
                                                                    .society!
                                                                    .societyName!);
                                                        return response;
                                                      },
                                                      itemAsString:
                                                          (FarmerFromServer
                                                                  d) =>
                                                              "${d.farmerFirstName} ${d.farmerFirstName}",
                                                      // filterFn: (regionDistrict, filter) => RegionDistrict.userFilterByCreationDate(filter),
                                                      compareFn: (d, filter) =>
                                                          d.farmerFirstName ==
                                                          filter
                                                              .farmerFirstName,
                                                      onChanged: (val) {
                                                        editFarmController
                                                                .farmerFromServer =
                                                            val;
                                                      },
                                                      selectedItem:
                                                          editFarmController
                                                              .farmerFromServer,
                                                      autoValidateMode:
                                                          AutovalidateMode
                                                              .always,
                                                      validator: (item) {
                                                        if (item == null) {
                                                          return 'Farmer is required';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                    ),
                                                    const SizedBox(height: 20),
                                                    if (!widget.isViewMode)
                                                      Row(
                                                        children: [
                                                          CustomButton(
                                                            isFullWidth: false,
                                                            backgroundColor:
                                                                AppColor
                                                                    .xLightBackground,
                                                            borderColor:
                                                                AppColor.black,
                                                            borderWidth: 0.5,
                                                            verticalPadding:
                                                                0.0,
                                                            horizontalPadding:
                                                                8.0,
                                                            onTap: () async {
                                                              editFarmController
                                                                  .usePolygonDrawingTool();
                                                            },
                                                            child: Text(
                                                              'Demarcate farm boundary',
                                                              style: TextStyle(
                                                                  color: AppColor
                                                                      .black,
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                          GetBuilder(
                                                              init:
                                                                  editFarmController,
                                                              builder:
                                                                  (context) {
                                                                return editFarmController
                                                                            .polygon !=
                                                                        null
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                15.0),
                                                                        child: appIconBadgeCheck(
                                                                            color:
                                                                                AppColor.primary,
                                                                            size: 35),
                                                                      )
                                                                    : Container();
                                                              }),
                                                        ],
                                                      ),
                                                    if (!widget.isViewMode)
                                                      const SizedBox(
                                                          height: 20),
                                                    const Text(
                                                      'Farm Area in Hectares',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          editFarmController
                                                              .farmAreaTC,
                                                      readOnly: true,
                                                      onTap: () =>
                                                          editFarmController
                                                              .globals
                                                              .showSnackBar(
                                                                  title:
                                                                      'Alert',
                                                                  message:
                                                                      'Kindly tap Demarcate farm boundary to compute area'),
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 15,
                                                                horizontal: 15),
                                                        enabledBorder:
                                                            inputBorder,
                                                        focusedBorder:
                                                            inputBorderFocused,
                                                        errorBorder:
                                                            inputBorder,
                                                        focusedErrorBorder:
                                                            inputBorderFocused,
                                                        filled: true,
                                                        fillColor: AppColor
                                                            .xLightBackground,
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      validator: (String?
                                                              value) =>
                                                          value!.trim().isEmpty
                                                              ? "Area is required"
                                                              : null,
                                                    ),
                                                    const SizedBox(height: 20),
                                                    if (!widget.isViewMode)
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                    if (!widget.isViewMode)
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: CustomButton(
                                                              isFullWidth: true,
                                                              backgroundColor:
                                                                  AppColor
                                                                      .black,
                                                              verticalPadding:
                                                                  0.0,
                                                              horizontalPadding:
                                                                  8.0,
                                                              onTap: () async {
                                                                // if (!editFarmController
                                                                //     .isSaveButtonDisabled
                                                                //     .value) {
                                                                if (editFarmController
                                                                    .formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  editFarmController
                                                                      .handleSaveOfflineFarm();
                                                                } else {
                                                                  editFarmController
                                                                      .globals
                                                                      .showSnackBar(
                                                                          title:
                                                                              'Alert',
                                                                          message:
                                                                              'Kindly provide all required information');
                                                                }
                                                                // }
                                                              },
                                                              child:
                                                                  // Obx(
                                                                  //   () =>
                                                                  Text(
                                                                // editFarmController
                                                                //         .isSaveButtonDisabled
                                                                //         .value
                                                                //     ? 'Please wait ...'
                                                                //     :
                                                                'Save',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .white,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              // ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 20),
                                                          Expanded(
                                                            child: CustomButton(
                                                              isFullWidth: true,
                                                              backgroundColor:
                                                                  AppColor
                                                                      .primary,
                                                              verticalPadding:
                                                                  0.0,
                                                              horizontalPadding:
                                                                  8.0,
                                                              onTap: () async {
                                                                // if (!editFarmController
                                                                //     .isButtonDisabled.value) {
                                                                if (editFarmController
                                                                    .formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  editFarmController
                                                                      .handleAddFarm();
                                                                } else {
                                                                  editFarmController
                                                                      .globals
                                                                      .showSnackBar(
                                                                          title:
                                                                              'Alert',
                                                                          message:
                                                                              'Kindly provide all required information');
                                                                }
                                                                // }
                                                              },
                                                              child:
                                                                  // Obx(
                                                                  //   () =>
                                                                  Text(
                                                                // editFarmController
                                                                //         .isButtonDisabled
                                                                //         .value
                                                                //     ? 'Please wait ...'
                                                                //     :
                                                                'Submit',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .white,
                                                                    fontSize:
                                                                        14),
                                                                // ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    const SizedBox(height: 30),
                                                  ],
                                                )
                                              : Container();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        if (widget.isViewMode)
                          Row(
                            children: [
                              CustomButton(
                                isFullWidth: false,
                                backgroundColor: AppColor.primary,
                                borderColor: AppColor.white,
                                borderWidth: 0.5,
                                verticalPadding: 0.0,
                                horizontalPadding: 8.0,
                                onTap: () async {
                                  editFarmController
                                      .usePolygonDrawingToolViewOnly();
                                },
                                child: Text(
                                  'View farm boundary',
                                  style: TextStyle(
                                      color: AppColor.white, fontSize: 14),
                                ),
                              ),
                              GetBuilder(
                                  init: editFarmController,
                                  builder: (context) {
                                    return editFarmController.polygon != null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: appIconBadgeCheck(
                                                color: AppColor.primary,
                                                size: 35),
                                          )
                                        : Container();
                                  }),
                            ],
                          ),
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
