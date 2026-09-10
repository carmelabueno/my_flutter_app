import 'package:flutter/material.dart';

import '../models/student.dart';
import '../widgets/hoverable_card.dart';
import '../widgets/watermark_background.dart';

class ProfilePage extends StatelessWidget {
  final Student currentStudent;

  const ProfilePage({super.key, required this.currentStudent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: WatermarkBackground(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green.shade100,
                    child: const Icon(
                      Icons.person,
                      size: 45,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    currentStudent.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Student ID: ${currentStudent.id}',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildProfileDetailCard('Program', currentStudent.program, Icons.school_outlined),
            _buildProfileDetailCard('Year & Section', currentStudent.yearAndSection, Icons.class_outlined),
            _buildProfileDetailCard('Birthday', currentStudent.birthday, Icons.cake_outlined),
            _buildProfileDetailCard('Email Address', currentStudent.email, Icons.email_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetailCard(String label, String value, IconData icon) {
    return HoverableCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF1B5E20), size: 24),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}