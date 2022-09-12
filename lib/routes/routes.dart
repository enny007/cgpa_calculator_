import 'package:cgpa_calculator_/pages/cgpa_page.dart';
import 'package:cgpa_calculator_/pages/splashpage.dart';
import 'package:flutter/material.dart';

import '../pages/menupage.dart';

class RouteManager {
  static const String menuPage = '/menuPage';
  static const String splashPage = '/splashPage';
  static const String cgpaPage = '/cgpaPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case menuPage:
        return MaterialPageRoute(
          builder: (context) => const MenuPage(),
        );

      case splashPage:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
        );

      case cgpaPage:
        return MaterialPageRoute(
          builder: (context) => const CgpaScreen(),
        );
      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
