import 'package:cgpa_calculator_/components/widgets/menu_page_icons.dart';
import 'package:cgpa_calculator_/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'CGPA Calculator',
              style: GoogleFonts.mulish(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuPageIcons(
                icon: const Icon(
                  Icons.calculate,
                  size: 50,
                  color: Colors.white,
                ),
                onPressed: () {},
                label: 'Calculate',
              ),
              const SizedBox(
                width: 10,
              ),
              MenuPageIcons(
                icon: const Icon(
                  Icons.settings,
                  size: 50,
                  color: Colors.white,
                ),
                onPressed: () {},
                label: 'Settings',
              ),
              const SizedBox(
                width: 10,
              ),
              MenuPageIcons(
                icon: const Icon(
                  Icons.info_outline,
                  size: 50,
                  color: Colors.white,
                ),
                onPressed: () {},
                label: 'About',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
