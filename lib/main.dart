import 'package:cmsc23_b5l_project/providers/entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_b5l_project/providers/auth_provider.dart';
import 'package:cmsc23_b5l_project/providers/user_provider.dart';
import '../providers/log_provider.dart';
import 'package:cmsc23_b5l_project/screens/home_page.dart';
import 'package:cmsc23_b5l_project/screens/user_details.dart';
import 'package:cmsc23_b5l_project/screens/add_entry_page.dart';
import 'package:cmsc23_b5l_project/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => AuthProvider())),
        ChangeNotifierProvider(create: ((context) => UserProvider())),
        ChangeNotifierProvider(create: ((context) => EntryProvider())),
        ChangeNotifierProvider(create: ((context) => LogProvider())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth',
      initialRoute: '/',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        // colorSchemeSeed: const Color(0xff6750a4),
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const LoginPage(),
        '/add_entry': (context) => const AddEntryPage(),
        '/user_details': (context) => const UserDetailsPage(),
      },
    );
  }
}
