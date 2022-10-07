import 'package:cgpa_calculator_/constants.dart';
import 'package:cgpa_calculator_/models/semester_model.dart';
import 'package:cgpa_calculator_/services/course_service.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';

class GpaCard extends StatelessWidget {
  final Semester? semester;
  const GpaCard({super.key, this.semester});

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CourseService>();
    return Card(
      elevation: 5,
      color: Colors.white,
      child: ListTile(
        leading: Text(
          '${semester!.level} Level',
          style: TextStyle(fontSize: 18, color: Utils.primaryColor),
        ),
        title: Text(
          semester!.semester,
          style: TextStyle(
            fontSize: 18,
            color: Utils.primaryColor,
          ),
        ),
        trailing: Text(
          'GPA: ${courses.calcgpa(semester!.courses.toList()).toStringAsFixed(2)}',
          style: TextStyle(
            color: Utils.primaryColor,
          ),
        ),
      ),
    );
  }
}
