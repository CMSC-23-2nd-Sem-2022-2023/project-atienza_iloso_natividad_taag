import 'package:flutter/material.dart';
import '../models/user_model.dart';
import "package:provider/provider.dart";
import '../providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailScreen extends StatelessWidget {
  UserDetailScreen({super.key, required this.user});

  final User user;
  List<Widget>? textWidgetList;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> entriesStream = context.watch<UserProvider>().underquarantine;

    return StreamBuilder(
      stream: entriesStream, //change this based on dropdown value
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
    
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          CircleAvatar(
              radius: 45,
              backgroundColor: Colors.purple[200],
              child: Text(user.name[0],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50))),
          Padding(padding: EdgeInsets.all(10)),
          Row(children: [
            Expanded(flex: 3,
              child: Text("Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${user.name}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Username", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${user.username}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Student number", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${user.studentnum}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("College", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
                           //if true, Yes, else No
              child: Text("${user.college}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Course", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${user.course}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Illnesses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text(user.illnesses!.join(", "), style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Allergies", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${user.allergies}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Quarantined or Under monitoring?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${user.status}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          user.status == 'Under Quarantine' ?
          Column(children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            Text('Number of students quarantined: ${snapshot.data?.docs.length}', style: TextStyle(
              fontSize: 18)),
            TextButton(
            onPressed: () {
              context.read<UserProvider>().updateStatus(user.id!, "Cleared");
              Navigator.pop(context);
            },
            child: Text('Remove student from quarantine',
            style: TextStyle(
              fontSize: 16)),
          ),
          ],) : 
          Column(children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            Text('Number of students quarantined: ${snapshot.data?.docs.length}', style: TextStyle(
              fontSize: 18)),
            TextButton(
            onPressed: () {
              context.read<UserProvider>().updateStatus(user.id!, "Under Quarantine");
              Navigator.pop(context);
            },
            child: Text('Add student to quarantine',
            style: TextStyle(
              fontSize: 16)),
          ),
          ],),

          user.status == 'Under Monitoring' ?
          Column(children: [
            Padding(padding: EdgeInsets.only(top: 30)),
            TextButton(
            onPressed: () {
              context.read<UserProvider>().updateStatus(user.id!, "Cleared");
              Navigator.pop(context);
            },
            child: Text('End monitoring',
            style: TextStyle(
              fontSize: 16)),
            ),

            Padding(padding: EdgeInsets.only(top: 10)),
            TextButton(
            onPressed: () {
              context.read<UserProvider>().updateStatus(user.id!, "Under Quarantine");
              Navigator.pop(context);
            },
            child: Text('Move to quarantine',
            style: TextStyle(
              fontSize: 16)),
            ),
          ],) : Container(),

          Padding(padding: EdgeInsets.only(top: 20)),
          Center(child: Text('Elevate user to:', style: TextStyle(
              fontSize: 18))),
          Padding(padding: EdgeInsets.only(top: 5)),
          Center(child: Column(children: [
            TextButton(
            onPressed: () {
              context.read<UserProvider>().updateUserType(user.id!, user.email, user.name, "admin");
              Navigator.pop(context);
            },
            child: const Text('Elevate to admin',
            style: TextStyle(
              fontSize: 16)),
          ),
          TextButton(
            onPressed: () {
              context.read<UserProvider>().updateUserType(user.id!, user.email, user.name, "monitor");
              Navigator.pop(context);
            },
            child: const Text('Elevate to entrance monitor',
            style: TextStyle(
              fontSize: 16)),
          ),
          ],)
          ),

          Padding(padding: EdgeInsets.only(top: 30)),
          TextButton(
            onPressed: () {Navigator.pop(context);},
            child: const Text('Back',
            style: TextStyle(
              fontSize: 16)),
          ),
          ],
        ),
      ),
    );
      }
    );
  }
}