import 'package:ctborgs_sheets_task/controllers/auth_controller.dart';
import 'package:ctborgs_sheets_task/controllers/sheets_controller.dart';
import 'package:ctborgs_sheets_task/ui/screens/insert_form_screen.dart';
import 'package:ctborgs_sheets_task/ui/screens/sign_in_screen.dart';
import 'package:ctborgs_sheets_task/ui/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardsScreen extends StatelessWidget {
  final authController = Get.put(AuthController());
  final sheetsController = Get.put(SheetsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(sheetsController.sheetName()),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                authController.signOut();
                Get.off(() => SignInScreen());
              }),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Get.to(() => InsertFormScreen());
              }),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => sheetsController.forms.isEmpty
              ? Center(child: Text('No Items Yet'))
              : ListView.builder(
                  itemBuilder: (ctx, i) => FormWidget(
                      sheetsController.forms[i], () => sheetsController.deleteFromSheet(i)),
                  itemCount: sheetsController.forms.length,
                ),
        ),
      ),
    );
  }
}
