import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const userKey = "user";
  static const tokenKey = "token";
  static String languageKey = "language";

  static final AppCache _instance = AppCache();

  static AppCache get instance {
    return _instance;
  }

  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
