import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/api_service.dart';
import '../services/models/StationModel.dart';
import '../screens/auth/logout/logout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  late Future<List<Station>> futureStations;

  // Koordinat awal (Bandung)
  final LatLng _initialPosition = const LatLng(-6.9175, 107.6191);

  @override
  void initState() {
    super.initState();
    futureStations = ApiService().fetchStations();
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
              // Tambahkan fungsi logout di sini
              LogoutDialog.show(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(height: 4.0),
              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 8),

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
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                },
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
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),

              // Informasi Instalasi dari API
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Informasi Instalasi",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                          children: snapshot.data!
                              .map((station) => _buildStationCard(station))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
          Text(
            station.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(children: [const Icon(Icons.wifi), Text(" ${station.wifiOn}")]),
              Row(children: [const Icon(Icons.wifi_off), Text(" ${station.wifiOff}")]),
              Row(children: [const Icon(Icons.electrical_services), Text(" ${station.electrical}")]),
            ],
          ),
        ],
      ),
    );
  }
}
