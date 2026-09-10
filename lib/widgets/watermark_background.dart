import 'package:flutter/material.dart';

class WatermarkBackground extends StatelessWidget {
  final Widget child;

  const WatermarkBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xFFFAF7F2),
        ),
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
        child,
      ],
    );
  }
}