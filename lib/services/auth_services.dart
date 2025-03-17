import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://example.com/api"; // Ganti dengan URL API-mu

  Future<bool> login(String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["status"] == "success"; // Jika login berhasil, return true
    } else {
      return false; // Jika gagal, return false
    }
  }
}
