import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/providers/entry_provider.dart';
import 'package:cmsc23_b5l_project/screens/add_entry_page.dart';
import 'package:cmsc23_b5l_project/screens/delete_requests_page.dart';
import 'package:cmsc23_b5l_project/screens/edit_requests_page.dart';
import 'package:cmsc23_b5l_project/screens/history_page.dart';
import 'package:cmsc23_b5l_project/screens/profile_page.dart';
import 'package:cmsc23_b5l_project/screens/admin_page.dart';
import 'package:cmsc23_b5l_project/screens/monitor_page.dart';
import 'package:cmsc23_b5l_project/screens/login.dart';
import 'package:cmsc23_b5l_project/screens/user_details.dart';
import 'package:cmsc23_b5l_project/widgets/bottom_nav_bar.dart';
import 'package:cmsc23_b5l_project/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    const AdminPage(),

    EntranceMonitorPage()
  ];

  @override
  Widget build(BuildContext context) {
    Stream<User?> userStream = context.watch<AuthProvider>().userStream;

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
          // String uid = snapshot.data!.uid;
          context.watch<AuthProvider>().setCurrentUser(snapshot.data!);

          // if user is logged in, display the scaffold containing the streambuilder for the todos

          return displayScaffold(context);
        });
  }

  Scaffold displayScaffold(BuildContext context) {
    bool fabVisible = true;
    Entry? entry = context.watch<EntryProvider>().cUserLatestEntry;
    if (entry != null) {
      var formatter = DateFormat('MM/dd/yyyy');
      String latestEntryDate = formatter.format(
          DateTime.fromMillisecondsSinceEpoch(entry.date.seconds * 1000));
      String dateNow = formatter.format(DateTime.now());

      DateTime date1 = formatter.parse(latestEntryDate);
      DateTime date2 = formatter.parse(dateNow);

      int comparison = date1.compareTo(date2);

      if (comparison < 0) {
        print('$date1 is earlier than $date2');
        fabVisible = true;
      } else if (comparison > 0) {
        print('$date1 is later than $date2');
        fabVisible = false;
      } else {
        print('$date1 is the same as $date2');
        fabVisible = false;
      }
    }

    return Scaffold(
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 209, 228, 255),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.health_and_safety,
                    size: 60,
                    color: Color.fromARGB(255, 0, 28, 53),
                  ),
                  Text(
                    'SiHealth Monitoring App',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 28, 53),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(
                  context,
                  );
            },
          ),
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
            title: const Text('Edit Requests'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditRequestsPage()));
            },
          ),
          ListTile(
            title: const Text('Delete Requests'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeleteRequestsPage()));
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
          visible: fabVisible,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddEntryPage(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}
