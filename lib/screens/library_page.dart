import 'package:flutter/material.dart';

import '../widgets/hoverable_card.dart';
import '../widgets/watermark_background.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Resources Library', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: WatermarkBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // --- NEW RESOURCES SECTION ---
            Row(
              children: const [
                Icon(Icons.new_releases, color: Color(0xFF1B5E20), size: 20),
                SizedBox(width: 6),
                Text(
                  'Newly Uploaded Resources',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),

            _buildResourceCard(
              title: 'Cisco IOS Command Cheat Sheet PDF',
              course: 'CS 302 - Computer Networks',
              uploadedDate: 'Uploaded Today',
              type: 'PDF Guide',
              isNew: true,
            ),
            _buildResourceCard(
              title: 'Sorting Algorithms & Big-O Notation Slides',
              course: 'CS 205 - Analysis of Algorithms',
              uploadedDate: 'Uploaded Yesterday',
              type: 'E-Book / Slides',
              isNew: true,
            ),

            const SizedBox(height: 20),

            // --- COURSE RESOURCES SECTION ---
            const Text(
              'Course References & Textbooks',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _buildResourceCard(
              title: 'Introduction to Algorithms (4th Edition)',
              course: 'CS 205 - Analysis of Algorithms',
              uploadedDate: 'Added Oct 01, 2026',
              type: 'Textbook PDF',
            ),
            _buildResourceCard(
              title: 'Linux Terminal & CLI Reference Manual',
              course: 'CS 310 - Operating Systems',
              uploadedDate: 'Added Sep 20, 2026',
              type: 'Documentation',
            ),
            _buildResourceCard(
              title: 'JavaScript ES6+ Modern Reference Guide',
              course: 'CS 208 - Web Development',
              uploadedDate: 'Added Sep 15, 2026',
              type: 'E-Book',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceCard({
    required String title,
    required String course,
    required String uploadedDate,
    required String type,
    bool isNew = false,
  }) {
    return HoverableCard(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isNew ? Colors.green.shade100 : Colors.amber.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.menu_book,
                color: isNew ? const Color(0xFF1B5E20) : Colors.black54,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isNew) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(course, style: const TextStyle(fontSize: 11, color: Colors.black87)),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(type, style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w600)),
                      const Text(' • ', style: TextStyle(fontSize: 10, color: Colors.black54)),
                      Text(uploadedDate, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}