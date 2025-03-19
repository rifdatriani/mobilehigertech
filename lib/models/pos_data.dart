import 'package:flutter/material.dart';

class PosData {
  final String title;
  final int count;
  final IconData icon;
  final Color color;

  PosData({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  factory PosData.fromJson(Map<String, dynamic> json, IconData icon, Color color) {
    return PosData(
      title: json['title'] ?? 'Unknown', // ✅ Default jika null
      count: json['count'] ?? 0, // ✅ Default jika null
      icon: icon,
      color: color,
    );
  }

  // ✅ Perbaikan getter
  String get name => title; // Mengambil nilai dari title
  int get value => count; // Mengambil nilai dari count
}
