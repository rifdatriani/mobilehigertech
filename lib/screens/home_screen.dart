import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../services/api_service.dart';
import '../services/models/StationModel.dart';
import '../screens/auth/logout/logout.dart';

// Model untuk data Pos
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
      title: json['title'],
      count: json['count'],
      icon: icon,
      color: color,
    );
  }
}

// HomeScreen yang mencakup peta, grid dashboard, dan informasi instalasi
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  late Future<List<Station>> futureStations;
  late Future<List<PosData>> futurePosData;

  // Koordinat awal (Bandung)
  final LatLng _initialPosition = const LatLng(-6.9175, 107.6191);
  
  @override
  void initState() {
    super.initState();
    futureStations = ApiService().fetchStations();
    futurePosData = fetchPosData();
  }

  // Fetch Data untuk Pos
  Future<List<PosData>> fetchPosData() async {
    final response = await http.get(Uri.parse('https://api.example.com/data')); // Ganti dengan API-mu
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return [
        PosData.fromJson(jsonData[0], Icons.water_drop, Colors.blue), // Pos Duga Air
        PosData.fromJson(jsonData[1], Icons.umbrella, Colors.lightBlue), // Pos Curah Hujan
        PosData.fromJson(jsonData[2], Icons.cloud, Colors.amber), // Pos Klimatologi
        PosData.fromJson(jsonData[3], Icons.wifi, Colors.green), // Total Online
        PosData.fromJson(jsonData[4], Icons.cancel, Colors.red), // Total Offline
        PosData.fromJson(jsonData[5], Icons.place, Colors.purple), // Total POS
        PosData.fromJson(jsonData[6], Icons.apartment, Colors.brown), // Total Instansi
      ];
    } else {
      throw Exception("Gagal mengambil data dari API");
    }
  }

  // Fungsi ketika peta dibuat
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/higertech.png', height: 50),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              LogoutDialog.show(context);
            },
          ),
        ],
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Google Maps dengan border radius
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 200,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 8),

            // GridView Dashboard (Data POS)
            FutureBuilder<List<PosData>>(
              future: futurePosData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Tidak ada data tersedia"));
                }

                List<PosData> posData = snapshot.data!;

                return Column(
                  children: [
                    // GridView pertama (3 kolom)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 117.49 / 72.94,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) => buildGridItem(posData[index]),
                    ),
                    const SizedBox(height: 8),
                    // GridView kedua (4 kolom)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 84.72 / 57.18,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) => buildGridItem(posData[index + 3]),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),

            // Informasi Instalasi dari API
            _buildInstallationInfo(),
          ],
        ),
      ),
    );
  }

  // Informasi Instalasi dari API
  Widget _buildInstallationInfo() {
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
          // Search Bar
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

          // Fetch dan tampilkan data instalasi dari API
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

              return Column(
                children: snapshot.data!.map((station) => _buildStationCard(station)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStationCard(Station station) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(station.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget buildGridItem(PosData data) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(data.icon, color: data.color), Text(data.title), Text("${data.count}")],
      ),
    );
  }
}
