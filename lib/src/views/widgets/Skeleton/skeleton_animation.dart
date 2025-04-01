import 'package:flutter/material.dart';

const Curve _curvePulseEffect = Curves.easeInCubic;

class SkeletonAnimation extends StatefulWidget {
  const SkeletonAnimation({super.key, required this.child});
  final Widget child;

  @override
  State<StatefulWidget> createState() => _BdsSkeletonShapeState();
}

class _BdsSkeletonShapeState extends State<SkeletonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    animatePulseEffect();
  }

  Color get _beginColor => Colors.grey;

  Color get _endColor => Colors.grey.shade200;

  void animatePulseEffect() {
    _colorAnimation = ColorTween(
      begin: _beginColor,
      end: _endColor,
    ).animate(CurvedAnimation(parent: _controller, curve: _curvePulseEffect));

    _controller
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _colorAnimation,
    builder:
        (context, child) => Container(
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.child,
        ),
  );
}
