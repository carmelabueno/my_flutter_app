import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/student.dart';
import '../theme/colors.dart';
import 'dashboard_page.dart';

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