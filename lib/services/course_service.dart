import 'package:cgpa_calculator_/database/cgpa_database.dart';
import 'package:cgpa_calculator_/models/course_model.dart';
import 'package:flutter/material.dart';

import '../models/semester_model.dart';

class CourseService with ChangeNotifier {
  List<Course> _courseServiceList = [];

  final int _deletedIndex = 0;
  // final Course _deletedCourse = Course(code: '', unit: 0, grade: '');

  List<Course> get courseList {
    return [..._courseServiceList];
  }

  //To calculate the total gpa, we use the fold property to ascertain the state of the unit and grade
  double calcgpa([List<Course>? courses]) {
    //?? if the first portion is null, use the second portion
    List<Course> _courses = courses ?? _courseServiceList;
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


  Future<String> getGpa(String username) async {
    try {
      _courseServiceList = await CgpaDatabase.instance.getAllCgpa(username);
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

  Future<String> editCourse(Course course) async {
    try {
      await CgpaDatabase.instance.editCgpa(course);
    } catch (e) {
      return e.toString();
    }
    String result = await getGpa(course.username);
    return result;
  }

  void deleteAll() {
    _courseServiceList.clear();
    notifyListeners();
  }

  List<Semester> getSemester() {
    Map<String, Semester> semesters = {};
    for (Course course in _courseServiceList) {
      String semesterKey = '${course.level}${course.semester}';
      if (semesters.keys.contains(semesterKey)) {
        //if there are existing values in the Map, add to the existing values
        //the key is used to identify the content of the map
        //adding a course to existing semester
        semesters[semesterKey]!.courses.add(course);
      } else {
        //adding a semester to the map
        semesters[semesterKey] = Semester(
          level: course.level!,
          username: course.username,
          semester: course.semester!,
          courses: {course},
        );
      }
    }
    return semesters.values.toList();
  }
}
