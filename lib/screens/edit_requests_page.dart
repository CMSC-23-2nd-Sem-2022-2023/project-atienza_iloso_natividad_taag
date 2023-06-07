import 'package:cmsc23_b5l_project/screens/add_entry_page.dart';
import 'package:cmsc23_b5l_project/screens/history_page.dart';
import 'package:cmsc23_b5l_project/screens/home_page.dart';
import 'package:cmsc23_b5l_project/screens/profile_page.dart';
import 'package:cmsc23_b5l_project/screens/admin_page.dart';
import 'package:cmsc23_b5l_project/screens/monitor_page.dart';
import 'package:cmsc23_b5l_project/screens/edit_requests_page.dart';
import 'package:cmsc23_b5l_project/screens/delete_requests_page.dart';
import 'package:cmsc23_b5l_project/widgets/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/entry.dart';
import '../providers/entry_provider.dart';
import '../screens/user_details.dart';
import '../providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/login.dart';

class EditRequestsPage extends StatefulWidget {
  const EditRequestsPage({super.key});

  @override
  State<EditRequestsPage> createState() => _EditRequestsPageState();
}

class _EditRequestsPageState extends State<EditRequestsPage> {

  @override
  Widget build(BuildContext context) {

    bool _hasEntryToday = false;
    // Debugging
    _hasEntryToday = true;

    Stream<User?> userStream = context.watch<AuthProvider>().userStream;
    Stream<QuerySnapshot>? editReqStream = context.watch<EntryProvider>().editRequests;

    return StreamBuilder(
        stream: editReqStream, //change this based on dropdown value
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text("No Entries Found"),
            );
        }
          // if user is logged in, display the scaffold containing the streambuilder for the todos
          return displayScaffold(context, snapshot);
        });
  }

  Scaffold displayScaffold(BuildContext context, snapshot) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
           DrawerHeader(
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage()));
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
              Navigator.pop(
                  context,
                  );
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
        body: Column(
            children: [
              Container( 
                margin: const EdgeInsets.only(top:10, bottom:20),
                child: Text('Edit Requests', style: TextStyle(fontSize:20, fontWeight: FontWeight.w500),)
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: ((context, index) {
                    Entry entry = Entry.fromJson(
                        snapshot.data?.docs[index].data() as Map<String, dynamic>);
                    entry.id = snapshot.data?.docs[index].id;

                    return
                    Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      tileColor: Colors.white,
                      title: Text('id: ${entry.id}',
                        style: TextStyle(fontSize: 16)
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          //approve
                          Container( //edit button
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            height:35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: IconButton(
                              color: Colors.white,
                              iconSize: 18,
                              icon: Icon(Icons.check),
                              onPressed:(){
                                // List<String> ill = [];
                                // context.read<EntryProvider>().editEntry(entry.id!, ill);
                              }
                            ),
                          ),

                          // reject edit request
                          Container( //delete button
                            // padding: EdgeInsets.only(),
                            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            height:35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Color(0xFFDA4040),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: IconButton(
                              color: Colors.white,
                              iconSize: 18,
                              icon: Icon(Icons.close),
                              onPressed:(){
                                context.read<EntryProvider>().updateEditRequest(entry.id!, false);
                              }
                            ),
                          ),
                        ],
                      ),
                    )
                  );
                }
              ),
            ),), 
            ],
          ),

        );
  }
}
