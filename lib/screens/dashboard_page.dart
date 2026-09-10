import 'package:flutter/material.dart';

import '../models/student.dart';
import '../widgets/hoverable_card.dart';
import '../widgets/watermark_background.dart';

// Screen Imports for Navigation
import 'login_page.dart';
import 'profile_page.dart';
import 'events_page.dart';
import 'staffs_page.dart';
import 'attendance_page.dart';
import 'assignments_page.dart';
import 'exams_page.dart';
import 'library_page.dart';
import 'classes_schedule_page.dart';
import 'grades_transcript_page.dart';
import 'account_balance_page.dart';

class DashboardPage extends StatelessWidget {
  final Student currentStudent;

  const DashboardPage({super.key, required this.currentStudent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B5E20),
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: WatermarkBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Profile / Header Card
              HoverableCard(
                padding: EdgeInsets.zero,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/sti_logo.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back, ${currentStudent.name}!',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'ID: ${currentStudent.id}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Program: ${currentStudent.program}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                            const Text(
                              'Dept: School of Information Technology',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 2. Quick Access Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quick Access',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(color: Color(0xFF1B5E20)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // 3. Grid of Quick Access Cards
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth > 600;

                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isDesktop ? 6 : 3,
                    childAspectRatio: isDesktop ? 1.35 : 0.85,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      _buildGridCard(
                        context,
                        icon: Icons.person_outline,
                        title: 'Profile',
                        subtitle: 'View & edit',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProfilePage(currentStudent: currentStudent),
                            ),
                          );
                        },
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.event_note,
                        title: 'Events',
                        subtitle: 'School events',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const EventsPage()),
                        ),
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.people_outline,
                        title: 'Staffs',
                        subtitle: 'Faculty info',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const StaffsPage()),
                        ),
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.fact_check_outlined,
                        title: 'Attendance',
                        subtitle: 'Check record',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AttendancePage(currentStudent: currentStudent),
                            ),
                          );
                        },
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.calendar_month,
                        title: 'Schedule',
                        subtitle: 'Classes & rooms',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ClassesSchedulePage()),
                        ),
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.grade_outlined,
                        title: 'GradeSheet',
                        subtitle: 'View grades',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const GradesTranscriptPage()),
                        ),
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.assignment_outlined,
                        title: 'Assignments',
                        subtitle: 'Submissions',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AssignmentsPage()),
                        ),
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.assignment_turned_in_outlined,
                        title: 'Exams',
                        subtitle: 'Schedule',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ExamsPage()),
                        ),
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.local_library_outlined,
                        title: 'Library',
                        subtitle: 'Resources',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LibraryPage()),
                        ),
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.account_balance_wallet_outlined,
                        title: 'Balance',
                        subtitle: 'Tuition & fees',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AccountBalancePage()),
                        ),
                      ),
                    ],
                  );
                },
              ),

              // 4. Upcoming Events Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upcoming Events',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View Calendar',
                      style: TextStyle(color: Color(0xFF1B5E20)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              _buildEventCard(
                month: 'OCTOBER',
                day: '24',
                dayName: 'Fri',
                title: 'IT Exhibition',
                time: '10:00 AM - 01:00 PM',
                location: 'School Auditorium',
              ),
              _buildEventCard(
                month: 'OCTOBER',
                day: '28',
                dayName: 'Tue',
                title: 'CS Meeting',
                time: '02:00 PM - 04:00 PM',
                location: 'Room 204',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return HoverableCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      margin: EdgeInsets.zero,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: const Color(0xFF1B5E20), size: 18),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 8.5,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard({
    required String month,
    required String day,
    required String dayName,
    required String title,
    required String time,
    required String location,
  }) {
    return HoverableCard(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  month,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dayName,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF1B5E20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Upcoming',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF1B5E20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}