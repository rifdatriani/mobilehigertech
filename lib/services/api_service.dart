import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart'; // Konfigurasi API
import '../models/pos_data.dart';
import 'package:flutter/material.dart';
import '../models/StationModel.dart';

class ApiService {
  final String baseUrl = Config.baseUrl;

  // Membuat header autentikasi
  Map<String, String> _getHeaders() {
    final String credentials = base64Encode(utf8.encode('${Config.username}:${Config.password}'));
    return {
      "Authorization": "Basic $credentials",
      "Content-Type": "application/json",
    };
  }

  // Mengambil daftar Station
  Future<List<Station>> fetchStations() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/Station/All"),
        headers: _getHeaders(),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);

        if (data is List) {
          return data.map((json) => Station.fromJson(json)).toList();
        } else if (data is Map<String, dynamic>) {
          return [Station.fromJson(data)];
        } else {
          throw Exception("Format data API tidak sesuai");
        }
      } else {
        throw Exception("Gagal memuat data Station, status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat mengambil data Station: $e");
    }
  }

  // Mengambil detail Station berdasarkan ID
  Future<Station> fetchStationById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/Station/$id"),
        headers: _getHeaders(),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        if (jsonData is Map<String, dynamic>) {
          return Station.fromJson(jsonData);
        } else {
          throw Exception("Format data detail Station tidak sesuai");
        }
      } else {
        throw Exception("Gagal memuat detail Station, status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat mengambil detail Station: $e");
    }
  }

  // Mengambil data POS
  Future<List<PosData>> fetchPosData() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/data"),
        headers: _getHeaders(),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);

        if (jsonData is! List || jsonData.length < 7) {
          throw Exception("Data API tidak lengkap atau format salah");
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
        throw Exception("Gagal mengambil data POS, status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat mengambil data POS: $e");
    }
  }

  static getStations() {}
}
