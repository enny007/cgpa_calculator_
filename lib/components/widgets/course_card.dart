import 'package:cgpa_calculator_/constants.dart';
import 'package:cgpa_calculator_/services/course_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/course_model.dart';
import 'modal_form.dart';

class CourseCard extends StatelessWidget {
  final Course? course;
  const CourseCard({
    this.course,
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
                title: Text("Delete ${course!.code}"),
                content:
                    const Text('Are you sure you want to delete this course?'),
                actions: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Utils.primaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      context.read<CourseService>().deleteCourse(course!);
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      'Delete',
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Utils.primaryColor),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'))
                ],
              );
            });
      },
      direction: DismissDirection.endToStart,
      key: Key(course!.code),
      background: Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        color: Utils.primaryColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) => ModalForm(
              course: course,
            ),
          );
        },
        child: Card(
          elevation: 6,
          color: Colors.white,
          child: ListTile(
            leading: Column(
              children: [
                Text(
                  course!.code,
                  style: TextStyle(
                    fontSize: 15,
                    color: Utils.primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  '${course!.level!} Level',
                  style: TextStyle(color: Utils.primaryColor),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  course!.semester!,
                  style: TextStyle(color: Utils.primaryColor),
                )
              ],
            ),
            title: course!.unit == 1
                ? Text(
                    '${course!.unit} Unit',
                    style: TextStyle(
                      color: Utils.primaryColor,
                    ),
                  )
                : Text(
                    '${course!.unit} Units',
                    style: TextStyle(
                      color: Utils.primaryColor,
                    ),
                  ),
            subtitle: course!.title == null
                ? const Text('')
                : Text(
                    course!.title!,
                    style: TextStyle(
                      color: Utils.primaryColor,
                    ),
                  ),
            trailing: Text(
              '${course!.grade} (${course!.gpa})',
              style: TextStyle(
                color: Utils.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
