import 'package:cgpa_calculator_/models/course_model.dart';

const String semesterTable = 'semesterTable';

class SemesterFields {
  static const String username = 'username';
  static const String level = 'level';
  static const String courses = 'courses';
  static const String semester = 'semester';
  static final List<String> allfields = [
    username,
    level,
    courses,
    semester,
  ];
}

class Semester {
  String level;
  Set<Course> courses;//we use set data type because we do not want to have a duplicate entry
  String username;
  String semester;
  Semester(
      {required this.level,
      this.courses = const {},
      required this.username,
      required this.semester});
  Map<String, dynamic> toJson() => {
        SemesterFields.username: username,
        SemesterFields.level: level,
        SemesterFields.courses: courses,
        SemesterFields.semester: semester,
      };

  static Semester fromJson(Map<String, dynamic> json) => Semester(
        level: json[SemesterFields.level] as String,
        courses: json[SemesterFields.courses] as Set<Course>,
        username: json[SemesterFields.username] as String,
        semester: json[SemesterFields.semester] as String,
      );
       
}
