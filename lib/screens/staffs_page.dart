import 'package:flutter/material.dart';

import '../widgets/hoverable_card.dart';
import '../widgets/watermark_background.dart';

class StaffsPage extends StatelessWidget {
  const StaffsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty & Staff Directory', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: WatermarkBackground(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Department Leadership',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            HoverableCard(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.green.shade100,
                      child: const Icon(Icons.school, size: 36, color: Color(0xFF1B5E20)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'PROGRAM CHAIRPERSON, BACHELOR OF SCIENCE IN COMPUTER SCIENCE',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Dr. Maria Cecilia G. Cantos',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Course: CS 401 - Advanced Software Engineering',
                            style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Email: m.cantos@sti.edu.ph',
                            style: TextStyle(fontSize: 11, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'CS Department Professors',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            _buildProfessorCard(
              name: 'Prof. Lawrence Kristofer A. Rea',
              course: 'CS 301 - Automata Theory and Formal Language',
              email: 'l.rea@sti.edu.ph',
            ),
            _buildProfessorCard(
              name: 'Prof. Marinella C. Lacorte',
              course: 'CS 302 - Software Engineering 1',
              email: 'e.lacorte@sti.edu.ph',
            ),
            _buildProfessorCard(
              name: 'Prof. Alexandreate Jenedick A. Naynes ',
              course: 'CS 303 - Application Development and Emerging Technologies',
              email: 'a.naynes@sti.edu.ph',
            ),
            _buildProfessorCard(
              name: 'Prof. Jake Patrick G. Reyes ',
              course: 'CS 304 - Foundations of Artificial Intelligence',
              email: 'j.reyes@sti.edu.ph',
            ),
            _buildProfessorCard(
              name: 'Prof. Dan Wilbert R. Rodriguez ',
              course: 'CS 305 - Introduction to Cryptography and Information Security',
              email: 'd.rodriguez@sti.edu.ph',
            ),
            _buildProfessorCard(
              name: 'Prof. Gellian Iris O. Baasis',
              course: 'CS 306 - Professional Elective 1',
              email: 'g.baasis@sti.edu.ph',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessorCard({
    required String name,
    required String course,
    required String email,
  }) {
    return HoverableCard(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.green.shade100,
              child: const Icon(Icons.person_outline, size: 26, color: Color(0xFF1B5E20)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.book_outlined, size: 12, color: Colors.black54),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          course,
                          style: const TextStyle(fontSize: 12, color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.email_outlined, size: 12, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text(
                        email,
                        style: const TextStyle(fontSize: 11, color: Colors.black54),
                      ),
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