import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../config/config.dart'; // Import konfigurasi API
import '../models/pos_data.dart';
import '../models/StationModel.dart';

class ApiService {
  final String baseUrl = Config.baseUrl; // Ambil dari config

  // Fungsi untuk membuat header autentikasi
  Map<String, String> _getHeaders() {
    final String credentials = base64Encode(utf8.encode('${Config.username}:${Config.password}'));
    return {
      "Authorization": "Basic $credentials",
      "Content-Type": "application/json",
    };
  }

  // Method untuk mengambil data Station
  Future<List<Station>> fetchStations() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/stations"),
        headers: _getHeaders(),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Station.fromJson(json)).toList();
      } else {
        throw Exception("Gagal memuat data, status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat mengambil data Station: $e");
    }
  }

  // Method untuk mengambil data POS
  Future<List<PosData>> fetchPosData() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/data"),
        headers: _getHeaders(),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        if (jsonData.length < 7) {
          throw Exception("Data API tidak lengkap");
        }

        return [
          PosData.fromJson(jsonData[0], Icons.water_drop, Colors.blue),
          PosData.fromJson(jsonData[1], Icons.umbrella, Colors.lightBlue),
          PosData.fromJson(jsonData[2], Icons.cloud, Colors.amber),
          PosData.fromJson(jsonData[3], Icons.wifi, Colors.green),
          PosData.fromJson(jsonData[4], Icons.cancel, Colors.red),
          PosData.fromJson(jsonData[5], Icons.place, Colors.purple),
          PosData.fromJson(jsonData[6], Icons.apartment, Colors.brown),
        ];
      } else {
        throw Exception("Gagal mengambil data dari API, status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat mengambil data POS: $e");
    }
  }
}
