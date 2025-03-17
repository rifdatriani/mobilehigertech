import 'package:flutter/material.dart';

class Station {
  final String name;
  final int wifiOn;
  final int wifiOff;
  final int electrical;
  final String? title;
  final int? count;
  final IconData? icon;
  final Color? color;

  Station({
    required this.name,
    required this.wifiOn,
    required this.wifiOff,
    required this.electrical,
    this.title,
    this.count,
    this.icon,
    this.color,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      name: json['name'],
      wifiOn: json['wifi_on'],
      wifiOff: json['wifi_off'],
      electrical: json['electrical'],
      title: json.containsKey('title') ? json['title'] : null,
      count: json.containsKey('count') ? json['count'] : null,
      icon: json.containsKey('icon') ? Icons.info : null, // Default icon
      color: json.containsKey('color') ? Colors.grey : null, // Default color
    );
  }
}
