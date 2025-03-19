import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/api_service.dart';
import '../models/StationModel.dart';
import '../screens/auth/logout/logout.dart';
import '../models/pos_data.dart';
import '../widgets/installation_info.dart';
import '../widgets/pos_dashboard.dart'; // Import PosDashboard

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  late Future<List<Station>> futureStations;
  late Future<List<PosData>> futurePosData;
  final LatLng _initialPosition = const LatLng(-6.9175, 107.6191);

  @override
  void initState() {
    super.initState();
    futureStations = ApiService().fetchStations();
    futurePosData = ApiService().fetchPosData(); // Ambil data sekali saja di sini
  }

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
          IconButton(icon: const Icon(Icons.logout), onPressed: () => LogoutDialog.show(context)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Google Map
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 200,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Divider(thickness: 1, color: Colors.grey), // Garis pemisah

            // 🔴 Gunakan PosDashboard di sini
            PosDashboard(futurePosData: futurePosData),

            const SizedBox(height: 16),

            // 🔵 Informasi Instalasi
            InstallationInfo(futureStations: futureStations),
          ],
        ),
      ),
    );
  }
}
