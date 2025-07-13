import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:blnk_task/models/user.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';

class GoogleProvider extends ChangeNotifier {
  final String _serviceAccountJsonString = r'''
{
  "type": "service_account",
  "project_id": "b-task-465817",
  "private_key_id": "a9c8f039b9f2693040a0952aa39a0b148a6a031f",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCnP1MMy1ID6X8Z\nB0ZfOAqllqIihIIUOAo3D/5Crr6Ao7dwz6Gu5nadPYHyIoej+SEy5/KXGWT+htW4\nLG+ARWoPACNd3IihiN7a/1hpU1xkq2EcEzuxe64b5UPXAIJ7JAG7XtYlGAKHVb/s\np/OEybb7wwOa+Kmamin4W3LzJIW8K+Rt7lO0lF2MHw7+XUHJe66PELKz3kBdLNcb\nfI7uYb5SnPiO/lf5yqqjvlMNHaSjBgskBNInxPUDyKxyNM1lNbiNnTWIDNGaTJbu\nihC25HXelXDLIXy3pJIinkwIOkiY0LoJj1dPxvaBV7hPdBY+Wtte9bl1MC/KXRMS\nnrixoYR5AgMBAAECggEAH9JTJXSMEtV7CtKRB638jJwYFlQ7AcjV3LssyBhCg+xi\ni1LeMw6DlBBvaJg8Ua0lrW9nf2tkBW+3O1ctEe1jLB59HC9JSd7mdCmwcz3arwbS\nr8pTCcZ8Dq+1FDPzH6XutG1rdlxWotRkc41TLrlImSd2SKa2coWRpcEUooGY9n/e\ntV01rGmFWB1MT3Tsyg7xAj+6WfrM4hmlEPZiiqjLwfCupz9e7MuwjSaq+pRX0MY/\n9SHX2sIxTRXAvLqEgb+vomTUU50gDnko7NSsR3flbTUHtpkT6pf761J/2KxADpzt\n1vlNffvnh3CMRTw2QZtLnkVbPBkL7BTxIP6kOPj2fwKBgQDP7LYAdVB4dGX7vD7g\nAvtFX2DeOjzCADgpCmoBPnYKVDylaAoirAKfHV5MVSQOsO5h1dIdCYW5SUrGhuT6\nBzNpyUgMa0Jw9J04w5t3ldG9w4B/imHG3e3/fx9/fuXLssDTXMhAKpIcT2MRAJNq\nQe7BAaYI7zeIBLn0wz8P8rNIXwKBgQDN6uE8WoPSAdW/PnBfw4e/v1yhNQwETbDq\nvb3oZgQFz75PRf60sIyiUluMSumYTeGR7zL8I9Hoyp34Q2F0x5TAUTX9y43PbPIX\nvUn+8f535/PW2T2MnLsHDvt26YLz+d0ZrxWbw4wDN6v2Ylxtaf2F9htmNzEKdSGW\n93qR1PdCJwKBgCnpEr6A5xmAjNXzGdFZiIBxOztQDdMk7C0Jllht2Kk4VYkZsYFP\nnq+n4cwNFVmIvGQoD1QfCT9R0Kq3ogvry6c1FTq7nAbcp5w7gWjXYBGaCJqssAy/\nyytG2nh+gZ9PhqKT/yE/83eVYOiabxxp8dAhnvAKF+1o1nrJqDp0t0KNAoGBAJWK\nX+wep+CZaIssYxuIukrsQ+7mwUVWzoaLKSFfBMjbp4+We3TpShiPyuBFfwMWfBwp\nJFOsB8MRcktbU6klT8eisp0PeHsM2XuYAebeAzk8//4lYed94u0rWj9vMaTQ7lq6\npeyqxEGJ6p5RrGHhOTZSFm/S4RCBI9WpACBsEuy9AoGBAIR3sGso7Mi6YZpEFjwd\nOYvj8cUF4BzgfoNO5YEMYbdElrDqZsVuA2ztzjfqtgvhB+QmZsfND+/cV7b7p8sN\niJXxLd1fDcRtLDGwbaSwea8wWvp6IlXK1XqQyDB09umu2CU1EympB3CzdyUNyDXm\nYvgcGedSSrhhnrYT2LcjW96B\n-----END PRIVATE KEY-----\n",
  "client_email": "b-task-acc@b-task-465817.iam.gserviceaccount.com",
  "client_id": "103874348023635511782",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/b-task-acc%40b-task-465817.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  final String _googleDriveFolderId =
      '1KYkxgZNvtlZDEEj_-MNND1IAd0MrWigu'; // e.g., '1aBcDeF_gHiJkLmNoPqRsTuVwXyZ'

// The ID of your Google Sheet named "users"
  final String _googleSheetId =
      '1-ep-FdyUNcZoiOm7qP7q6lvDr8a_1YUdhjjs6PgoR4o'; // e.g., '1234567890abcdefghijklmnopqrstuvwxyz'
  final String _sheetName = 'Sheet1';
  final List<String> _scopes = [
    drive.DriveApi.driveScope, // Full access to Drive (for Service Account)
    sheets.SheetsApi.spreadsheetsScope, // Full access to Sheets
  ];
  Future<void> submitDataToGoogle(User user) async {
    // Basic validation: Ensure dummy files exist (or real files in your app)
    if (user.frontIDURL == null || user.backIDURL == null) {
      log("check paths");
    }
    if (File(user.frontIDURL!).existsSync() == false ||
        File(user.frontIDURL!).existsSync() == false) {
      log("error at fetching pdf");
      return;
    }

    Client?
        client; // Declare client here to ensure it's closed in finally block

    try {
      // 5.1: Authenticate with Service Account
      log('Authenticating with Service Account...');
      final Map<String, dynamic> credentialsJson =
          jsonDecode(_serviceAccountJsonString);
      final ServiceAccountCredentials credentials =
          ServiceAccountCredentials.fromJson(credentialsJson);

      // This creates an authenticated HTTP client that will be used for all API calls.
      client = await clientViaServiceAccount(credentials, _scopes);
      log('Service Account authenticated successfully.');

      // 5.2: Initialize Google Drive and Google Sheets APIs
      final driveApi = drive.DriveApi(client);
      final sheetsApi = sheets.SheetsApi(client);
      log('Google Drive and Sheets APIs initialized.');

      // 5.3: Upload Front ID PDF to Google Drive
      log('Uploading Front ID to Google Drive...');
      final frontIdFile = File(user.frontIDURL!);
      final frontIdBytes =
          await frontIdFile.readAsBytes(); // Read file content as bytes
      final frontIdMedia = drive.Media(
        frontIdFile.openRead(), // Stream of file content
        frontIdBytes.length, // Content length
        contentType: 'application/pdf', // MIME type
      );
      final drive.File frontDriveFile = await driveApi.files.create(
        drive.File()
          ..name =
              'Front_ID_${user.firstName}_${DateTime.now().millisecondsSinceEpoch}.pdf'
          ..mimeType = 'application/pdf'
          ..parents = [_googleDriveFolderId], // Specify the target folder ID
        uploadMedia: frontIdMedia,
      );
      log('Front ID uploaded. File ID: ${frontDriveFile.id}');

      // 5.4: Upload Back ID PDF to Google Drive
      log('Uploading Back ID to Google Drive...');
      final backIdFile = File(user.backIDURL!);
      final backIdBytes = await backIdFile.readAsBytes();
      final backIdMedia = drive.Media(
        backIdFile.openRead(),
        backIdBytes.length,
        contentType: 'application/pdf',
      );
      final drive.File backDriveFile = await driveApi.files.create(
        drive.File()
          ..name =
              'Back_ID_${user.firstName}_${DateTime.now().millisecondsSinceEpoch}.pdf'
          ..mimeType = 'application/pdf'
          ..parents = [_googleDriveFolderId], // Specify the target folder ID
        uploadMedia: backIdMedia,
      );
      log('Back ID uploaded. File ID: ${backDriveFile.id}');

      // 5.5: Construct Google Drive File Links
      // These links allow direct access to the uploaded files.
      // Permissions on the Drive folder/file (set in Google Cloud/Drive UI)
      // determine if these links are publicly accessible or require login.
      final frontIdLink =
          'https://drive.google.com/file/d/${frontDriveFile.id}/view?usp=sharing';
      final backIdLink =
          'https://drive.google.com/file/d/${backDriveFile.id}/view?usp=sharing';
      log('Generated Drive links.');

      // 5.6: Prepare Data for Google Sheets
      log('Preparing data for Google Sheet...');
      final List<List<Object>> rowData = [
        [
          user.firstName,
          user.lastName,
          user.mobileNumber,
          user.landLine,
          user.email,
          user.address!.fullAddressString,
          frontDriveFile.name ?? 'N/A', // Store filename
          frontIdLink, // Store link
          backDriveFile.name ?? 'N/A', // Store filename
          backIdLink, // Store link
          DateTime.now().toIso8601String(), // Timestamp for the record
        ]
      ];

      final sheets.ValueRange valueRange = sheets.ValueRange(values: rowData);

      // 5.7: Append Data to Google Sheet
      log('Appending data to Google Sheet...');
      await sheetsApi.spreadsheets.values.append(
        valueRange,
        _googleSheetId,
        '$_sheetName!A1:Z', // Append to sheet starting from A1
        valueInputOption:
            'RAW', // Treat input as raw values (e.g., numbers as numbers)
        insertDataOption:
            'INSERT_ROWS', // Insert new rows at the end of the sheet
      );
      log('Data appended to Google Sheet successfully.');

      // Optional: Clean up dummy files after successful submission
      await frontIdFile.delete();
      await backIdFile.delete();
      log('Dummy files cleaned up.');
    } catch (e) {
      // Handle any errors during the submission process
      log('Submission Error: $e');
    } finally {
      // Ensure the submission state is reset and HTTP client is closed

      client
          ?.close(); // Close the authenticated HTTP client to release resources
      log('HTTP client closed.');
    }
  }
}
