// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    'A' : 5,
    'B' : 4,
    'C' : 3,
    'D' : 2,
    'E' : 1,
    'F' : 0
    //create a map that contains the numerical value for the grade 
  };

  int get gpa{
    return gpaMap[grade] as int;
  }
}
