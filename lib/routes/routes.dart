import 'package:cgpa_calculator_/pages/splashpage.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import '../pages/menupage.dart';
import '../pages/register_page.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String registerPage = '/registerPage';
  static const String menuPage = '/menuPage';
  static const String splashPage = '/splashPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );

      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const Register(),
        );

      case menuPage:
        return MaterialPageRoute(
          builder: (context) => const MenuPage(),
        );

      case splashPage:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
        );

      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
