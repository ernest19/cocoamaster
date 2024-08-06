// import 'dart:convert';

import 'dart:convert';

import 'package:cocoa_master/controller/entity/farmer_from_server.dart';
import 'package:cocoa_master/view/edit_farmer_list/edit_farmer_list_record_controller.dart';
import 'package:cocoa_master/view/global_components/image_field_card.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/entity/society.dart';
import '../../controller/global_controller.dart';
import '../global_components/custom_button.dart';
import '../global_components/round_icon_button.dart';
import '../global_components/text_input_decoration.dart';
import '../home/home_controller.dart';
import '../utils/style.dart';

class EditFarmerListRecord extends StatefulWidget {
  final FarmerFromServer farmer;
  final bool isViewMode;
  const EditFarmerListRecord(
      {Key? key, required this.farmer, required this.isViewMode})
      : super(key: key);

  @override
  State<EditFarmerListRecord> createState() => _EditMonitoringRecordState();
}

class _EditMonitoringRecordState extends State<EditFarmerListRecord> {
  EditFarmerListRecordController editFarmerListRecordController =
      Get.put(EditFarmerListRecordController());
  GlobalController globalController = Get.find();
  HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();

    editFarmerListRecordController.farmer = widget.farmer;
    editFarmerListRecordController.isViewMode = widget.isViewMode;
  }

  @override
  Widget build(BuildContext context) {
    editFarmerListRecordController.editFarmerListRecordScreenContext = context;

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
                                  ? 'View Farmer Record'
                                  : 'Edit Farmer Record',
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
                              init: editFarmerListRecordController,
                              builder: (ctx) {
                                return Form(
                                  key: editFarmerListRecordController
                                      .editFarmerListRecordFormKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Picture of Farmer',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      GetBuilder(
                                          init: editFarmerListRecordController,
                                          builder: (context) {
                                            return ImageFieldCard(
                                              onTap: () =>
                                                  editFarmerListRecordController
                                                      .chooseMediaSource(),
                                              image:
                                                  editFarmerListRecordController
                                                      .farmerPhoto?.file,
                                              base64Image: base64Encode(
                                                  widget.farmer.farmerPhoto ??
                                                      []),
                                            );
                                          }),
                                      // GetBuilder(
                                      //     init: editFarmerListRecordController,
                                      //     builder: (context) {
                                      //       return ImageFieldCard(
                                      //         // onTap: () => addInitialTreatmentMonitoringRecordController.chooseMediaSource(),
                                      //         // onTap: () => addInitialTreatmentMonitoringRecordController.pickMedia(source: 1, imageToSet: PersonnelImageData.personnelImage),
                                      //         onTap: () =>
                                      //             editFarmerListRecordController
                                      //                 .pickMedia(source: 1),
                                      //         image:
                                      //             editFarmerListRecordController
                                      //                 .farmerPhoto?.file,
                                      //       );
                                      //     }),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Farmer First Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        controller:
                                            editFarmerListRecordController
                                                .farmerFirstNameTC,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 15),
                                          enabledBorder: inputBorder,
                                          focusedBorder: inputBorderFocused,
                                          errorBorder: inputBorder,
                                          focusedErrorBorder:
                                              inputBorderFocused,
                                          filled: true,
                                          fillColor: AppColor.xLightBackground,
                                        ),
                                        textInputAction: TextInputAction.next,
                                        // autovalidateMode: AutovalidateMode.always,

                                        validator: (String? value) => value!
                                                .trim()
                                                .isEmpty
                                            ? "Farmer first name is required"
                                            : null,
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Farmer Last Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        controller:
                                            editFarmerListRecordController
                                                .farmerLastNameTC,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 15),
                                          enabledBorder: inputBorder,
                                          focusedBorder: inputBorderFocused,
                                          errorBorder: inputBorder,
                                          focusedErrorBorder:
                                              inputBorderFocused,
                                          filled: true,
                                          fillColor: AppColor.xLightBackground,
                                        ),
                                        textInputAction: TextInputAction.next,
                                        // autovalidateMode: AutovalidateMode.always,

                                        validator: (String? value) =>
                                            value!.trim().isEmpty
                                                ? "Farmer last name is required"
                                                : null,
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Farmers Contact Number',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        controller:
                                            editFarmerListRecordController
                                                .farmerPhoneNumberTC,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 15),
                                          enabledBorder: inputBorder,
                                          focusedBorder: inputBorderFocused,
                                          errorBorder: inputBorder,
                                          focusedErrorBorder:
                                              inputBorderFocused,
                                          filled: true,
                                          fillColor: AppColor.xLightBackground,
                                        ),
                                        textInputAction: TextInputAction.next,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        keyboardType: TextInputType.phone,
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: (String? value) =>
                                            value!.trim().isEmpty ||
                                                    value.trim().length != 10
                                                ? "Enter a valid phone number"
                                                : null,
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'ID Type',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      DropdownSearch<String>(
                                        popupProps: PopupProps.menu(
                                            showSelectedItems: true,
                                            disabledItemFn: (String s) => false,
                                            fit: FlexFit.loose,
                                            menuProps: MenuProps(
                                                elevation: 6,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppBorderRadius.sm))),
                                        items: editFarmerListRecordController
                                            .idType,

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
                                            enabled: false,
                                            fillColor:
                                                AppColor.xLightBackground,
                                          ),
                                        ),
                                        selectedItem: widget.farmer.idType,
                                        // autoValidateMode: AutovalidateMode.always,
                                        validator: (item) {
                                          if (item == null) {
                                            return "ID type is required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (val) {
                                          editFarmerListRecordController
                                              .selectedIdType.value = val!;
                                          editFarmerListRecordController
                                              .update();
                                        },
                                      ),

                                      // DropdownSearch<String>(
                                      //   popupProps: PopupProps.menu(
                                      //       showSelectedItems: true,
                                      //       disabledItemFn: (String s) => false,
                                      //       fit: FlexFit.loose,
                                      //       menuProps: MenuProps(
                                      //           elevation: 6,
                                      //           borderRadius:
                                      //               BorderRadius.circular(
                                      //                   AppBorderRadius.sm))),
                                      //   items: editFarmerListRecordController
                                      //       .idType
                                      //       .map((idType) => idType.toString())
                                      //       .toList(),
                                      //   dropdownDecoratorProps:
                                      //       DropDownDecoratorProps(
                                      //     dropdownSearchDecoration:
                                      //         InputDecoration(
                                      //       contentPadding:
                                      //           const EdgeInsets.symmetric(
                                      //               vertical: 4,
                                      //               horizontal: 15),
                                      //       enabledBorder: inputBorder,
                                      //       focusedBorder: inputBorderFocused,
                                      //       errorBorder: inputBorder,
                                      //       focusedErrorBorder:
                                      //           inputBorderFocused,
                                      //       filled: true,
                                      //       enabled: false,
                                      //       fillColor:
                                      //           AppColor.xLightBackground,
                                      //     ),
                                      //   ),
                                      //   // autoValidateMode: AutovalidateMode.always,
                                      //   validator: (item) {
                                      //     if (item == null) {
                                      //       return "ID type is required";
                                      //     } else {
                                      //       return null;
                                      //     }
                                      //   },
                                      //   onChanged: (val) {
                                      //     editFarmerListRecordController
                                      //         .selectedIdType.value = val!;
                                      //     editFarmerListRecordController
                                      //         .update();
                                      //   },
                                      // ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'ID Number',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        controller:
                                            editFarmerListRecordController
                                                .farmerIdNumberTC,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 15),
                                          enabledBorder: inputBorder,
                                          focusedBorder: inputBorderFocused,
                                          errorBorder: inputBorder,
                                          focusedErrorBorder:
                                              inputBorderFocused,
                                          filled: true,
                                          fillColor: AppColor.xLightBackground,
                                        ),
                                        keyboardType: TextInputType.text,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        textInputAction: TextInputAction.next,
                                        // autovalidateMode: AutovalidateMode.always,
                                        validator: (String? value) =>
                                            value!.trim().isEmpty
                                                ? "ID number is required"
                                                : null,
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Date of Birth', // formerly ID Expiry Date
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      DateTimePicker(
                                        controller:
                                            editFarmerListRecordController
                                                .idExpiryDataTC,
                                        type: DateTimePickerType.date,
                                        initialDate: null,
                                        dateMask: 'yyyy-MM-dd',
                                        firstDate: DateTime(1600),
                                        lastDate: DateTime(2050),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 15),
                                          enabledBorder: inputBorder,
                                          focusedBorder: inputBorderFocused,
                                          errorBorder: inputBorder,
                                          focusedErrorBorder:
                                              inputBorderFocused,
                                          filled: true,
                                          fillColor: AppColor.xLightBackground,
                                        ),
                                        onChanged: (val) =>
                                            editFarmerListRecordController
                                                .idExpiryDataTC?.text = val,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return "Date of birth is required"; // formerly ID expiry date is required
                                          }
                                          return null;
                                        },
                                        onSaved: (val) =>
                                            editFarmerListRecordController
                                                .idExpiryDataTC?.text = val!,
                                      ),
                                      const SizedBox(height: 20),
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
                                                // subtitle: Text(
                                                //   item.operationalArea.toString(),
                                                // ),
                                              );
                                            },
                                            title: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: Center(
                                                child: Text(
                                                  'Select society',
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
                                        asyncItems: (String filter) async {
                                          var response =
                                              await editFarmerListRecordController
                                                  .globalController
                                                  .database!
                                                  .societyDao
                                                  .findAllSociety();
                                          return response;
                                        },
                                        itemAsString: (Society d) =>
                                            d.societyName ?? '',
                                        // filterFn: (society, filter) => society.userFilterByCreationDate(filter),
                                        compareFn: (d, filter) =>
                                            d.societyName == filter.societyName,
                                        onChanged: (val) {
                                          editFarmerListRecordController
                                              .society = val;
                                        },
                                        selectedItem:
                                            editFarmerListRecordController
                                                .society,

                                        // autoValidateMode: AutovalidateMode.always,
                                        validator: (item) {
                                          if (item == null) {
                                            return 'Society is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Number of Cocoa Farms ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                          controller:
                                              editFarmerListRecordController
                                                  .cocoaFarmsNumberTC,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15,
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
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textInputAction: TextInputAction.next,
                                          // autovalidateMode: AutovalidateMode.always,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Number of cocoa farms is required";
                                            }
                                            int? intValue = int.tryParse(value);
                                            if (intValue == null) {
                                              return "$value is not a valid number";
                                            }
                                            return null;
                                          }),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Number of Certified Crops ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                          controller:
                                              editFarmerListRecordController
                                                  .certifiedCropsNumberTC,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15,
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
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textInputAction: TextInputAction.next,
                                          // autovalidateMode: AutovalidateMode.always,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Number of certified crops is required";
                                            }
                                            int? intValue = int.tryParse(value);
                                            if (intValue == null) {
                                              return "$value is not a valid number";
                                            }
                                            return null;
                                          }),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Number Of Cocoa Bags Sold To Group In Previous Year',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                          controller: editFarmerListRecordController
                                              .totalPreviousYearsBagsSoldToGroup,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15,
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
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          // autovalidateMode: AutovalidateMode.always,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Cocoa bags sold to group (previous year) required";
                                            }
                                            return null;
                                          }),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Total Cocoa Bags Harvested (Previous Year)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                          controller:
                                              editFarmerListRecordController
                                                  .totalPreviousYearHarvestedCocoa,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15,
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
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          // autovalidateMode: AutovalidateMode.always,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Cocoa bags harvested in previous year is required";
                                            }

                                            return null;
                                          }),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Yield Estimate In Bags for Current Year ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                          controller:
                                              editFarmerListRecordController
                                                  .currentYearBagYieldEstimate,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15,
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
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          // autovalidateMode: AutovalidateMode.always,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Yield estimate for current year is required";
                                            }
                                            return null;
                                          }),
                                      const SizedBox(height: 20),
                                      if (!widget.isViewMode)
                                        const SizedBox(
                                          height: 40,
                                        ),
                                      if (!widget.isViewMode)
                                        Row(
                                          children: [
                                            // Expanded(
                                            //   child: CustomButton(
                                            //     isFullWidth: true,
                                            //     backgroundColor: AppColor.black,
                                            //     verticalPadding: 0.0,
                                            //     horizontalPadding: 8.0,
                                            //     onTap: () async {
                                            //       if (editFarmerListRecordController
                                            //           .editFarmerListRecordFormKey
                                            //           .currentState!
                                            //           .validate()) {
                                            //         editFarmerListRecordController
                                            //             .handleSaveOfflineFarmerRecord();
                                            //       } else {
                                            //         editFarmerListRecordController
                                            //             .globals
                                            //             .showSnackBar(
                                            //                 title: 'Alert',
                                            //                 message:
                                            //                     'Kindly provide all required information');
                                            //       }
                                            //     },
                                            //     child: Text(
                                            //       'Save',
                                            //       style: TextStyle(
                                            //           color: AppColor.white,
                                            //           fontSize: 14),
                                            //     ),
                                            //   ),
                                            // ),
                                            // const SizedBox(width: 20),
                                            Expanded(
                                              child: CustomButton(
                                                isFullWidth: true,
                                                backgroundColor:
                                                    AppColor.primary,
                                                verticalPadding: 0.0,
                                                horizontalPadding: 8.0,
                                                onTap: () async {
                                                  if (editFarmerListRecordController
                                                      .editFarmerListRecordFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    editFarmerListRecordController
                                                        .handleAddFarmerRecord();
                                                  } else {
                                                    editFarmerListRecordController
                                                        .globals
                                                        .showSnackBar(
                                                            title: 'Alert',
                                                            message:
                                                                'Kindly provide all required information');
                                                  }
                                                },
                                                child: Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                      color: AppColor.white,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                );
                              }),
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
