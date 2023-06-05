import 'package:cmsc23_b5l_project/screens/modules/signup_form/form_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';

class SignUpStepper extends StatefulWidget {
  const SignUpStepper({Key? key}) : super(key: key);

  @override
  _SignUpStepperState createState() => _SignUpStepperState();
}

class _SignUpStepperState extends State<SignUpStepper> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
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

    String? validateName(String? name) {
      if (name == null || name.isEmpty) {
        return 'Name is required';
      }
      return null;
    }

    String? validateUsername(String? userName) {
      if (userName == null || userName.isEmpty) {
        return 'Username is required';
      }
      return null;
    }

    String? validateStudentNum(String? studentnum) {
      if (studentnum == null || studentnum.isEmpty) {
        return 'Student number is required';
      } else if (!RegExp(r'^\d{4}-\d{5}$').hasMatch(studentnum)) {
        return 'Student number must follow the format xxxx-xxxxx';
      }
      return null;
    }

    String? validateEmail(String? email) {
      if (email == null || email.isEmpty) {
        return 'Email is required';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        return 'Invalid email format';
      }
      return null;
    }

    String? validatePw(String? pw) {
      if (pw == null || pw.isEmpty) {
        return 'Password is required';
      } else if (!RegExp(r'^.{6,}$').hasMatch(pw)) {
        return 'Password must be at least 6 characters';
      }
      return null;
    }

    String? validateCollege(String? college) {
      if (college == null || college.isEmpty) {
        return 'College is required';
      }
      return null;
    }

    String? validateCourse(String? course) {
      if (course == null || course.isEmpty) {
        return 'Course is required';
      }
      return null;
    }

    final email = TextFormField(
      validator: validateEmail,
      controller: emailController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Email',
      ),
    );

    final password = TextFormField(
      validator: validatePw,
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Password',
      ),
    );

    final username = TextFormField(
      validator: validateUsername,
      controller: usernameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Username',
      ),
    );

    final name = TextFormField(
      validator: validateName,
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Name',
      ),
    );

    final college = TextFormField(
      validator: validateCollege,
      controller: collegeController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'College',
      ),
    );

    final course = TextFormField(
      validator: validateCourse,
      controller: courseController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Course',
      ),
    );

    final studentnum = TextFormField(
      validator: validateStudentNum,
      controller: studentNumController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Student Number',
      ),
    );

    final allergies = TextFormField(
      controller: allergiesController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Allergies',
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

            await context.read<AuthProvider>().addUser(
                //add user when signing up
                emailController.text,
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

    List<Step> getSteps() {
      return <Step>[
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text("Personal information"),
          content: Column(
            children: [
              Padding(padding: EdgeInsets.all(8), child: name),
              Padding(padding: EdgeInsets.all(8), child: studentnum),
              Padding(padding: EdgeInsets.all(8), child: college),
              Padding(padding: EdgeInsets.all(8), child: course),
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text("Account information"),
          content: Column(
            children: [
              Padding(padding: EdgeInsets.all(8), child: email),
              Padding(padding: EdgeInsets.all(8), child: password),
              Padding(padding: EdgeInsets.all(8), child: username),
            ],
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text("Pre existing illness/es"),
          content: Column(
            children: [
              Container(
                  constraints: BoxConstraints(
                    minWidth: 150,
                    maxWidth: 300,
                  ),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text(illnessMap.keys.elementAt(0)),
                        value: illnessMap[
                            illnessMap.keys.elementAt(0)], //gets value
                        onChanged: (bool? value) {
                          setState(() {
                            illnessMap[illnessMap.keys.elementAt(0)] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text(illnessMap.keys.elementAt(1)),
                        value: illnessMap[
                            illnessMap.keys.elementAt(1)], //gets value
                        onChanged: (bool? value) {
                          setState(() {
                            illnessMap[illnessMap.keys.elementAt(1)] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text(illnessMap.keys.elementAt(2)),
                        value: illnessMap[
                            illnessMap.keys.elementAt(2)], //gets value
                        onChanged: (bool? value) {
                          setState(() {
                            illnessMap[illnessMap.keys.elementAt(2)] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text(illnessMap.keys.elementAt(3)),
                        value: illnessMap[
                            illnessMap.keys.elementAt(3)], //gets value
                        onChanged: (bool? value) {
                          setState(() {
                            illnessMap[illnessMap.keys.elementAt(3)] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text(illnessMap.keys.elementAt(4)),
                        value: illnessMap[
                            illnessMap.keys.elementAt(4)], //gets value
                        onChanged: (bool? value) {
                          setState(() {
                            illnessMap[illnessMap.keys.elementAt(4)] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text(illnessMap.keys.elementAt(5)),
                        value: illnessMap[
                            illnessMap.keys.elementAt(5)], //gets value
                        onChanged: (bool? value) {
                          setState(() {
                            illnessMap[illnessMap.keys.elementAt(5)] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text(illnessMap.keys.elementAt(6)),
                        value: illnessMap[
                            illnessMap.keys.elementAt(6)], //gets value
                        onChanged: (bool? value) {
                          setState(() {
                            illnessMap[illnessMap.keys.elementAt(6)] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text(illnessMap.keys.elementAt(7)),
                        value: illnessMap[
                            illnessMap.keys.elementAt(7)], //gets value
                        onChanged: (bool? value) {
                          setState(() {
                            illnessMap[illnessMap.keys.elementAt(7)] = value!;
                          });
                        },
                      ),
                      allergies,
                    ],
                  )),
            ],
          ),
        ),
      ];
    }

    return SingleChildScrollView(
        child: Stepper(
      type: StepperType.vertical,
      currentStep: currentStep,
      onStepCancel: () => currentStep == 0
          ? null
          : setState(() {
              currentStep -= 1;
            }),
      onStepContinue: () {
        bool isLastStep = (currentStep == getSteps().length - 1);
        if (isLastStep) {
          //Do something with this information
        } else {
          setState(() {
            currentStep += 1;
          });
        }
      },
      onStepTapped: (step) => setState(() {
        currentStep = step;
      }),
      steps: getSteps(),
    ));
  }
}
