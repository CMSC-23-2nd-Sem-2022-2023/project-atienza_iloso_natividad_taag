import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/signup.dart';
import '../screens/signup_admin_emonitor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      key: const Key('emailField'),
      validator: validateEmail,
      controller: emailController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Email",
      ),
    );

    final password = TextFormField(
      key: const Key('pwField'),
      validator: validatePw,
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Password',
      ),
    );

    final loginButton = Padding(
      key: const Key('loginButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) return;
          await context.read<AuthProvider>().signIn(
                emailController.text.trim(),
                passwordController.text.trim(),
              );
        },
        child: const Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
        },
        child: const Text('Sign Up as User',
            style: TextStyle(color: Colors.white)),
      ),
    );

    final signUpAdminButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignupAdminEmonitorPage(),
            ),
          );
        },
        child: const Text('Sign Up as Admin/Entrance Monitor',
            style: TextStyle(color: Colors.white)),
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
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(padding: const EdgeInsets.fromLTRB(0,48,0,8), child: email),
                    Padding(padding: const EdgeInsets.fromLTRB(0,8,0,8), child: password),
                  ],
                )),
            loginButton,
            signUpButton,
            signUpAdminButton
          ],
        ),
      ),
    );
  }
}
