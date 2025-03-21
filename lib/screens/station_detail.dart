import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobilehigertech/models/StationModel.dart';

class StationDetailPage extends StatelessWidget {
  final Station station;

  const StationDetailPage({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final double latitude = station.latitude ?? -6.200000;
    final double longitude = station.longitude ?? 106.816666;

    return Scaffold(
      appBar: AppBar(title: Text(station.balaiName)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(station.balaiName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 6),
            Text("Provinsi: ${station.provinceName}", style: const TextStyle(fontSize: 16)),
            if (station.awlrLastReading != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text("Ketinggian Air: ${station.awlrLastReading!.waterLevel?.toStringAsFixed(2) ?? 'N/A'} m"),
                  Text("Status: ${station.awlrLastReading!.warningStatus}"),
                  Text("Perangkat: ${station.awlrLastReading!.deviceStatus}"),
                ],
              ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(latitude, longitude),
                    zoom: 12,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(station.balaiName),
                      position: LatLng(latitude, longitude),
                      infoWindow: InfoWindow(title: station.balaiName),
                    ),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
