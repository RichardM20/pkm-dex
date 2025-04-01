import 'package:flutter/material.dart';

abstract class Navigation {
  static void pushToDetailPage(BuildContext context, route) {
    Navigator.pushNamed(context, route);
  }
}
