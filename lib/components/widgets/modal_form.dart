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
  Course? course;
  final _formKey = GlobalKey<FormState>();
  bool _addForm = false;
  String _gradeDropdownValue = "A";
  int _unitDropdownValue = 1;
  var _newCourseInput = Course(
    code: '',
    unit: 0,
    grade: '',
  );

  @override
  void initState() {
    super.initState();
    course = widget.course;
    if (course != null) {
      _addForm = true;
      _gradeDropdownValue = course!.grade;
      _unitDropdownValue = course!.unit;
      _newCourseInput =
          Course(code: course!.code, unit: course!.unit, grade: course!.grade);
    } else {}
  }

  void saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (!_addForm) {
      context.read<CourseService>().addCourse(_newCourseInput);
      Navigator.of(context).pop();
    } else {
      bool editDecision = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Edit'),
              content: Text('Edit course ${_newCourseInput.code}?'),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Utils.primaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'Yes',
                    )),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Utils.primaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
              ],
            );
          });
      if (editDecision) {
        if (!mounted) return;
        context.read<CourseService>().addCourse(_newCourseInput);
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
              cursorColor: Utils.primaryColor,
              decoration: InputDecoration(
                  labelText: 'Course Code',
                  labelStyle: TextStyle(color: Utils.primaryColor)),
              initialValue: _newCourseInput.code,
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
              decoration: InputDecoration(
                labelText: 'Course Title',
                labelStyle: TextStyle(
                  color: Utils.primaryColor,
                ),
              ),
              cursorColor: Utils.primaryColor,
              initialValue: _newCourseInput.title,
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
              decoration: InputDecoration(
                labelText: 'Credit Units',
                labelStyle: TextStyle(
                  color: Utils.primaryColor,
                ),
              ),
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
              icon: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Utils.primaryColor,
              ),
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
              decoration: InputDecoration(
                labelText: 'Course Grade',
                labelStyle: TextStyle(
                  color: Utils.primaryColor,
                ),
              ),
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
              icon: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Utils.primaryColor,
              ),
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
              icon: Icon(
                course == null ? Icons.save : Icons.edit,
              ),
              label: Text(
                course == null ? 'Submit' : 'Edit',
              ),
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
