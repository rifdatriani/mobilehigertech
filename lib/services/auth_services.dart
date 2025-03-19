import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart'; // Import file config.dart

class AuthService {
  Future<bool> login() async {
    try {
      final response = await http.post(
        Uri.parse("${Config.baseUrl}/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": Config.username,
          "password": Config.password,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["status"] == "success";
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat login: $e");
    }
  }
}
