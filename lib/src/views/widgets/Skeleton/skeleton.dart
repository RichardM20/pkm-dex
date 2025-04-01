import 'package:flutter/material.dart';
import 'package:poke_api/src/views/widgets/Skeleton/skeleton_animation.dart';

const duration = Duration(milliseconds: 300);

class Skeleton extends StatefulWidget {
  const Skeleton({
    super.key,
    required this.child,
    required this.showSkeleton,
    this.height = 184,
    this.width = 184,
  });
  final bool showSkeleton;
  final Widget child;
  final double? height;
  final double? width;

  @override
  State<Skeleton> createState() => _BdsSkeletonBaseState();
}

class _BdsSkeletonBaseState extends State<Skeleton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedOpacity(
          duration: duration,
          opacity: widget.showSkeleton ? 1.0 : 0.0,
          child: SkeletonAnimation(
            child: Container(
              constraints: BoxConstraints(
                minHeight: widget.height ?? 0,
                minWidth: widget.width ?? 0,
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: duration,
          opacity: widget.showSkeleton ? 0.0 : 1.0,
          child: widget.child,
        ),
      ],
    );
  }
}
