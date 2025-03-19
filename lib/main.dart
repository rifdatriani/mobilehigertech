import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
// import 'screens/home_screen.dart';
//import 'config/config.dart';
// import 'services/api_service.dart';
// import 'models/StationModel.dart';

Future<void> main() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  // final apiService = ApiService();

  // try {
  //   final stations = await apiService.fetchStations();
  //   print("Data Stasiun: $stations");
  // } catch (e) {
  //   print("Gagal mengambil data: $e");
  // }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen Example',
      home: SplashScreen(), 
      // home: HomeScreen(),
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Future<List<Station>> futureStations;

//   @override
//   void initState() {
//     super.initState();
//     futureStations = ApiService().fetchStations();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text("Test API MonitoringStation")),
//         body: FutureBuilder<List<Station>>(
//           future: futureStations,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text("Error: ${snapshot.error}"));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return const Center(child: Text("Tidak ada data station."));
//             }

//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final station = snapshot.data![index];
//                 return ListTile(
//                   title: Text(station.name),
//                   subtitle: Text("Lokasi: ${station.location}"),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
