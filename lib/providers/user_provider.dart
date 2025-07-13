import 'dart:developer';

import 'package:blnk_task/models/address/address.dart';
import 'package:blnk_task/models/user.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User? currentUser;
  String? frontIDPath;
  String? backIDPath;
  PDFDocument? frontIDDoc;

  void setUser(String firstName, String lastName, String mobileNumber,
      String landLine, String email) {
    currentUser = User(
        firstName: firstName,
        lastName: lastName,
        mobileNumber: mobileNumber,
        landLine: landLine,
        email: email);
    log(currentUser!.toJson().toString());
    notifyListeners();
  }

  void setAddress(String apartment, String floor, String building,
      String streetName, String areaName, String cityName, String landMark) {
    currentUser!.setAddress = Address(
        apartment: apartment,
        floor: floor,
        building: building,
        streetName: streetName,
        areaName: areaName,
        cityName: cityName,
        landMark: landMark);
    log(currentUser!.toJson().toString());
    notifyListeners();
  }

  void setFrontIDPath(String path) {
    frontIDPath = path;
    notifyListeners();
  }

  void setBackIDPath(String path) {
    backIDPath = path;
    notifyListeners();
  }
}
