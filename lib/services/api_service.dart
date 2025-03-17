import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/models/StationModel.dart'; // Model untuk menyimpan data

class ApiService {
  final String baseUrl = "https://example.com/api"; // Ganti dengan URL API yang benar

  Future<List<Station>> fetchStations() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/stations"));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Station.fromJson(json)).toList();
      } else {
        throw Exception("Gagal memuat data, status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan: $e");
    }
  }
}
