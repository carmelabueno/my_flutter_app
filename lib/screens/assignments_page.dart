import 'package:flutter/material.dart';

import '../widgets/hoverable_card.dart';
import '../widgets/watermark_background.dart';

class AssignmentsPage extends StatelessWidget {
  const AssignmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Assignments', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF1B5E20),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Submitted'),
            ],
          ),
        ),
        body: WatermarkBackground(
          child: TabBarView(
            children: [
              // TAB 1: UPCOMING ASSIGNMENTS
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildAssignmentCard(
                    title: 'Bubble Sort Complexity Paper',
                    course: 'CS 205 - Analysis of Algorithms',
                    dueDate: 'Due: Oct 28, 2026 - 11:59 PM',
                    status: 'Pending',
                    statusColor: Colors.orange,
                  ),
                  _buildAssignmentCard(
                    title: 'Cisco Router Configuration Lab',
                    course: 'CS 302 - Computer Networks',
                    dueDate: 'Due: Nov 02, 2026 - 05:00 PM',
                    status: 'Pending',
                    statusColor: Colors.orange,
                  ),
                  _buildAssignmentCard(
                    title: 'JavaScript DOM Manipulation Quiz App',
                    course: 'CS 208 - Web Development',
                    dueDate: 'Due: Nov 10, 2026 - 11:59 PM',
                    status: 'Pending',
                    statusColor: Colors.orange,
                  ),
                ],
              ),

              // TAB 2: SUBMITTED ASSIGNMENTS
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildAssignmentCard(
                    title: 'Linux CLI File Operations Report',
                    course: 'CS 310 - Operating Systems',
                    dueDate: 'Submitted: Oct 12, 2026',
                    status: 'Turned In',
                    statusColor: const Color(0xFF1B5E20),
                    grade: '98/100',
                  ),
                  _buildAssignmentCard(
                    title: 'Discrete Math Relations & Graph Exercise',
                    course: 'CS 101 - Discrete Mathematics',
                    dueDate: 'Submitted: Sep 30, 2026',
                    status: 'Turned In',
                    statusColor: const Color(0xFF1B5E20),
                    grade: '95/100',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssignmentCard({
    required String title,
    required String course,
    required String dueDate,
    required String status,
    required Color statusColor,
    String? grade,
  }) {
    return HoverableCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.assignment_outlined, color: Color(0xFF1B5E20), size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(course, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                  const SizedBox(height: 2),
                  Text(dueDate, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
                  ),
                ),
                if (grade != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    'Score: $grade',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}