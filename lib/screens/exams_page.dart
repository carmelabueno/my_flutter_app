import 'package:flutter/material.dart';

import '../widgets/hoverable_card.dart';
import '../widgets/watermark_background.dart';

class ExamsPage extends StatelessWidget {
  const ExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exams & Results', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: WatermarkBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Midterm & Final Examination Schedule',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildExamCard(
              course: 'CS 205 - Analysis of Algorithms',
              timeStart: '08:00 AM',
              timeEnd: '10:00 AM',
              date: 'Oct 29, 2026',
              items: 60,
              score: '54 / 60',
              status: 'Completed',
            ),
            _buildExamCard(
              course: 'CS 302 - Computer Networks',
              timeStart: '10:30 AM',
              timeEnd: '12:30 PM',
              date: 'Nov 03, 2026',
              items: 50,
              score: 'Pending',
              status: 'Upcoming',
            ),
            _buildExamCard(
              course: 'CS 310 - Operating Systems',
              timeStart: '01:30 PM',
              timeEnd: '03:30 PM',
              date: 'Nov 05, 2026',
              items: 50,
              score: 'Pending',
              status: 'Upcoming',
            ),
            _buildExamCard(
              course: 'CS 101 - Discrete Mathematics',
              timeStart: '08:00 AM',
              timeEnd: '10:00 AM',
              date: 'Sep 15, 2026',
              items: 100,
              score: '92 / 100',
              status: 'Completed',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamCard({
    required String course,
    required String timeStart,
    required String timeEnd,
    required String date,
    required int items,
    required String score,
    required String status,
  }) {
    final bool isCompleted = status == 'Completed';

    return HoverableCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  course,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? Colors.green.shade50
                        : Colors.amber.shade50,
                    border: Border.all(
                      color: isCompleted ? const Color(0xFFA5D6A7) : const Color(0xFFFFE082),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? const Color(0xFF1B5E20) : Colors.amber.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.black54),
                const SizedBox(width: 4),
                Text('Date: $date', style: const TextStyle(fontSize: 12, color: Colors.black87)),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 14, color: Colors.black54),
                const SizedBox(width: 4),
                Text('$timeStart - $timeEnd', style: const TextStyle(fontSize: 12, color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Items: $items', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                Text(
                  'Score: $score',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? const Color(0xFF1B5E20) : Colors.black54,
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