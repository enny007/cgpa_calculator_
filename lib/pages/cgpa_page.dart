import 'package:cgpa_calculator_/constants.dart';
import 'package:cgpa_calculator_/services/course_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/widgets/course_card.dart';
import '../components/widgets/modal_form.dart';
import '../models/course_model.dart';

class CgpaScreen extends StatefulWidget {
  const CgpaScreen({Key? key}) : super(key: key);

  @override
  State<CgpaScreen> createState() => _CgpaScreenState();
}

class _CgpaScreenState extends State<CgpaScreen> {
  List<Course>? course;
  Future<dynamic> addCourse(BuildContext context, [Course? course]) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
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
                      backgroundColor:
                          MaterialStateProperty.all(Utils.primaryColor),
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
                          MaterialStateProperty.all(Utils.primaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'))
            ],
          );
        });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   course = context.read<CourseService>().courseList;
  // }

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CourseService>();
    final courseList = courses.courseList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Gpa Calculator',
          style: TextStyle(
            color: Utils.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                courseList.isEmpty
                    ? const SizedBox()
                    : Text(
                        'Courses',
                        style: TextStyle(
                          color: Utils.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: courseList.length,
                  itemBuilder: (context, index) {
                    return CourseCard(course: courseList[index]);
                  },
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        //Multiple floating action buttons must have their own herotag
        FloatingActionButton(
          heroTag: 'btn1',
          onPressed: () => addCourse(context),
          foregroundColor: Colors.white,
          backgroundColor: Utils.primaryColor,
          child: const Icon(Icons.add),
        ),
        const SizedBox(
          width: 20,
        ),
        FloatingActionButton(
          heroTag: 'btn2',
          onPressed: () => deleteAll(context),
          foregroundColor: Colors.white,
          backgroundColor: Utils.primaryColor,
          child: const Icon(Icons.delete),
        ),
      ]),
    );
  }
}
