import 'dart:developer';

import 'package:blnk_task/data_source/governorate_data.dart';
import 'package:blnk_task/models/address/area.dart';
import 'package:blnk_task/models/address/governorate.dart';
import 'package:blnk_task/util/cache/governorate_cache.dart';

abstract class IAppRepository {
  Future<List<Governorate>> getGovernorates();
  Future<List<Area>> getAllAreas();
}

class AppRepository implements IAppRepository {
  AppRepository._internal({required this.dataSource});

  static final AppRepository _instance =
      AppRepository._internal(dataSource: RemoteAppDataSource.instance);

  static AppRepository get instance => _instance;

  final IAppDataSource dataSource;

  @override
  Future<List<Governorate>> getGovernorates() async {
    try {
      List<Governorate>? cachedGovernorates =
          LocationCache.instance.getGovernorates();
      if (cachedGovernorates != null) {
        log("returning cached cities");
        return cachedGovernorates;
      } else {
        List<Governorate> governorates = await dataSource.fetchGovernorates();
        LocationCache.instance.setGovernorates(governorates);
        return governorates;
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Repository error getting governorates: $e');
    }
  }

  @override
  Future<List<Area>> getAllAreas() async {
    try {
      List<Area>? cachedAreas = LocationCache.instance.getAreas();
      if (cachedAreas != null) {
        log("returning cached areas");
        return cachedAreas;
      } else {
        List<Area> areas = await dataSource.fetchAreas();
        LocationCache.instance.setAreas(areas);
        return areas;
      }
    } catch (e) {
      throw Exception('Repository error getting areas: $e');
    }
  }
}
