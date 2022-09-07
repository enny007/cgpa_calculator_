import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPageIcons extends StatelessWidget {
  final Widget icon;
  final Function() onPressed;
  final String label;
  const MenuPageIcons({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: GoogleFonts.mulish(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
