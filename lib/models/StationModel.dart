class Station {
  final String id;
  final String balaiName;
  final double? latitude;
  final double? longitude;
  final String provinceName;
  final AwlrLastReading? awlrLastReading;

  Station({
    required this.id,
    required this.balaiName,
    this.latitude,
    this.longitude,
    required this.provinceName,
    this.awlrLastReading,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json["id"]?.toString() ?? "",  // Pastikan id tidak null
      balaiName: json["balaiName"] ?? "Tidak ada nama",
      latitude: json["latitude"] != null ? (json["latitude"] as num).toDouble() : null,
      longitude: json["longitude"] != null ? (json["longitude"] as num).toDouble() : null,
      provinceName: json["provinceName"] ?? "Tidak diketahui",
      awlrLastReading: json["awlrLastReading"] != null
          ? AwlrLastReading.fromJson(json["awlrLastReading"])
          : null,
    );
  }
}

class AwlrLastReading {
  final double? waterLevel;
  final String warningStatus;
  final String deviceStatus;

  AwlrLastReading({
    this.waterLevel,
    required this.warningStatus,
    required this.deviceStatus,
  });

  factory AwlrLastReading.fromJson(Map<String, dynamic> json) {
    return AwlrLastReading(
      waterLevel: json["waterLevel"] != null ? (json["waterLevel"] as num).toDouble() : null,
      warningStatus: json["warningStatus"] ?? "Tidak diketahui",
      deviceStatus: json["deviceStatus"] ?? "Tidak diketahui",
    );
  }
}
