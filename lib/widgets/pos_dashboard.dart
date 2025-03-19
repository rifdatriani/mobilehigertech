import 'package:flutter/material.dart';
import '../models/pos_data.dart';

class PosDashboard extends StatelessWidget {
  final Future<List<PosData>> futurePosData;

  const PosDashboard({super.key, required this.futurePosData});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PosData>>(
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
    );
  }

  Widget buildGridItem(PosData data) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data.icon, color: data.color),
          Text(data.title),
          Text("${data.count}"),
        ],
      ),
    );
  }
}
