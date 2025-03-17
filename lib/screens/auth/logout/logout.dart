import 'package:flutter/material.dart';
import 'package:mobilehigertech/screens/auth/loginscreen.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Logout"),
        content: const Text("Apakah Anda yakin ingin logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _logout(context);
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  static void _logout(BuildContext context) {
    // Tambahkan logika untuk logout, misalnya menghapus sesi pengguna
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove('user_token');

    // Navigasi ke LoginScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false, // Hapus semua rute sebelumnya
    );
  }
}
