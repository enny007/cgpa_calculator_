import 'package:cgpa_calculator_/constants.dart';
import 'package:cgpa_calculator_/services/course_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/course_model.dart';

class ModalForm extends StatefulWidget {
  Course? course;
  ModalForm({this.course, Key? key}) : super(key: key);

  @override
  State<ModalForm> createState() => _ModalFormState();
}

class _ModalFormState extends State<ModalForm> {
  // final Course? course;
  final _formKey = GlobalKey<FormState>();
  final bool _addForm = false;
  String _gradeDropdownValue = "A";
  int _unitDropdownValue = 1;
  var _newCourseInput = Course(
    code: '',
    unit: 0,
    grade: '',
  );
  late TextEditingController codeController;
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    titleController = TextEditingController();
  }

  void saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
    if (codeController.text.isEmpty || titleController.text.isEmpty) {
      // String username = context.read<UserService>().currentUser.username;
      // Course _newCourseInput = Course(username: username, code: code, unit: unit, grade: grade)
    } else if (!_addForm) {
      context.read<CourseService>().addCourse(_newCourseInput);
      Navigator.of(context).pop();
    } else {
      // Navigator.of(context).pop();
      bool editDecision = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Edit'),
              content: Text('Edit course ${_newCourseInput.code}?'),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'Yes',
                    )),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
              ],
            );
          });
      if (editDecision) {
        if (!mounted) return;
        context.read<CourseService>().editCourse(_newCourseInput);
        Navigator.of(context).pop();
      } else {
        if (!mounted) return;
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Course Code'),
              controller: codeController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please input a course code';
                } else if (value.length < 4) {
                  return 'Enter at least 4 characters';
                }
                return null;
              },
              onSaved: (value) {
                _newCourseInput = Course(
                    code: value.toString(),
                    unit: _newCourseInput.unit,
                    grade: _newCourseInput.grade);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Course Title'),
              controller: titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please input a course title';
                }
                return null;
              },
              onSaved: (value) {
                if (value != null && value.isNotEmpty) {
                  _newCourseInput = Course(
                      code: _newCourseInput.code,
                      unit: _newCourseInput.unit,
                      grade: _newCourseInput.grade,
                      title: value);
                }
              },
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Credit Units'),
              value: _unitDropdownValue,
              items: const [
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('1'),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text('2'),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Text('3'),
                ),
                DropdownMenuItem<int>(
                  value: 4,
                  child: Text('4'),
                ),
                DropdownMenuItem<int>(
                  value: 5,
                  child: Text('5'),
                ),
                DropdownMenuItem<int>(
                  value: 6,
                  child: Text('6'),
                ),
                DropdownMenuItem<int>(
                  value: 7,
                  child: Text('7'),
                ),
                DropdownMenuItem<int>(
                  value: 8,
                  child: Text('8'),
                ),
                DropdownMenuItem<int>(
                  value: 9,
                  child: Text('9'),
                )
              ],
              onChanged: (value) {
                setState(() {
                  _unitDropdownValue = value as int;
                });
              },
              // icon: dropdownvolor arrow_drop_down,
              onSaved: (value) {
                _newCourseInput = Course(
                  code: _newCourseInput.code,
                  unit: value as int,
                  grade: _newCourseInput.grade,
                  title: _newCourseInput.title,
                );
              },
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Course Grade'),
              value: _gradeDropdownValue,
              items: const [
                DropdownMenuItem<String>(
                  value: "A",
                  child: Text('A'),
                ),
                DropdownMenuItem<String>(
                  value: "B",
                  child: Text('B'),
                ),
                DropdownMenuItem<String>(
                  value: "C",
                  child: Text('C'),
                ),
                DropdownMenuItem<String>(
                  value: "D",
                  child: Text('D'),
                ),
                DropdownMenuItem<String>(
                  value: "E",
                  child: Text('E'),
                ),
                DropdownMenuItem<String>(
                  value: "F",
                  child: Text('F'),
                )
              ],
              onChanged: (value) {
                setState(() {
                  _gradeDropdownValue = value.toString();
                });
              },
              // onSaved: (value) {
              //   setState(() {
              //     _gradeDropdownValue = value.toString();
              //   });
              // },
              onSaved: (value) {
                _newCourseInput = Course(
                    code: _newCourseInput.code,
                    unit: _newCourseInput.unit,
                    grade: value as String,
                    title: _newCourseInput.title);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Utils.primaryColor),
              ),
              icon: Icon(widget.course == null ? Icons.save : Icons.edit),
              label: Text(widget.course == null ? 'Submit' : 'Edit'),
              onPressed: () {
                saveForm();
              },
            ),
          ],
        ),
      ),
    );
  }
}
