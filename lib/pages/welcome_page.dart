import 'package:flutter/Material.dart';

import '../constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Utils.primaryColor,
                  Utils.secondaryColor,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
