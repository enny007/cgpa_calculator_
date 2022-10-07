import 'package:cgpa_calculator_/components/widgets/result_catalog.dart';
import 'package:cgpa_calculator_/routes/routes.dart';
import 'package:cgpa_calculator_/services/course_service.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CourseService>();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Utils.primaryColor,
              Utils.secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Selector<UserService, User>(
                  selector: (p0, p1) => p1.currentUser,
                  builder: (context, value, child) {
                    return Text(
                      '${value.name},',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  children: [
                    const TextSpan(
                        text: 'Your Current CGPA is:',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        )),
                    TextSpan(
                        text: ' ${courses.calcgpa().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child:
                    Consumer<CourseService>(builder: (context, value, child) {
                  if (value.courseList.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 200,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.book,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'You don\'t have any result in\nyour profile yet!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return ResultCatalog(
                    semesterCatalog: value.getSemester(),
                  );
                }),
              ),
            ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, RouteManager.cgpaPage);
        },
        backgroundColor: Utils.accentColor,
        icon: const Icon(Icons.mode_edit),
        label: const Text(
          'Calculate your gpa',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
