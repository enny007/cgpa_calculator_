import 'package:cgpa_calculator_/constants.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 1200),
    elevation: 10,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    )),
    backgroundColor: Utils.accentColor,
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
