const String cgpaTable = 'cgpa';

class CourseFields {
  static const String username = 'username';
  static const String code = 'code';
  static const String title = 'title';
  static const String unit = 'unit';
  static const String grade = 'grade';
  static const String semester = 'semester';
  static const String level = 'level';
  static final List<String> allFields = [
    username,
    code,
    title,
    unit,
    grade,
    level,
    semester,
  ];
}

class Course {
  String username;
  String code;
  String? title;
  int unit;
  String grade;
  String? semester;
  String? level;
  Course({
    required this.username,
    required this.code,
    this.title,
    required this.unit,
    required this.grade,
    this.level,
    this.semester,
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

  Map<String, Object?> toJson() => {
        CourseFields.level: level,
        CourseFields.semester: semester,
        CourseFields.username: username,
        CourseFields.code: code,
        CourseFields.grade: grade,
        CourseFields.title: title,
        CourseFields.unit: unit
      };

  static Course fromJson(Map<String, Object?> json) => Course(
        level: json[CourseFields.level] as String,
        semester: json[CourseFields.semester] as String,
        username: json[CourseFields.username] as String,
        code: json[CourseFields.code] as String,
        grade: json[CourseFields.grade] as String,
        title: json[CourseFields.title] as String?,
        unit: json[CourseFields.unit] as int,
      );
}
