import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController studentNumController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();

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

    final username = TextField(
      controller: usernameController,
      decoration: const InputDecoration(
        hintText: 'Username',
      ),
    );
    

    final name = TextField(
      controller: nameController,
      decoration: const InputDecoration(
        hintText: 'Name',
      ),
    );

    final college = TextField(
      controller: collegeController,
      decoration: const InputDecoration(
        hintText: 'College',
      ),
    );

    final course = TextField(
      controller: courseController,
      decoration: const InputDecoration(
        hintText: 'Course',
      ),
    );

    final studentnum = TextField(
      controller: studentNumController,
      decoration: const InputDecoration(
        hintText: 'Student Number',
      ),
    );

    final allergies = TextFormField(
      controller: allergiesController,
      decoration: const InputDecoration(
        hintText: 'Please enumerate your allergies',
      ),
    );

    final signupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          illnessMap.forEach((k, v) { v ? illnesses.add(k) : 0 ;});

          if (_formKey.currentState!.validate()) {
            await context
                .read<AuthProvider>()
                .signUp(emailController.text, passwordController.text);

            await context.read<AuthProvider>().addUser( //add user when signing up
                  nameController.text,
                  usernameController.text,
                  collegeController.text,
                  courseController.text,
                  studentNumController.text,
                  illnesses,
                  allergiesController.text);

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
              "Sign Up",
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
            username,
            name,
            college,
            course,
            studentnum,

            Container(
                        constraints: BoxConstraints(
                          minWidth: 150,
                          maxWidth: 300,
                        ),
                        child: Column(children: [
                           CheckboxListTile(
                            title: Text(illnessMap.keys.elementAt(0)),
                            value: illnessMap[illnessMap.keys.elementAt(0)], //gets value
                            onChanged: (bool? value) {
                            setState(() {
                                illnessMap[illnessMap.keys.elementAt(0)] = value!;
                            });
                          },),
                           
                          CheckboxListTile(
                            title: Text(illnessMap.keys.elementAt(1)),
                            value: illnessMap[illnessMap.keys.elementAt(1)], //gets value
                            onChanged: (bool? value) {
                              setState(() {
                                  illnessMap[illnessMap.keys.elementAt(1)] = value!;
                              });
                            },
                          ),

                          CheckboxListTile(
                            title: Text(illnessMap.keys.elementAt(2)),
                            value: illnessMap[illnessMap.keys.elementAt(2)], //gets value
                            onChanged: (bool? value) {
                            setState(() {
                                illnessMap[illnessMap.keys.elementAt(2)] = value!;
                            });
                          },),
                           
                          CheckboxListTile(
                            title: Text(illnessMap.keys.elementAt(3)),
                            value: illnessMap[illnessMap.keys.elementAt(3)], //gets value
                            onChanged: (bool? value) {
                              setState(() {
                                  illnessMap[illnessMap.keys.elementAt(3)] = value!;
                              });
                            },
                          ),

                          CheckboxListTile(
                            title: Text(illnessMap.keys.elementAt(4)),
                            value: illnessMap[illnessMap.keys.elementAt(4)], //gets value
                            onChanged: (bool? value) {
                            setState(() {
                                illnessMap[illnessMap.keys.elementAt(4)] = value!;
                            });
                          },),
                           
                          CheckboxListTile(
                            title: Text(illnessMap.keys.elementAt(5)),
                            value: illnessMap[illnessMap.keys.elementAt(5)], //gets value
                            onChanged: (bool? value) {
                              setState(() {
                                  illnessMap[illnessMap.keys.elementAt(5)] = value!;
                              });
                            },
                          ),

                          CheckboxListTile(
                            title: Text(illnessMap.keys.elementAt(6)),
                            value: illnessMap[illnessMap.keys.elementAt(6)], //gets value
                            onChanged: (bool? value) {
                            setState(() {
                                illnessMap[illnessMap.keys.elementAt(6)] = value!;
                            });
                          },),
                           
                          CheckboxListTile(
                            title: Text(illnessMap.keys.elementAt(7)),
                            value: illnessMap[illnessMap.keys.elementAt(7)], //gets value
                            onChanged: (bool? value) {
                              setState(() {
                                  illnessMap[illnessMap.keys.elementAt(7)] = value!;
                              });
                            },
                          ),

                          allergies,
                          ],
                        )
                      ),


            signupButton,
            backButton])),
          ],
        ),
      ),
    );
  }
}
