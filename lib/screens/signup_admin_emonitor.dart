import 'package:cmsc23_b5l_project/screens/modules/signup_form/signup_admin_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignupAdminEmonitorPage extends StatefulWidget {
  const SignupAdminEmonitorPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupAdminEmonitorPage> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: const <Widget>[
            Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            SignUpAdminStepper(),
          ],
        ),
      ),
    );
  }
}
