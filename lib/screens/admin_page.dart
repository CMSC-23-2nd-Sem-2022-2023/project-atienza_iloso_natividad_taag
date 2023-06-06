import 'package:cmsc23_b5l_project/models/user_model.dart';
import 'package:cmsc23_b5l_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";
import 'package:cmsc23_b5l_project/screens/student_detail_page.dart';
import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/widgets/user_item.dart';
import 'package:cmsc23_b5l_project/widgets/entry_item.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final userList = User.userList();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> entriesStream = context.watch<UserProvider>().users;

    return StreamBuilder(
      stream: entriesStream,
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

        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: ((context, index) {
            User entry = User.fromJson(
                snapshot.data?.docs[index].data() as Map<String, dynamic>);
            entry.id = snapshot.data?.docs[index].id;

            return Container();
            //
            // return Dismissible(
            //   key: Key(entry.id.toString()),
            //   onDismissed: (direction) {
            //     //context.read<SlambookProvider>().deleteEntry(entry.id!);

            //     ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text('Aira dismissed')));
            //   },
            //   background: Container(
            //     color: Colors.red,
            //     child: const Icon(Icons.delete),
            //   ),
            // child: Container(margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            // child: ListTile(
            //   shape: RoundedRectangleBorder( //<-- SEE HERE
            //       side: BorderSide(
            //         width: 2,
            //         color: Colors.grey
            //       ),
            //       borderRadius: BorderRadius.circular(20)
            //     ),
            //     leading: CircleAvatar(
            //       backgroundColor: Colors.purple[200],
            //       child: Text('Aira',
            //       style: TextStyle(fontWeight: FontWeight.bold)),
            //     ),
            //     title: Text('entry.name'),
            //     onTap: () {

            //     },
            //     trailing: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         IconButton(
            //           onPressed: () {

            //           },
            //           icon: const Icon(Icons.create_outlined),
            //         ),
            //         IconButton(
            //           onPressed: () {

            //           },
            //           icon: const Icon(Icons.delete_outlined),
            //         )
            //       ],
            //     ),
            //   ),),
            // );
          }),
        );
      },
    );
  }
}
