import 'package:flutter/material.dart';
import '../lib/models/StationModel.dart';
import '../lib/services/api_service.dart'; // Pastikan ada file untuk ambil data dari API

class StationController extends ChangeNotifier {
  List<Station> _stations = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Station> get stations => _stations;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchStations() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _stations = await ApiService.getStations(); // Ambil data dari API
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
