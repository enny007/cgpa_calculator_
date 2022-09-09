import 'package:cgpa_calculator_/database/cgpa_database.dart';
import 'package:cgpa_calculator_/models/course_model.dart';
import 'package:flutter/material.dart';

class CourseService with ChangeNotifier {
  List<Course> _courses = [];

  List<Course> get courseList {
    return [..._courses];
  }

  final int _deletedIndex = 0;
  //To calculate the total cgpa, we use the fold property to ascertain the state of the unit and grade
  double calcCgpa() {
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

  Future<String> getCgpa(String code) async {
    try {
      _courses = await CgpaDatabase.instance.getAllCgpa(code);
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

  Future<String> deleteCgpa(Course course) async {
    try {
      await CgpaDatabase.instance.deleteCgpa(course);
    } catch (e) {
      return e.toString();
    }
    String result = await getCgpa(course.code);
    return result;
  }

  Future<String> createCgpa(Course course) async {
    try {
      await CgpaDatabase.instance.createCgpa(course);
    } catch (e) {
      return e.toString();
    }
    String result = await getCgpa(course.code);
    return result;
  }
}
