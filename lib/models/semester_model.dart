import 'package:cgpa_calculator_/models/course_model.dart';

const String semesterTable = 'semesterTable';

class SemesterFields {
  static const String username = 'username';
  static const String level = 'level';
  static const String courses = 'courses';
  static final List<String> allfields = [
    username,
    level,
    courses,
  ];
}

class Semester {
  String level;
  List<Course>? courses;
  String username;
  Semester({
    required this.level,
    this.courses,
    required this.username,
  });
  Map<String, dynamic> toJson() => {
        SemesterFields.username: username,
        SemesterFields.level: level,
        SemesterFields.courses: courses,
      };

  static Semester fromJson(Map<String, dynamic> json) => Semester(
        level: json[SemesterFields.level] as String,
        courses: json[SemesterFields.courses] as List<Course>,
        username: json[SemesterFields.username] as String,
      );
}
