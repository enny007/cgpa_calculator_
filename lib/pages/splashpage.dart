import 'package:cgpa_calculator_/routes/routes.dart';

import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushNamed(
        context,
        RouteManager.menuPage,
      );
    });
    return Scaffold(
      backgroundColor: Utils.primaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'A+',
              style: TextStyle(
                color: Utils.secondaryColor,
                fontSize: 200,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            widthFactor: 2,
            // heightFactor: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Text(
                'Pass\nthe\nCourse',
                style: GoogleFonts.mulish(
                  color: Colors.white,
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
