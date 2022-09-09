import 'package:cgpa_calculator_/models/course_model.dart';
import 'package:flutter/material.dart';

class CourseService with ChangeNotifier {
  final List<Course> _courses = [];

  List<Course> get courseList {
    return [..._courses];
  }

  final int _deletedIndex = 0;
  //To calculate the total cgpa, we use the fold property to ascertain the state of the unit and grade
  double getCgpa() {
    if (_courses.isNotEmpty) {
      double courseUnit = _courses.fold(0, (previousValue, course) {
        return previousValue + course.unit;
      });
      double gpaTotal = _courses.fold(0, (previousValue, course) {
        return previousValue + (course.gpa * course.unit);
      });
      double total = gpaTotal / courseUnit;
      return total;
    } else {
      return 0;
    }
  }
}
