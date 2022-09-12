import 'package:cgpa_calculator_/services/course_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/widgets/course_card.dart';
import '../components/widgets/modal_form.dart';
import '../models/course_model.dart';

class CgpaScreen extends StatelessWidget {
  const CgpaScreen({Key? key}) : super(key: key);

  Future<dynamic> addCourse(BuildContext context, [Course? course]) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => ModalForm(),
    );
  }

  void deleteAll(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete All Courses'),
            content: const Text('Would you like to delete all the courses'),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.read<CourseService>().deleteAll();
                  },
                  child: const Text(
                    'Delete',
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CourseService>();
    final courseList = courses.courseList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gpa Calculator'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        //Multiple floating action buttons must have their own herotag
        FloatingActionButton(
          heroTag: 'btn1',
          onPressed: () => addCourse(context),
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
          // backgroundColor: Colors.amberAccent,
        ),
        const SizedBox(
          width: 20,
        ),
        FloatingActionButton(
          heroTag: 'btn2',
          onPressed: () => deleteAll(context),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          child: const Icon(Icons.delete),
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          children: [
                        const TextSpan(
                            text: 'Current CGPA :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                            text: ' ${courses.calcCgpa().toStringAsFixed(2)}')
                      ])),
                  // ElevatedButton(
                  //   child: const Text('Add course'),
                  //   onPressed: () => addCourse(context),
                  // )
                ],
              ),
            ),
            if (courseList.isNotEmpty) const Text('Courses'),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: courseList.length,
              itemBuilder: (context, index) {
                return CourseCard(courseList[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}
