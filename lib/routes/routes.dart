import 'package:cgpa_calculator_/pages/cgpa_page.dart';
import 'package:cgpa_calculator_/pages/login.dart';
import 'package:cgpa_calculator_/pages/splashpage.dart';
import 'package:cgpa_calculator_/pages/welcome_page.dart';
import 'package:flutter/material.dart';

import '../pages/menupage.dart';
import '../pages/register.dart';

class RouteManager {
  static const String menuPage = '/menuPage';
  static const String splashPage = '/';
  static const String cgpaPage = '/cgpaPage';
  static const String registerPage = '/registerPage';
  static const String loginPage = '/loginPage';
  static const String welcomePage = '/welcomePage';

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

      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const Register(),
        );

      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );

      case welcomePage:
        return MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        );
      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
