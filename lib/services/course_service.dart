import 'package:cgpa_calculator_/database/cgpa_database.dart';
import 'package:cgpa_calculator_/models/course_model.dart';
import 'package:flutter/material.dart';

class CourseService with ChangeNotifier {
  List<Course> _courses = [];

  final int _deletedIndex = 0;
  // final Course _deletedCourse = Course(code: '', unit: 0, grade: '');

  List<Course> get courseList {
    return [..._courses];
  }

  //To calculate the total gpa, we use the fold property to ascertain the state of the unit and grade
  double calcgpa() {
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

  // void addCourse(Course course) {
  //   try {
  //     if (_courses.any((element) => element.code == course.code)) {
  //       _courses[_courses
  //           .indexWhere((element) => element.code == course.code)] = course;
  //     } else {
  //       _courses.add(course);
  //     }
  //   } catch (e) {
  //     log('There was an error adding to the courseList');
  //   }
  //   notifyListeners();
  // }
  Future<String> getGpa(String username) async {
    try {
      _courses = await CgpaDatabase.instance.getAllCgpa(username);
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

  Future<String> addCourse(Course course) async {
    try {
      await CgpaDatabase.instance.createCgpa(course);
    } catch (e) {
      return e.toString();
    }
    String result = await getGpa(course.username);
    return result;
  }

  Future<String> deleteCourse(Course course) async {
    try {
      await CgpaDatabase.instance.deleteCgpa(course);
    } catch (e) {
      return e.toString();
    }
    String result = await getGpa(course.username);
    return result;
  }
  // void deleteCourse(Course course) {
  //   try {
  //     _deletedIndex =
  //         _courses.indexWhere((element) => element.code == course.code);
  //     _deletedCourse = _courses[_deletedIndex];
  //     _courses.removeAt(_deletedIndex);
  //   } catch (e) {
  //     log('There was an error deleting this course');
  //   }
  //   notifyListeners();
  // }

  void deleteAll() {
    _courses.clear();
    notifyListeners();
  }
}
