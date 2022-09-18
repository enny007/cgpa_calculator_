import 'package:cgpa_calculator_/constants.dart';
// import 'package:cgpa_calculator_/pages/splashpage.dart';
import 'package:cgpa_calculator_/routes/routes.dart';

import 'package:cgpa_calculator_/services/course_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CourseService(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Utils.primaryColor),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: RouteManager.splashPage,
          onGenerateRoute: RouteManager.generateRoute,
        );
      },
    );
  }
}
