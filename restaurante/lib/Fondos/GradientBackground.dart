// gradient_background.dart
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            const Color.fromARGB(150, 207, 87, 78), // Color rojo
            Colors.white,
            Colors.white,
          ],
          center: Alignment.topRight,
          radius: 2,
          focal: Alignment.topRight,
          focalRadius: 0.1,
        ),
      ),
      child: child,
    );
  }
}
