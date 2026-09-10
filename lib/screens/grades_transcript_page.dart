import 'package:flutter/material.dart';

import '../widgets/hoverable_card.dart';
import '../widgets/watermark_background.dart';

class GradesTranscriptPage extends StatelessWidget {
  const GradesTranscriptPage({super.key});

  final List<Map<String, dynamic>> grades = const [
    {'code': 'CS 301', 'desc': 'Automata Theory and Formal Language', 'units': '3', 'grade': '1.25'},
    {'code': 'CS 302', 'desc': 'Software Engineering 1', 'units': '3', 'grade': '1.50'},
    {'code': 'CS 303', 'desc': 'Application Development and Emerging Technologies', 'units': '3', 'grade': '1.50'},
    {'code': 'CS 304', 'desc': 'Foundation of Artificial Intelligence', 'units': '3', 'grade': '1.25'},
    {'code': 'CS 305', 'desc': 'Introduction to Cryptography and Information Security', 'units': '3', 'grade': '1.25'},
    {'code': 'CS 306', 'desc': 'Professional Elective 1', 'units': '3', 'grade': '1.50'},
  ];

  double _calculateGWA() {
    double totalPoints = 0;
    double totalUnits = 0;
    for (var item in grades) {
      double u = double.tryParse(item['units'].toString()) ?? 0.0;
      double g = double.tryParse(item['grade'].toString()) ?? 0.0;

      totalPoints += (u * g);
      totalUnits += u;
    }
    return totalUnits == 0 ? 0.0 : totalPoints / totalUnits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grades & Transcript', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: WatermarkBackground(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            HoverableCard(
              padding: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.lightGreen.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'General Weighted Average (GWA)',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1B5E20)),
                    ),
                    Text(
                      _calculateGWA().toStringAsFixed(2),
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...grades.map((item) {
              return HoverableCard(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item['code']} - ${item['desc']}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Units: ${(double.tryParse(item['units'].toString()) ?? 0).toInt()}',
                            style: const TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFA5D6A7)),
                      ),
                      child: Text(
                        (double.tryParse(item['grade'].toString()) ?? 0.0).toStringAsFixed(2),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5E20),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}