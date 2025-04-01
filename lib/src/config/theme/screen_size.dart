import 'package:flutter/widgets.dart';

abstract class ScreenSize {
  static bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width > 600 && width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }
}
