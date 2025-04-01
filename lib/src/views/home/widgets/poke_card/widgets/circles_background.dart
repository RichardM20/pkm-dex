import 'package:flutter/material.dart';

class CirclesBackground extends StatelessWidget {
  final double? right;
  final double? bottom;
  final double? left;
  final double? top;

  const CirclesBackground({
    super.key,
    this.right = -10,
    this.bottom = -30,
    this.left,
    this.top,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: List.generate(2, (index) {
          final size = index == 0 ? 100.0 : 150.0;
          final alpha = index == 0 ? 0.1 : 0.05;
          return Positioned(
            right: right,
            left: left,
            top: top,
            bottom: bottom,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: alpha),
              ),
            ),
          );
        }),
      ),
    );
  }
}
