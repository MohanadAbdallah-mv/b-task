import 'package:blnk_task/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User? currentUser;

  void setUser(String firstName, String lastName, String mobileNumber,
      String landLine, String email) {
    currentUser = User(
        firstName: firstName,
        lastName: lastName,
        mobileNumber: mobileNumber,
        landLine: landLine,
        email: email);
    notifyListeners();
  }
}
