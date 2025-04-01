import 'package:flutter/material.dart';

class PokeError extends StatelessWidget {
  const PokeError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Couldn\'t load pokemon data'));
  }
}
