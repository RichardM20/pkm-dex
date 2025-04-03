import 'package:flutter/material.dart';

enum AnimationType { fade, scale, translate }

enum AnimationDirection { up, down, left, right }

class TwenAnimationType extends StatelessWidget {
  const TwenAnimationType({
    super.key,
    required this.child,
    this.type = AnimationType.scale,
    this.direction,
    this.value = 0.05,
  }) : assert(
         type != AnimationType.translate || direction != null,
         'The "direction" is only used for the AnimationType.translate.',
       );

  final Widget child;
  final AnimationType type;
  final AnimationDirection? direction;
  final double value;

  Tween<double> animationTypeBegin() {
    switch (type) {
      case AnimationType.fade:
        return Tween(begin: value, end: 1.0);
      case AnimationType.scale:
        return Tween(begin: value, end: 1.0);
      case AnimationType.translate:
        return Tween(begin: 1.0, end: 0.0);
    }
  }

  double calculateTranslateAmount(BuildContext context) {
    final size = MediaQuery.of(context).size;
    switch (direction) {
      case AnimationDirection.up:
        return size.height * value;
      case AnimationDirection.down:
        return -size.height * value;
      case AnimationDirection.left:
        return size.width * value;
      case AnimationDirection.right:
        return -size.width * value;
      default:
        return 0;
    }
  }

  Offset getTranslateOffset(BuildContext context, double animationValue) {
    final double amount = calculateTranslateAmount(context);
    switch (direction) {
      case AnimationDirection.up:
      case AnimationDirection.down:
        return Offset(0, amount * animationValue);
      case AnimationDirection.left:
      case AnimationDirection.right:
        return Offset(amount * animationValue, 0);
      default:
        return Offset.zero;
    }
  }

  Widget animationWidget({
    required double value,
    required Widget child,
    required BuildContext context,
  }) {
    switch (type) {
      case AnimationType.fade:
        return Opacity(opacity: value, child: child);
      case AnimationType.scale:
        return Transform.scale(scale: value, child: child);
      case AnimationType.translate:
        final offset = getTranslateOffset(context, value);
        return Transform.translate(offset: offset, child: child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: animationTypeBegin(),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return animationWidget(child: child, context: context, value: value);
      },
    );
  }
}
