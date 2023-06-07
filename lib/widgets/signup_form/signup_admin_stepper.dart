import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SignUpAdminStepper extends StatefulWidget {
  const SignUpAdminStepper({Key? key}) : super(key: key);

  @override
  _SignUpAdminStepperState createState() => _SignUpAdminStepperState();
}

class _SignUpAdminStepperState extends State<SignUpAdminStepper> {
  int currentStep = 0;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
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

  String? validateEmployeeno(String? course) {
    if (course == null || course.isEmpty) {
      return 'Employee no. is required';
    }
    return null;
  }

  String? validateHomeunit(String? course) {
    if (course == null || course.isEmpty) {
      return 'Home unit is required';
    }
    return null;
  }

  String? validatePosition(String? course) {
    if (course == null || course.isEmpty) {
      return 'Position is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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

    final employeeno = TextFormField(
      validator: validateEmployeeno,
      controller: employeenoController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Employee no.',
      ),
    );

    final homeunit = TextFormField(
      validator: validateHomeunit,
      controller: homeunitController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Home unit',
      ),
    );

    final position = TextFormField(
      validator: validatePosition,
      controller: positionController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Position',
      ),
    );

    List<Step> getSteps() {
      return <Step>[
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text("Personal information"),
          content: Form(
            key: _formKey1,
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.all(8), child: name),
                Padding(padding: const EdgeInsets.all(8), child: employeeno),
                Padding(padding: const EdgeInsets.all(8), child: homeunit),
                Padding(padding: const EdgeInsets.all(8), child: position),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text("Account information"),
          content: Form(
            key: _formKey2,
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.all(8), child: username),
                Padding(padding: const EdgeInsets.all(8), child: email),
                Padding(padding: const EdgeInsets.all(8), child: password),
              ],
            ),
          ),
        ),
      ];
    }

    const continueBtn = Text('Continue');
    const signupBtn = Text('Sign up');

    bool isLastStep = (currentStep == getSteps().length - 1);
    return Center(
        child: Stepper(
      controlsBuilder: (context, details) => Row(
        children: [
          ElevatedButton(
            onPressed: details.onStepContinue,
            child: isLastStep ? signupBtn : continueBtn,
          ),
          const SizedBox(width: 8.0),
          TextButton(
            onPressed: details.onStepCancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
      type: StepperType.vertical,
      currentStep: currentStep,
      onStepCancel: () => currentStep == 0
          ? Navigator.pop(context)
          : setState(() {
              currentStep -= 1;
            }),
      onStepContinue: () async {
        if (isLastStep) {
          illnessMap.forEach((k, v) {
            v ? illnesses.add(k) : 0;
          });

          await context
              .read<AuthProvider>()
              .signUp(nameController.text, emailController.text, passwordController.text);

          await context.read<AuthProvider>().addAdminEmonitor(
              //add user when signing up
              emailController.text,
              nameController.text,
              employeenoController.text,
              positionController.text,
              homeunitController.text);

          if (context.mounted) Navigator.pop(context);
        } else {
          if (currentStep == 0 && !_formKey1.currentState!.validate()) {
            return;
          } else if (currentStep == 1 && !_formKey2.currentState!.validate()) {
            return;
          }
          setState(() {
            currentStep += 1;
          });
        }
      },
      onStepTapped: (step) {
        if (step < currentStep) {
          setState(() {
            currentStep = step;
          });
          return;
        } else if (currentStep == 0 && !_formKey1.currentState!.validate()) {
          return;
        } else if (currentStep == 1 && !_formKey2.currentState!.validate()) {
          return;
        }

        setState(() {
          currentStep = step;
        });
      },
      steps: getSteps(),
    ));
  }
}
