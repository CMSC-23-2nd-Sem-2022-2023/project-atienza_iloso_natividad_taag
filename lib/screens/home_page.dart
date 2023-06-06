import 'package:cmsc23_b5l_project/screens/history_page.dart';
import 'package:cmsc23_b5l_project/screens/profile_page.dart';
import 'package:cmsc23_b5l_project/screens/admin_page.dart';
import 'package:cmsc23_b5l_project/widgets/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/user_details.dart';
import '../providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //this selected index is to control the bottom nav bar
  int _selectedIndex = 0;

  //this method will update our selected index
  //when the user taps on the bottm bar
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages to display
  final List<Widget> _pages = [
    //shop page
    const HistoryPage(),

    //cart page
    const ProfilePage(),
  
    //admin view
    AdminPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Stream<User?> userStream = context.watch<AuthProvider>().uStream;

    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const LoginPage();
          }
          // if user is logged in, display the scaffold containing the streambuilder for the todos
          return displayScaffold(context);
        });
  }

  Scaffold displayScaffold(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
              const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.health_and_safety,
                        size: 60,
                        color: Color.fromARGB(255, 239, 239, 239),
                      ),
                      Text(
                        'SiHealth Monitoring App',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
          ListTile(
            title: const Text('Details'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserDetailsPage()));
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              context.read<AuthProvider>().signOut();
              Navigator.pop(context);
            },
          ),
        ])),
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: MyBottomNavBar(
            // onTabChange: (index) => navigateBottomBar(index),
            onTabChange: (index) {
          navigateBottomBar(index);
        }),
        floatingActionButton: Visibility(
          visible: true,
          child: FloatingActionButton(
            onPressed: () {
              print('yeet');
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}
