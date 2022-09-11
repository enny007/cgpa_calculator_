import 'package:cgpa_calculator_/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/widgets/app_textfield.dart';
import '../components/widgets/dialogs.dart';
import '../routes/routes.dart';
import '../services/course_service.dart';
import '../services/user_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController usernameController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Utils.primaryColor,
              Utils.secondaryColor,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                ),
                AppTextField(
                  controller: usernameController,
                  labelText: 'Please enter username',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (usernameController.text.isEmpty) {
                        showSnackBar(
                            context, 'Please enter the username first');
                      } else {
                        String result =
                            await context.read<UserService>().getUser(
                                  usernameController.text.trim(),
                                );
                        if (result != 'OK') {
                          if (!mounted) return;
                          showSnackBar(
                              context, 'Username not found in database');
                        } else {
                          if (!mounted) return;
                          String username =
                              context.read<UserService>().currentUser.username;
                          context.read<CourseService>().getCgpa(username);
                          Navigator.of(context)
                              .pushNamed(RouteManager.cgpaPage);
                          usernameController.text = '';
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Utils.accentColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: const Text('Continue'),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteManager.registerPage);
                  },
                  child: const Text('Register a new User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
