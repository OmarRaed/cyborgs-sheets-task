import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

/*
 * Auth Controller class responsible for controlling the authentication process (Sign in & out) 
 */
class AuthController extends GetxController {
  final RxBool isSignedIn = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await GoogleSignIn().isSignedIn().then((value) {
      isSignedIn.value = value;
    });
  }

  /*
   * function called to sign in using google 
   */
  Future signInWithGoogle() async {

    // initialize google sign in with drive scope
    final GoogleSignIn googleSignIn = (GoogleSignIn(scopes: [
      'https://www.googleapis.com/auth/drive',
    ]));

    // show google sign in dialog
    await googleSignIn.signIn();

    // set is signed in to true
    isSignedIn.value = true;
  }

/*
 * function called to sign out 
 */
  void signOut() async {

    // if account aleady signed in discconect
    if (await GoogleSignIn().isSignedIn()) {
      GoogleSignIn().disconnect();
    }

    // remoev any cached data
    GetStorage().remove('fileName');
    GetStorage().remove('fileId');
    
    // set is signed in to false
    isSignedIn.value = false;
  }
}
