import 'package:flutter/material.dart';
import 'package:poke_api/src/config/theme/theme.dart';

class CustomLinearProgressIndicator extends StatefulWidget {
  const CustomLinearProgressIndicator({super.key, required this.progress});
  final double progress;

  @override
  State<CustomLinearProgressIndicator> createState() =>
      CustomLinearProgressIndicatorState();
}

class CustomLinearProgressIndicatorState
    extends State<CustomLinearProgressIndicator> {
  Color get fill {
    if (widget.progress < 0.5) {
      return Colors.red.shade400;
    } else if (widget.progress < 0.75) {
      return Colors.yellow.shade400;
    } else {
      return const Color.fromARGB(255, 12, 226, 230);
    }
  }

  @override
  void didUpdateWidget(covariant CustomLinearProgressIndicator oldWidget) {
    if (oldWidget.progress != widget.progress) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => Container(
    height: 3,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: context.isDarkMode ? Colors.blueGrey : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        
      ]
    ),
    child: AnimatedFractionallySizedBox(
      duration: Duration(milliseconds: 1200),
      curve: const Cubic(0, 0, 0, 1),
      widthFactor: widget.progress.clamp(0, 1),
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
