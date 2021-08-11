import 'package:flutter/material.dart';

/// Draws a little dot as indicator.
class Circle extends StatelessWidget {
  /// [color] Determine the color of this circle.
  /// [size] Determine the circumference.
  Circle({Key? key, required this.color, required this.size}) : super(key: key);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
