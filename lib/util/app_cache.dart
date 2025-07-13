import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const String governoratesKey = 'cached_governorates_list';
  static const String areasKey = 'cached_areas_list';

  static final AppCache _instance = AppCache();

  static AppCache get instance {
    return _instance;
  }

  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
