import 'package:flutter/material.dart';

import '../widgets/hoverable_card.dart';
import '../widgets/watermark_background.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CS Department Events', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: WatermarkBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Upcoming CS & IT Events',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildEventCard(
              month: 'OCT',
              day: '24',
              dayName: 'Fri',
              title: 'IT & CS Exhibition 2026',
              description: 'Showcase of capstone projects and software demos.',
              time: '10:00 AM - 01:00 PM',
              location: 'School Auditorium',
            ),
            _buildEventCard(
              month: 'OCT',
              day: '28',
              dayName: 'Tue',
              title: 'CS Society General Meeting',
              description: 'Discussion for upcoming Hackathon and Org Officers Election.',
              time: '02:00 PM - 04:00 PM',
              location: 'Room 103 (IT Lab)',
            ),
            _buildEventCard(
              month: 'NOV',
              day: '05',
              dayName: 'Thu',
              title: 'Algorithmic Coding Challenge',
              description: 'Annual competitive programming contest for CS students.',
              time: '09:00 AM - 03:00 PM',
              location: 'Computer Lab 2',
            ),
            _buildEventCard(
              month: 'NOV',
              day: '18',
              dayName: 'Wed',
              title: 'Web & AI Tech Seminar',
              description: 'Guest lecture on Modern JavaScript Frameworks and AI tools.',
              time: '01:00 PM - 04:00 PM',
              location: 'AVR Center',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard({
    required String month,
    required String day,
    required String dayName,
    required String title,
    required String description,
    required String time,
    required String location,
  }) {
    return HoverableCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(month, style: const TextStyle(fontSize: 11, color: Color(0xFF1B5E20), fontWeight: FontWeight.bold)),
                Text(day, style: const TextStyle(fontSize: 20, color: Color(0xFF1B5E20), fontWeight: FontWeight.bold)),
                Text(dayName, style: const TextStyle(fontSize: 10, color: Color(0xFF1B5E20))),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(location, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}