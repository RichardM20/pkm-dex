import 'package:flutter/material.dart';

enum AnimationType { fade, scale, translate }

enum AnimationDirection { up, down, left, right }

class TwenAnimationType extends StatelessWidget {
  const TwenAnimationType({
    super.key,
    required this.child,
    this.type = AnimationType.scale,
    this.direction,
  }) : assert(
         type != AnimationType.translate || direction != null,
         'The "direction" is only used for the AnimationType.translate.',
       );

  final Widget child;
  final AnimationType type;
  final AnimationDirection? direction;

  Tween<double> animatonTypeBegin({BuildContext? context}) {
    switch (type) {
      case AnimationType.fade:
        return Tween(begin: 0.5, end: 1.0);
      case AnimationType.scale:
        return Tween(begin: 0.5, end: 1.0);
      case AnimationType.translate:
        return Tween(begin: beginTrnaslate(context), end: 0);
    }
  }

  double beginTrnaslate(context) {
    final size = MediaQuery.of(context).size;
    switch (direction) {
      case AnimationDirection.up:
        return size.height * 0.05;
      case AnimationDirection.down:
        return -size.height * 0.05;
      case AnimationDirection.left:
        return size.width * 0.05;
      case AnimationDirection.right:
        return -size.width * 0.05;
      default:
        return 100;
    }
  }

  Offset beginTranslateOffset(context) {
    final double translate = beginTrnaslate(context);
    switch (direction) {
      case AnimationDirection.up:
        return Offset(0, translate);
      case AnimationDirection.down:
        return Offset(0, translate);
      case AnimationDirection.left:
        return Offset(translate, 0);
      case AnimationDirection.right:
        return Offset(translate, 0);
      default:
        return Offset(0, 100);
    }
  }

  Widget animationWidget({
    required double value,
    Widget? child,
    BuildContext? context,
  }) {
    switch (type) {
      case AnimationType.fade:
        return Opacity(opacity: value, child: child);
      case AnimationType.scale:
        return Transform.scale(scale: value, child: child);
      case AnimationType.translate:
        final offset = beginTranslateOffset(context);

        return Transform.translate(
          offset: Offset(-value, offset.dy * value),
          child: child,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: animatonTypeBegin(context: context),
      curve: Curves.easeInOut,
      builder: (context, value, kind) {
        return animationWidget(child: child, context: context, value: value);
      },
    );
  }
}
