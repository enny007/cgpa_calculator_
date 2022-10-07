import 'package:cgpa_calculator_/database/cgpa_database.dart';
import 'package:cgpa_calculator_/models/semester_model.dart';
import 'package:flutter/Material.dart';

class SemesterService with ChangeNotifier {
  List<Semester> semesters = [];

  Future<String> getSemester(String username) async {
    try {
      semesters = await CgpaDatabase.instance.getSemester(username);
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

  Future<String> createSemester(Semester semester) async {
    try {
      await CgpaDatabase.instance.createSemester(semester);
    } catch (e) {
      return e.toString();
    }
    String result = await getSemester(semester.username);
    return result;
  }

  Future<String> updateSemester(Semester semester) async {
    try {
      await CgpaDatabase.instance.updateSemester(semester);
    } catch (e) {
      return e.toString();
    }
    String result = await getSemester(semester.username);
    return result;
  }
}
