import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignupAdminEmonitorPage extends StatefulWidget {
  const SignupAdminEmonitorPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupAdminEmonitorPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController employeenoController = TextEditingController();
  TextEditingController homeunitController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  Map<String, dynamic> illnessMap = {
    "Hypertension": false,
    "Diabetes": false,
    "Tuberculosis": false,
    "Cancer": false,
    "Kidney Disease": false,
    "Cardiac Disease": false,
    "Autoimmune Disease": false,
    "Asthma": false,
  };

  List<String> illnesses = [];

  @override
  Widget build(BuildContext context) {
    final email = TextField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: 'Email',
      ),
    );

    final password = TextField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
    );

    final name = TextField(
      controller: nameController,
      decoration: const InputDecoration(
        hintText: 'Name',
      ),
    );

    final employeeno = TextField(
      controller: employeenoController,
      decoration: const InputDecoration(
        hintText: 'Employee No',
      ),
    );

    final homeunit = TextField(
      controller: homeunitController,
      decoration: const InputDecoration(
        hintText: 'Home Unit',
      ),
    );

    final position = TextField(
      controller: positionController,
      decoration: const InputDecoration(
        hintText: 'Position',
      ),
    );

    final signupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          illnessMap.forEach((k, v) {
            v ? illnesses.add(k) : 0;
          });

          if (_formKey.currentState!.validate()) {
            await context
                .read<AuthProvider>()
                .signUp(emailController.text, passwordController.text);

            await context.read<AuthProvider>().addAdminEmonitor(
                //add admin/emonitor when signing up
                emailController.text,
                nameController.text,
                employeenoController.text,
                positionController.text,
                homeunitController.text);

            if (context.mounted) Navigator.pop(context);
          }
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Sign Up as Admin/Entrance Monitor",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      email,
                      password,
                      name,
                      employeeno,
                      homeunit,
                      position,
                      signupButton,
                      backButton
                    ])),
          ],
        ),
      ),
    );
  }
}
