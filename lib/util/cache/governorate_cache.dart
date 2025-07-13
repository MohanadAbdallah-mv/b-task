import 'dart:convert';

import 'package:blnk_task/models/address/area.dart';
import 'package:blnk_task/models/address/governorate.dart';
import 'package:blnk_task/util/app_cache.dart';

class LocationCache extends AppCache {
  static final LocationCache _instance = LocationCache();

  static LocationCache get instance {
    return _instance;
  }

  void setGovernorates(List<Governorate>? governorates) {
    if (governorates != null && governorates.isNotEmpty) {
      final List<Map<String, dynamic>> jsonList =
          governorates.map((gov) => gov.toJson()).toList();
      final String jsonString = jsonEncode(jsonList);
      AppCache.instance.prefs.setString(AppCache.governoratesKey, jsonString);
    }
  }

  List<Governorate>? getGovernorates() {
    final String? jsonString =
        AppCache.instance.prefs.getString(AppCache.governoratesKey);
    if (jsonString == null) {
      return null;
    }
    final List<dynamic> decodedList = jsonDecode(jsonString);
    return decodedList
        .map((json) => Governorate.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  void setAreas(List<Area>? areas) {
    if (areas != null && areas.isNotEmpty) {
      final List<Map<String, dynamic>> jsonList =
          areas.map((area) => area.toJson()).toList();
      final String jsonString = jsonEncode(jsonList);
      AppCache.instance.prefs.setString(AppCache.areasKey, jsonString);
    }
  }

  List<Area>? getAreas() {
    final String? jsonString =
        AppCache.instance.prefs.getString(AppCache.areasKey);
    if (jsonString == null) {
      return null;
    }
    final List<dynamic> decodedList = jsonDecode(jsonString);
    return decodedList
        .map((json) => Area.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
