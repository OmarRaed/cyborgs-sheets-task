import 'package:ctborgs_sheets_task/controllers/auth_controller.dart';
import 'package:ctborgs_sheets_task/controllers/sheets_controller.dart';
import 'package:ctborgs_sheets_task/ui/screens/sign_in_screen.dart';
import 'package:ctborgs_sheets_task/ui/widgets/custom_image_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cards_screen.dart';

class CreateSheetScreen extends StatelessWidget {
  final authController = Get.put(AuthController());
  final sheetsController = Get.put(SheetsController());
  final TextEditingController sheetNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Cyborgs Sheets Task'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                authController.signOut();
                Get.off(() => SignInScreen());
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            TextFormField(
              cursorColor: Colors.black,
              keyboardType: TextInputType.name,
              controller: sheetNameController,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Sheet Name"),
            ),
            SizedBox(height: 40),
            CustomImageButton(
              'Create Sheet',
              () {
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
                sheetsController
                    .createSpreadSheet(sheetNameController.text)
                    .then((_) => Get.off(() => CardsScreen()));
              },
              Icons.file_copy,
            ),
          ],
        ),
      ),
    );
  }
}
