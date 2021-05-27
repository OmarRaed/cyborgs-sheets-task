import 'package:ctborgs_sheets_task/controllers/sheets_controller.dart';
import 'package:ctborgs_sheets_task/models/form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/*
 * Form Screen Controller class responsible for controlling the state of the Insert Form Screen
 */
class FormScreenController extends GetxController {
  final sheetsController = Get.put(SheetsController());

  TextEditingController nameTextController;
  TextEditingController mobileTextController;
  TextEditingController modelNumberTextController;
  TextEditingController emailTextController;

  Rx<DateTime> _date = DateTime.now().obs;

  DateTime get date => _date.value;

  set date(DateTime value) {
    _date.value = value;
  }

  String get dateFormatted => DateFormat("dd-MM-yyyy").format(_date.value);

  @override
  void onInit() async {
    super.onInit();
    nameTextController = TextEditingController();
    mobileTextController = TextEditingController();
    modelNumberTextController = TextEditingController();
    emailTextController = TextEditingController();
  }

  Future insertForm() async {
    await sheetsController.writeToSheet(
      FormModel(
        name: nameTextController.text,
        mobile: mobileTextController.text,
        modelNumber: int.parse(modelNumberTextController.text),
        email: emailTextController.text,
        purchaseDate: dateFormatted,
      ),
    );
  }

  @override
  void onClose() {
    super.onClose();
    nameTextController.text = '';
    mobileTextController.text = '';
    modelNumberTextController.text = '';
    emailTextController.text = '';
  }
}
