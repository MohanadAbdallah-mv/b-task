import 'dart:developer';

import 'package:blnk_task/models/address/area.dart';
import 'package:blnk_task/models/address/governorate.dart';
import 'package:blnk_task/repositories/governorate_repo.dart';
import 'package:flutter/material.dart';

class GovernorateProvider extends ChangeNotifier {
  List<Governorate> _governorates = [];
  List<Governorate> get governorates => _governorates;

  List<Area> _allAreas = [];
  List<Area> get allAreas => _allAreas;

  Governorate? _selectedGovernorate;
  Governorate? get selectedGovernorate => _selectedGovernorate;

  Area? _selectedArea;
  Area? get selectedArea => _selectedArea;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  /// Returns areas filtered by the currently selected governorate.
  List<Area> get filteredAreas {
    if (_selectedGovernorate == null) {
      return []; // No governorate selected, no areas to show
    }
    return _allAreas
        .where((area) => area.governorateId == _selectedGovernorate!.id)
        .toList();
  }

  /// Fetches all governorates and all areas upfront.
  Future<void> loadLocations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Fetch both governorates and areas concurrently
      if (_governorates.isEmpty && _allAreas.isEmpty) {
        final results = await Future.wait([
          AppRepository.instance.getGovernorates(),
          AppRepository.instance.getAllAreas(),
        ]);
        log("checking if empty before adding new ");
        _governorates = results[0] as List<Governorate>;
        _allAreas = results[1] as List<Area>;
      }
      if (_governorates.isNotEmpty && _selectedGovernorate == null) {
        _selectedGovernorate = _governorates.first;
      }

      if (_selectedGovernorate == null ||
          !filteredAreas.contains(_selectedArea)) {
        _selectedArea = null;
      }

      _error = null;
    } catch (e) {
      log(e.toString());
      _error = e.toString();
      _governorates = [];
      _allAreas = [];
      _selectedGovernorate = null;
      _selectedArea = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sets the selected governorate and notifies listeners.
  void setSelectedGovernorate(Governorate? governorate) {
    _selectedGovernorate = governorate;
    _selectedArea =
        filteredAreas[0]; // Reset selected area when governorate changes
    notifyListeners(); // Rebuild UI to show filtered areas
  }

  /// Sets the selected area and notifies listeners.
  void setSelectedArea(Area? area) {
    _selectedArea = area;
    notifyListeners();
  }
}
