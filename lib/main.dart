import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(const MyApp());
}

// -----------------------------------------------------------------------------
// STUDENT MODEL & MOCK DATABASE
// -----------------------------------------------------------------------------
class Student {
  final String id;
  final String name;
  final String password;
  final String birthday;
  final String email;
  final String program;
  final String yearAndSection;

  Student({
    required this.id,
    required this.name,
    required this.password,
    required this.birthday,
    required this.email,
    required this.program,
    required this.yearAndSection,
  });
}

// Credentials for the 3 Group Members
final List<Student> studentDatabase = [
  Student(
    id: 'A2024-1049',
    name: 'Carmela Bueno',
    password: '0817',
    birthday: 'August 17, 2005',
    email: 'c.bueno@sti.edu.ph',
    program: 'BS Computer Science',
    yearAndSection: 'BSCS 3A',
  ),
  Student(
    id: 'A2024-1037',
    name: 'Katelyn Claire Tabernilla',
    password: '0418',
    birthday: 'April 18, 2005',
    email: 'k.tabernilla@sti.edu.ph',
    program: 'BS Computer Science',
    yearAndSection: 'BSCS 3A',
  ),
  Student(
    id: 'A2024-1034',
    name: 'Maricel Laurio',
    password: '0614',
    birthday: 'June 14, 2005',
    email: 'm.laurio@sti.edu.ph',
    program: 'BS Computer Science',
    yearAndSection: 'BSCS 3A',
  ),
];

// Color Constants
const Color cctGreen = Color(0xFF1B5E20);
const Color cctGold = Color(0xFFFFC107);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colegio De La Ciudad De Tayabas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: cctGreen,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: cctGreen,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// -----------------------------------------------------------------------------
// WATERMARK BACKGROUND WIDGET
// -----------------------------------------------------------------------------
class WatermarkBackground extends StatelessWidget {
  final Widget child;

  const WatermarkBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Warm Cream Background Color
        Container(
          color: const Color(0xFFFAF7F2),
        ),

        // 2. Watermark School Logo
        Center(
          child: Opacity(
            opacity: 0.20,
            child: Image.asset(
              'assets/school_logo.jpg',
              width: 320,
              height: 320,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.school,
                size: 280,
                color: Colors.grey,
              ),
            ),
          ),
        ),

        // 3. Page Content
        child,
      ],
    );
  }
}

// -----------------------------------------------------------------------------
//  HOVERABLE CARD WIDGET
// -----------------------------------------------------------------------------
class HoverableCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const HoverableCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.onTap,
  });

  @override
  State<HoverableCard> createState() => _HoverableCardState();
}

class _HoverableCardState extends State<HoverableCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: widget.margin ?? const EdgeInsets.only(bottom: 12),
          padding: widget.padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFF5).withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? const Color(0xFFFACC15) : Colors.black12,
              width: _isHovered ? 2.0 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? const Color(0xFFFACC15).withValues(alpha: 0.25)
                    : Colors.black.withValues(alpha: 0.03),
                blurRadius: _isHovered ? 10 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// LOGIN PAGE
