import 'package:ctborgs_sheets_task/models/form_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:intl/intl.dart';

import '../util/google_auth_client.dart';

/*
 * Sheets Controller class responsible for controlling the Sheet
 *  (creating a new sheet, write, read and delete rows from a sheet)
 */
class SheetsController extends GetxController {
  final RxList<FormModel> forms = RxList<FormModel>();

  @override
  void onInit() async {
    super.onInit();
    await readFromSheet();
  }

  Future createSpreadSheet(String fileName) async {
    // get the current signed in user
    GoogleSignInAccount googleUser = await GoogleSignIn().signInSilently();

    // get the auth client for the current user
    final authenticateClient = GoogleAuthClient(await googleUser.authHeaders);

    // get the drive api for the current user
    final driveApi = drive.DriveApi(authenticateClient);

    // create a new file
    var driveFile = new drive.File();
    driveFile.name = fileName;
    driveFile.mimeType = 'application/vnd.google-apps.spreadsheet';
    final result = await driveApi.files.create(driveFile);

    // cache the filename and id
    GetStorage().write('fileName', fileName);
    GetStorage().write('fileId', result.id);

    return result.id;
  }

  /*
   * write a row to the sheet
   */
  writeToSheet(FormModel form) async {
    // get the current signed in user
    GoogleSignInAccount googleUser = await GoogleSignIn().signInSilently();

    // get the auth client for the current user
    final authenticateClient = GoogleAuthClient(await googleUser.authHeaders);

    // get the sheets api for this client
    final sheetsApi = sheets.SheetsApi(authenticateClient);

    // get the cached file id
    final sheetId = await GetStorage().read('fileId');

    sheets.ValueRange vr = new sheets.ValueRange.fromJson({
      "values": [
        [form.name, form.mobile, form.email, form.modelNumber, form.purchaseDate]
      ]
    });

    await sheetsApi.spreadsheets.values
        .append(vr, sheetId, 'A:E', valueInputOption: 'USER_ENTERED')
        .then((sheets.AppendValuesResponse r) {
      print('append completed');
    });

    readFromSheet();
  }

  /*
   * read the data from the sheet
   */
  readFromSheet() async {
    // get the current signed in user
    GoogleSignInAccount googleUser = await GoogleSignIn().signInSilently();

    // get the auth client for the current user
    final authenticateClient = GoogleAuthClient(await googleUser.authHeaders);

    // get the sheets api for this client
    final sheetsApi = sheets.SheetsApi(authenticateClient);

    // get the cached file id
    final sheetId = await GetStorage().read('fileId');

    // get the data for the first 5 columns
    final values = await sheetsApi.spreadsheets.values.get(sheetId, 'A:E');

    // clear the current forms
    forms.clear();

    values.values?.forEach((element) {
      print(element);
      forms.add(FormModel(
          name: element[0].toString(),
          mobile: element[1].toString(),
          modelNumber: int.parse(element[3].toString()),
          email: element[2].toString(),
          purchaseDate: element[4].toString()));
    });
  }

  /*
   * delete a row from the sheet (index 0 for the first row)
   */
  deleteFromSheet(int index) async {
    // get the current signed in user
    GoogleSignInAccount googleUser = await GoogleSignIn().signInSilently();

    // get the auth client for the current user
    final authenticateClient = GoogleAuthClient(await googleUser.authHeaders);

    // get the sheets api for this client
    final sheetsApi = sheets.SheetsApi(authenticateClient);

    // get the cached file id
    final sheetId = await GetStorage().read('fileId');

    // grid range object to specify the rows and columns to be deleted
    sheets.GridRange gridRange = sheets.GridRange();
    gridRange.sheetId = 0; // 0 for the first sheet
    gridRange.startRowIndex = index; // index of the row that will be deleted (inclusive)
    gridRange.endRowIndex = index + 1; // index of the next row (exclusive)

    sheets.DeleteRangeRequest deleteRangeRequest = sheets.DeleteRangeRequest();
    deleteRangeRequest.range = gridRange;
    deleteRangeRequest.shiftDimension =
        "ROWS"; // existing cells will be shifted upwards to replace the deleted cells

    sheets.Request request = sheets.Request();
    request.deleteRange = deleteRangeRequest;

    sheets.BatchUpdateSpreadsheetRequest batchRequest = sheets.BatchUpdateSpreadsheetRequest();
    batchRequest.requests = [request];

    // start the delete request
    await sheetsApi.spreadsheets.batchUpdate(batchRequest, sheetId);

    readFromSheet();
  }

  bool isSpreadSheetCreated() {
    return GetStorage().read('fileId') != null;
  }

  String sheetName() {
    return GetStorage().read('fileName');
  }
}
