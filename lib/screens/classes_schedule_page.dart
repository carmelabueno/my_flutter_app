import 'package:flutter/material.dart';

import '../widgets/hoverable_card.dart';
import '../widgets/watermark_background.dart';

class ClassesSchedulePage extends StatelessWidget {
  const ClassesSchedulePage({super.key});

  final List<Map<String, String>> courses = const [
    {
      'code': 'CS 301',
      'desc': 'Automata Theory and Formal Language',
      'lab': '',
      'units': '3',
      'hours': '3',
      'days': 'Tue / Thu',
      'time': '2:00 PM - 3:00 PM',
      'room': 'Room 103',
    },
    {
      'code': 'CS 302',
      'desc': 'Software Engineering 1',
      'lab': '1',
      'units': '2/1',
      'hours': ' 5',
      'days': 'Tue / Thu',
      'time': '10:00 AM - 12:00 NN',
      'room': 'Room 103',
    },
    {
      'code': 'CS 303',
      'desc': 'Application Development and Emerging Technologies',
      'lab': '1',
      'units': '2/1',
      'hours': '5',
      'days': 'Mon',
      'time': '1:00 PM - 5:00 PM',
      'room': 'ComLab 2',
    },
    {
      'code': 'CS 304',
      'desc': 'Foundation of Artificial Intelligence',
      'lab': '1',
      'units': '2/1',
      'hours': '5',
      'days': 'Tue / Thu',
      'time': '8:00 AM - 10:00 AM',
      'room': 'ComLab 1',
    },
    {
      'code': 'CS 305',
      'desc': 'Introduction to Cryptography and Information Security',
      'lab': '1',
      'units': '2/1',
      'hours': '5',
      'days': 'Monday',
      'time': '8:00 AM - 12:00 NN',
      'room': 'ComLab 3',
    },
    {
      'code': 'CS 306',
      'desc': 'Professional Elective 1',
      'lab': '1',
      'units': '2/1',
      'hours': '5',
      'days': 'Tue / Thu',
      'time': '3:00 PM - 5:00 PM',
      'room': 'ComLab 2',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Classes & Schedule', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: WatermarkBackground(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final item = courses[index];
            return HoverableCard(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFA5D6A7),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['code']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B5E20),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green.shade600),
                          ),
                          child: Text(
                            '${item['units']} Units',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['desc']!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const Divider(height: 24),
                        Row(
                          children: [
                            Expanded(child: Text('Lab: ${item['lab']} hr(s)', style: const TextStyle(color: Colors.black87))),
                            Expanded(child: Text('Total Hours: ${item['hours']} hrs/wk', style: const TextStyle(color: Colors.black87))),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(child: Text('Days: ${item['days']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87))),
                            Expanded(child: Text('Time: ${item['time']}', style: const TextStyle(color: Colors.black87))),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Room: ${item['room']}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}