// -----------------------------------------------------------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  void _handleLogin() {
    final studentId = _idController.text.trim();
    final password = _passwordController.text.trim();

    if (studentId.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both your Student ID and Password.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final student = studentDatabase.firstWhere(
          (s) => s.id == studentId && s.password == password,
      orElse: () => Student(
        id: '',
        name: '',
        password: '',
        birthday: '',
        email: '',
        program: '',
        yearAndSection: '',
      ),
    );

    if (student.id.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardPage(currentStudent: student),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Student ID or Password.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFFAF7F2),
            child: Image.asset(
              'assets/cct.background.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: const Color(0xFFFAF7F2)),
            ),
          ),
          // Semi-transparent Overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withValues(alpha: 0.4),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/school_logo.jpg',
                      height: 100,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.school,
                        size: 90,
                        color: cctGreen,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Colegio De La Ciudad De Tayabas',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: cctGreen,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Student Portal',
                      style: GoogleFonts.cinzel(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _idController,
                      decoration: InputDecoration(
                        labelText: 'Student ID',
                        prefixIcon: const Icon(Icons.person),
                        floatingLabelStyle: const TextStyle(color: cctGold),
                        prefixIconColor: WidgetStateColor.resolveWith(
                              (states) => states.contains(WidgetState.focused)
                              ? cctGold
                              : Colors.grey,
                        ),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: cctGold,
                            width: 2.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: _isPasswordObscured,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        floatingLabelStyle: const TextStyle(color: cctGold),
                        prefixIconColor: WidgetStateColor.resolveWith(
                              (states) => states.contains(WidgetState.focused)
                              ? cctGold
                              : Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          tooltip: _isPasswordObscured
                              ? 'Show password'
                              : 'Hide password',
                          icon: Icon(
                            _isPasswordObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordObscured = !_isPasswordObscured;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: cctGold,
                            width: 2.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cctGreen,
                          foregroundColor: Colors.yellow.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PROFILE PAGE
// -----------------------------------------------------------------------------
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

// -----------------------------------------------------------------------------
// EVENTS PAGE (CS Department Events)
// -----------------------------------------------------------------------------
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
          // Date Badge
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

          // Event Details
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

// -----------------------------------------------------------------------------
// STAFFS PAGE (CS Department Faculty Directory)
// -----------------------------------------------------------------------------
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
            // --- DEPARTMENT DEAN SECTION ---
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

            // --- PROFESSORS SECTION ---
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

  // Helper widget for professor cards
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

// -----------------------------------------------------------------------------
// ATTENDANCE PAGE
// -----------------------------------------------------------------------------
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
                // Check if this student in the list matches the logged in user's ID
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

// -----------------------------------------------------------------------------
// ASSIGNMENTS PAGE
// -----------------------------------------------------------------------------
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
                    color: statusColor.withValues(alpha:0.1),
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

// -----------------------------------------------------------------------------
// EXAMS PAGE
// -----------------------------------------------------------------------------
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
                      color: isCompleted ? const Color(0xFFA5D6A7) : const Color(0xFFFFE082), // Outer border line
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

// -----------------------------------------------------------------------------
// LIBRARY PAGE
// -----------------------------------------------------------------------------
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
// ----------------------------------------------------
// 2. DASHBOARD PAGE
// ----------------------------------------------------
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

              // 3. 3-Column Grid of Quick Access Cards
              LayoutBuilder(
                builder: (context, constraints) {
                  // If screen width is wider than 600px (Desktop / Laptop browser)
                  final isDesktop = constraints.maxWidth > 600;

                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isDesktop ? 6 : 3,
                    // Desktop uses a higher ratio (1.35) to stay short & compact.
                    // Mobile uses 0.85 for 3 readable columns.
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

  // Compact Grid Item Helper
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

  // Upcoming Event Item Helper
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

// ----------------------------------------------------
// 3. MY CLASSES & SCHEDULE PAGE
// ----------------------------------------------------
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
                        color: Color(0xFFA5D6A7), // Light green tint
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['code']!,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20)
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

// ----------------------------------------------------
// 4. GRADES & TRANSCRIPT PAGE
// ----------------------------------------------------
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
      // Safely parse double regardless of whether item is double or String
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
            // Calculated GWA Banner
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
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87
                                    ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                    'Units: ${(double.tryParse(item['units'].toString()) ?? 0).toInt()}',
                                  style: const TextStyle(fontSize: 12, color: Colors.black87
                                  ),
                                ),
                              ],
                            ) ,
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
                              fontWeight: FontWeight.bold, color: Color(0xFF1B5E20), fontSize: 15
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

// ----------------------------------------------------
// 5. ACCOUNT BALANCE PAGE
// ----------------------------------------------------
class AccountBalancePage extends StatelessWidget {
  const AccountBalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Balance', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: WatermarkBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 1. Total Remaining Balance Banner Card
            HoverableCard(
              padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: const [
                    Text(
                      'Total Remaining Balance',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFFB9F6CA), fontSize: 16,
                      fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '₱ 0.00',
                        textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Status: Fully Paid (Free Higher Education Act)',
                      style: TextStyle(
                        color: Color(0xFFB9F6CA),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Tuition & Fee Breakdown',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // 2. Fee Breakdown Card
            HoverableCard(
              child: Column(
                children: const [
                  _BalanceRow(label: 'Tuition Fee (18 Units)', amount: '₱ 9,000.00'),
                  SizedBox(height: 10),
                  _BalanceRow(label: 'Laboratory Fees', amount: '₱ 2,500.00'),
                  SizedBox(height: 10),
                  _BalanceRow(label: 'Miscellaneous Fees', amount: '₱ 3,800.00'),
                  Divider(height: 24),
                  _BalanceRow(
                    label: 'Subtotal Assessment',
                    amount: '₱ 15,300.00',
                    isBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Payment / Subsidy Applied',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // 3. Subsidy / Payment Details Card
            HoverableCard(
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF2E7D32),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CHED UNIFAST Subsidy / Grant',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Applied upon enrollment',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '- ₱ 15,300.00',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                      fontSize: 14,
                    ),
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

// Helper Widget for assessment breakdown rows
class _BalanceRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isBold;

  const _BalanceRow({
    required this.label,
    required this.amount,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: Colors.black,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(amount, style: style),
      ],
    );
  }
}