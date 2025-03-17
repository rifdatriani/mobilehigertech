class Station {
  final String name;
  final int wifiOn;
  final int wifiOff;
  final int electrical;

  Station({
    required this.name,
    required this.wifiOn,
    required this.wifiOff,
    required this.electrical,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      name: json['name'],
      wifiOn: json['wifi_on'],
      wifiOff: json['wifi_off'],
      electrical: json['electrical'],
    );
  }
}
