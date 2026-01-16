import 'package:flutter/material.dart';

class LocationUI extends StatefulWidget {
  const LocationUI({super.key});

  @override
  State<LocationUI> createState() => _LocationUIState();
}

class _LocationUIState extends State<LocationUI> {
  String origin = "Fayzabad";
  String destination = "Jur";

  void swapLocation() {
    setState(() {
      final temp = origin;
      origin = destination;
      destination = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  locationCard(title: "Origin", value: origin),
                  const SizedBox(height: 2),
                  locationCard(title: "Destination", value: destination),
                ],
              ),

              /// Swap Button
              Positioned(
                right: 8,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.swap_vert, color: Colors.white),
                    onPressed: swapLocation,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget locationCard({required String title, required String value}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            const Icon(Icons.directions_bus, color: Colors.deepPurple),
            const SizedBox(width: 12),

            /// Text Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
