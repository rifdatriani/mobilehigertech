import 'package:flutter/material.dart';
import 'package:mobilehigertech/models/StationModel.dart';
import 'package:mobilehigertech/screens/station_detail.dart';
import 'package:mobilehigertech/services/api_service.dart';

class InstallationInfo extends StatelessWidget {
  final Future<List<Station>> futureStations;

  const InstallationInfo({super.key, required this.futureStations});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Informasi Instalasi", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: const [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.search),
              ],
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<Station>>(
            future: futureStations,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("Tidak ada data"));
              }

              List<Station> stations = snapshot.data!;

              return Expanded(
                child: ListView.builder(
                  itemCount: stations.length,
                  itemBuilder: (context, index) {
                    Station station = stations[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(station.balaiName),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Navigasi ke halaman detail saat diklik
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StationDetailPage(station: station),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
