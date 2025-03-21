import '../lib/services/api_service.dart';
import '../lib/models/StationModel.dart';

class StationRepository {
  final ApiService _apiService = ApiService();

  Future<List<Station>> getStations() async {
    return await _apiService.fetchStations();
  }
}
