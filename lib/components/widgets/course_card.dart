import 'package:cgpa_calculator_/services/course_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/course_model.dart';
import 'modal_form.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard(
    this.course, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) async {
        return await showDialog(
            context: context,
            builder: (BuildContext buider) {
              return AlertDialog(
                title: Text("Delete ${course.code}"),
                content:
                    const Text('Are you sure you want to delete this course?'),
                actions: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Delete',
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'))
                ],
              );
            });
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<CourseService>().deleteCgpa(course);
      },
      key: Key(course.code),
      background: Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          context: context,
          builder: (context) => ModalForm(
            course: course,
          ),
        ),
        child: Card(
          child: ListTile(
            leading: Text(
              course.code,
              style: const TextStyle(fontSize: 18),
            ),
            title: course.unit == 1
                ? Text('${course.unit} Unit')
                : Text('${course.unit} Units'),
            subtitle:
                course.title == null ? const Text('') : Text(course.title!),
            trailing: Text('${course.grade} (${course.gpa})'),
          ),
        ),
      ),
    );
  }
}
