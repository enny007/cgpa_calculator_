import 'package:cgpa_calculator_/constants.dart';
import 'package:cgpa_calculator_/models/course_model.dart';
import 'package:cgpa_calculator_/services/course_service.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';

class GpaCard extends StatelessWidget {
  final Course? course;
  const GpaCard({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CourseService>();
    return Card(
      elevation: 5,
      color: Colors.white,
      child: ListTile(
        leading: Text(
          '${course!.level!} Level',
          style: TextStyle(fontSize: 18, color: Utils.primaryColor),
        ),
        title: Text(
          course!.semester!,
          style: TextStyle(
            fontSize: 18,
            color: Utils.primaryColor,
          ),
        ),
        trailing: Text(
          courses.calcgpa().toStringAsFixed(2),
          style: TextStyle(
            color: Utils.primaryColor,
          ),
        ),
      ),
    );
  }
}
