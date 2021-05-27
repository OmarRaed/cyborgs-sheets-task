import 'package:ctborgs_sheets_task/controllers/form_screen_controller.dart';
import 'package:ctborgs_sheets_task/controllers/sheets_controller.dart';
import 'package:ctborgs_sheets_task/models/form_model.dart';
import 'package:ctborgs_sheets_task/ui/widgets/custom_image_button.dart';
import 'package:ctborgs_sheets_task/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertFormScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = new GlobalKey();

  final sheetsController = Get.put(SheetsController());
  final formController = Get.put(FormScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Insert new form'),
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Name',
                textController: formController.nameTextController,
                inputType: TextInputType.name,
              ),
              SizedBox(height: 20),
              CustomTextField(
                  hintText: 'Mobile',
                  textController: formController.mobileTextController,
                  inputType: TextInputType.numberWithOptions(signed: false, decimal: false)),
              SizedBox(height: 20),
              CustomTextField(
                  hintText: 'Model Number',
                  textController: formController.modelNumberTextController,
                  inputType: TextInputType.numberWithOptions(signed: false, decimal: false)),
              SizedBox(height: 20),
              CustomTextField(
                  hintText: 'Email',
                  textController: formController.emailTextController,
                  inputType: TextInputType.name),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() => Text(formController.dateFormatted)),
                  TextButton(
                    child: Text('Change Date'),
                    onPressed: _selectDate,
                  )
                ],
              ),
              SizedBox(height: 20),
              CustomImageButton('Insert', () async {
                if (!formKey.currentState.validate()) return;
                Get.defaultDialog(
                  title: 'Please wait',
                  content: Container(
                    color: Colors.white,
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                  barrierDismissible: true,
                );
                await formController.insertForm();
                Get.back();
                Get.back();
              }, Icons.arrow_right_alt)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    formController.date = await showDatePicker(
      context: Get.context,
      initialDate: formController.date,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
  }
}
