import 'dart:convert';
import 'dart:developer';

import 'package:blnk_task/models/address/area.dart';
import 'package:blnk_task/models/address/governorate.dart';
import 'package:http/http.dart' as http;

abstract class IAppDataSource {
  Future<List<Governorate>> fetchGovernorates();
  Future<List<Area>> fetchAreas();
}

class RemoteAppDataSource implements IAppDataSource {
  RemoteAppDataSource._internal();

  static final RemoteAppDataSource _instance = RemoteAppDataSource._internal();

  static RemoteAppDataSource get instance => _instance;

  final String _governoratesUrl =
      'https://raw.githubusercontent.com/Tech-Labs/egypt-governorates-and-cities-db/master/governorates.json';

  final String _areasUrl =
      'https://raw.githubusercontent.com/Tech-Labs/egypt-governorates-and-cities-db/master/cities.json';

  @override
  Future<List<Governorate>> fetchGovernorates() async {
    try {
      final response = await http.get(Uri.parse(_governoratesUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final List<dynamic> rawGovernorates =
            jsonList[2]['data'] as List<dynamic>;

        final List<Governorate> gList =
            rawGovernorates.map((json) => Governorate.fromJson(json)).toList();
        return gList;
      } else {
        throw Exception('Failed to load governorates: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching governorates: $e');
    }
  }

  @override
  Future<List<Area>> fetchAreas() async {
    try {
      final response = await http.get(Uri.parse(_areasUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final List<dynamic> rawAreas = jsonList[2]['data'] as List<dynamic>;
        final List<Area> aList =
            rawAreas.map((json) => Area.fromJson(json)).toList();
        return aList;
      } else {
        throw Exception('Failed to load areas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching areas: $e');
    }
  }
}
