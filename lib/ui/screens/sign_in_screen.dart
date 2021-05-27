import 'package:ctborgs_sheets_task/controllers/auth_controller.dart';
import 'package:ctborgs_sheets_task/controllers/sheets_controller.dart';
import 'package:ctborgs_sheets_task/ui/screens/create_sheet_screen.dart';
import 'package:ctborgs_sheets_task/ui/widgets/custom_image_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cards_screen.dart';

class SignInScreen extends StatelessWidget {
  final authController = Get.put(AuthController());
  final sheetsController = Get.put(SheetsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/cyborgs_tecgnology_logo.jpg',
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 200,
            ),
            Obx(
              () => authController.isSignedIn.value
                  ? CustomImageButton('Continue', () {
                      if (sheetsController.isSpreadSheetCreated()) Get.off(() => CardsScreen());
                      else Get.off(() => CreateSheetScreen());
                    }, Icons.arrow_right_alt)
                  : Container(),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => authController.isSignedIn.value
                  ? CustomImageButton('Sign Out', () => authController.signOut(), Icons.logout)
                  : CustomImageButton('Sign In', () async {
                      await authController.signInWithGoogle();
                      Get.off(CreateSheetScreen());
                    }, Icons.login),
            ),
          ],
        ),
      ),
    );
  }
}
