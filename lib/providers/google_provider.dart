import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": "",
  "universe_domain": ""
}
'''; // service account json string should look like this

  final String _googleDriveFolderId =
      '1KYkxgZNvtlZDEEj_-MNND1IAd0MrWigu'; // Add Shared Google Drive folder id for saving the images

  final String _googleSheetId =
      '1-ep-FdyUNcZoiOm7qP7q6lvDr8a_1YUdhjjs6PgoR4o'; // Add Google sheet id for saving user's data
  final String _sheetName = 'Sheet1';
  final List<String> _scopes = [
    drive.DriveApi.driveScope,
    sheets.SheetsApi.spreadsheetsScope,
  ];
  Future<void> submitDataToGoogle(User user) async {
    if (user.frontIDURL == null || user.backIDURL == null) {
      log("check paths");
    }
    if (File(user.frontIDURL!).existsSync() == false ||
        File(user.frontIDURL!).existsSync() == false) {
      log("error at fetching pdf");
      return;
    }

    Client? client;
    try {
      log('Authenticating with Service Account...');
      final Map<String, dynamic> credentialsJson =
          jsonDecode(_serviceAccountJsonString);
      final ServiceAccountCredentials credentials =
          ServiceAccountCredentials.fromJson(credentialsJson);

      client = await clientViaServiceAccount(credentials, _scopes);
      log('Service Account authenticated successfully.');

      final driveApi = drive.DriveApi(client);
      final sheetsApi = sheets.SheetsApi(client);
      log('Google Drive and Sheets APIs initialized.');

      log('Uploading Front ID to Google Drive...');
      final frontIdFile = File(user.frontIDURL!);
      final frontIdBytes = await frontIdFile.readAsBytes();
      final frontIdMedia = drive.Media(
        frontIdFile.openRead(),
        frontIdBytes.length,
        contentType: 'application/pdf',
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
          ..parents = [_googleDriveFolderId],
        uploadMedia: backIdMedia,
      );
      log('Back ID uploaded. File ID: ${backDriveFile.id}');

      final frontIdLink =
          'https://drive.google.com/file/d/${frontDriveFile.id}/view?usp=sharing';
      final backIdLink =
          'https://drive.google.com/file/d/${backDriveFile.id}/view?usp=sharing';
      log('Generated Drive links.');

      log('Preparing data for Google Sheet...');
      final List<List<Object>> rowData = [
        [
          user.firstName,
          user.lastName,
          user.mobileNumber,
          user.landLine,
          user.email,
          user.address!.fullAddressString,
          frontDriveFile.name ?? 'N/A',
          frontIdLink,
          backDriveFile.name ?? 'N/A',
          backIdLink,
          DateTime.now().toIso8601String(),
        ]
      ];

      final sheets.ValueRange valueRange = sheets.ValueRange(values: rowData);

      log('Appending data to Google Sheet...');
      await sheetsApi.spreadsheets.values.append(
        valueRange,
        _googleSheetId,
        '$_sheetName!A1:Z',
        valueInputOption: 'RAW',
        insertDataOption: 'INSERT_ROWS',
      );
      log('Data appended to Google Sheet successfully.');

      await frontIdFile.delete();
      await backIdFile.delete();
      log('Dummy files cleaned up.');
    } catch (e) {
      log('Submission Error: $e');
    } finally {
      client
          ?.close(); // Close the authenticated HTTP client to release resources
      log('HTTP client closed.');
    }
  }
}
