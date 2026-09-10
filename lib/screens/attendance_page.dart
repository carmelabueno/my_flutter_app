import 'package:flutter/material.dart';

import '../models/student.dart';
import '../widgets/hoverable_card.dart';
import '../widgets/watermark_background.dart';

class AttendancePage extends StatelessWidget {
  final Student currentStudent;

  const AttendancePage({super.key, required this.currentStudent});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> classList = [
      {'id': 'A2024-1044', 'name': 'Abadilla, Gabriel', 'p': 29, 'a': 0, 'l': 1},
      {'id': 'A2024-1062', 'name': 'Abella, Christine Joy', 'p': 28, 'a': 1, 'l': 1},
      {'id': 'A2024-1032', 'name': 'Abrigo, Jencel', 'p': 30, 'a': 0, 'l': 0},
      {'id': 'A2024-1055', 'name': 'Averilla, Rhona Kim', 'p': 27, 'a': 2, 'l': 1},
      {'id': 'A2024-1049', 'name': 'Bueno, Carmela', 'p': 29, 'a': 1, 'l': 0},
      {'id': 'A2024-1061', 'name': 'Bueno, Ian Chester', 'p': 26, 'a': 3, 'l': 1},
      {'id': 'A2024-1046', 'name': 'Caagbay, Mark Vincent', 'p': 28, 'a': 1, 'l': 1},
      {'id': 'A2024-1041', 'name': 'Cabalsa, Andrei', 'p': 27, 'a': 2, 'l': 1},
      {'id': 'A2024-1036', 'name': 'Cabañas, Khrisbelle Ann', 'p': 30, 'a': 0, 'l': 0},
      {'id': 'A2024-1047', 'name': 'Cabuyao, Zyriah Mei', 'p': 25, 'a': 4, 'l': 1},
      {'id': 'A2024-1042', 'name': 'Cedeño, Jhun Zeiderick', 'p': 29, 'a': 1, 'l': 0},
      {'id': 'A2024-1035', 'name': 'Come, Josh Michael', 'p': 28, 'a': 0, 'l': 2},
      {'id': 'A2024-1050', 'name': 'Corpuz, Jenny Rose', 'p': 29, 'a': 1, 'l': 0},
      {'id': 'A2024-1063', 'name': 'Dael, Roselle Nicole', 'p': 27, 'a': 2, 'l': 1},
      {'id': 'A2024-1052', 'name': 'De Belen, Devin Rey', 'p': 28, 'a': 1, 'l': 1},
      {'id': 'A2024-1031', 'name': 'Esperanza, Harry', 'p': 30, 'a': 0, 'l': 0},
      {'id': 'A2024-1043', 'name': 'Gonzales, Rupert', 'p': 28, 'a': 1, 'l': 0},
      {'id': 'A2024-1070', 'name': 'Herrera, Glezel Aiko Nazareth', 'p': 26, 'a': 3, 'l': 1},
      {'id': 'A2024-1060', 'name': 'Lampas, Reymark', 'p': 29, 'a': 0, 'l': 1},
      {'id': 'A2024-1034', 'name': 'Laurio, Maricel', 'p': 27, 'a': 2, 'l': 1},
      {'id': 'A2024-1045', 'name': 'Luna, Renyl', 'p': 29, 'a': 1, 'l': 0},
      {'id': 'A2024-1039', 'name': 'Luyahan, Melanie', 'p': 28, 'a': 1, 'l': 1},
      {'id': 'A2024-1051', 'name': 'Magtibay, Franchin Anne', 'p': 30, 'a': 0, 'l': 0},
      {'id': 'A2024-1066', 'name': 'Naynes, Francis Angelo', 'p': 25, 'a': 4, 'l': 1},
      {'id': 'A2024-1069', 'name': 'Naynes, John Brave', 'p': 28, 'a': 1, 'l': 1},
      {'id': 'A2024-1033', 'name': 'Oribe, Mark Francis', 'p': 26, 'a': 3, 'l': 2},
      {'id': 'A2024-1056', 'name': 'Peralta, Camille Rose', 'p': 29, 'a': 1, 'l': 0},
      {'id': 'A2024-1065', 'name': 'Placino, Jhunel', 'p': 27, 'a': 2, 'l': 1},
      {'id': 'A2024-1058', 'name': 'Rey, Maria Mikylla', 'p': 30, 'a': 0, 'l': 0},
      {'id': 'A2024-1067', 'name': 'Reyes, Jonh Joren', 'p': 28, 'a': 1, 'l': 1},
      {'id': 'A2024-1075', 'name': 'Remo, Princess Lie Anne', 'p': 29, 'a': 0, 'l': 1},
      {'id': 'A2024-1053', 'name': 'Rocha, Rubylyn', 'p': 26, 'a': 3, 'l': 1},
      {'id': 'A2024-1057', 'name': 'Soreño, Alloha May', 'p': 28, 'a': 1, 'l': 1},
      {'id': 'A2024-1037', 'name': 'Tabernilla, Katelyn Claire', 'p': 27, 'a': 2, 'l': 1},
      {'id': 'A2024-1054', 'name': 'Tabernilla, Princess Hanna', 'p': 29, 'a': 1, 'l': 0},
      {'id': 'A2024-1064', 'name': 'Tañedo, Franz Charisse', 'p': 25, 'a': 4, 'l': 0},
      {'id': 'A2024-1048', 'name': 'Veluya, Katherine', 'p': 30, 'a': 0, 'l': 0},
      {'id': 'A2024-1059', 'name': 'Villania, Lewy Allen', 'p': 28, 'a': 1, 'l': 1},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Records', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: WatermarkBackground(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            HoverableCard(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.green.shade100,
                    child: const Icon(Icons.fact_check_outlined, size: 30, color: Color(0xFF1B5E20)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Section: ${currentStudent.yearAndSection}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Student: ${currentStudent.name}',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1B5E20)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Section 3A Class Roll', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Total Students: ${classList.length}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: classList.length,
              itemBuilder: (context, index) {
                final student = classList[index];
                final bool isYou = student['id'] == currentStudent.id;

                return HoverableCard(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: isYou ? Colors.amber.shade200 : Colors.green.shade100,
                          child: Icon(
                            isYou ? Icons.person : Icons.person_outline,
                            size: 20,
                            color: Colors.green.shade700,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isYou ? '${student['name']} (You)' : student['name'],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isYou ? FontWeight.bold : FontWeight.w600,
                                  color: isYou ? const Color(0xFF1B5E20) : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Text('ID: ${student['id']}', style: const TextStyle(fontSize: 10, color: Colors.black54)),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            _buildStatusBadge('P: ${student['p']}', Colors.green.shade50, const Color(0xFF1B5E20)),
                            const SizedBox(width: 4),
                            _buildStatusBadge('A: ${student['a']}', Colors.red.shade50, Colors.red.shade800),
                            const SizedBox(width: 4),
                            _buildStatusBadge('L: ${student['l']}', Colors.orange.shade50, Colors.orange.shade900),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor)),
    );
  }
}