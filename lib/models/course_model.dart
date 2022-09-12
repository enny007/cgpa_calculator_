// ignore_for_file: public_member_api_docs, sort_constructors_first
// const String cgpaTable = 'cgpa';

// class CourseFields {
//   static const String username = 'username';
//   static const String code = 'code';
//   static const String title = 'title';
//   static const String unit = 'unit';
//   static const String grade = 'grade';
//   static final List<String> allFields = [
//     username,
//     code,
//     title,
//     unit,
//     grade,
//   ];
// }

class Course {
  String code;
  String? title;
  int unit;
  String grade;
  Course({
    required this.code,
    this.title,
    required this.unit,
    required this.grade,
  });

  final Map<String, int> gpaMap = {
    'A': 5,
    'B': 4,
    'C': 3,
    'D': 2,
    'E': 1,
    'F': 0
    //create a map that contains the numerical value for the grade
  };

  int get gpa {
    return gpaMap[grade] as int;
  }

  // Map<String, Object?> toJson() => {
  //       CourseFields.username: username,
  //       CourseFields.code: code,
  //       CourseFields.grade: grade,
  //       CourseFields.title: title,
  //       CourseFields.unit: unit
  //     };

  // static Course fromJson(Map<String, Object?> json) => Course(
  //       username: json[CourseFields.username] as String,
  //       code: json[CourseFields.code] as String,
  //       grade: json[CourseFields.grade] as String,
  //       title: json[CourseFields.title] as String?,
  //       unit: json[CourseFields.unit] as int,
  //     );
}
