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
    return // Stack(
        //children: [
        Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(children: [
        // searchBox(),
        Expanded(
          child: ListView(
            children: [
              Container(
                  // color:Colors.blue,
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    'Users',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
                  )),
              for (User user in userList)
                UserItem(
                  user: user,
                  onEntryEdit: () {},
                  onEntryDelete: () {},
                )
            ],
          ),
        ),
      ]),
      //),
      //]
    );
  // final userList = User.userList();

  // @override
  // Widget build(BuildContext context) {
  //   // TODO : Confirm use of stack; found unnecessary at current layout.
  //   return // Stack(
  //       //children: [
  //       Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //     child: Column(children: [
  //       // searchBox(),
  //       Expanded(
  //         child: ListView(
  //           children: [
  //             Container(
  //                 // color:Colors.blue,
  //                 margin: const EdgeInsets.only(top: 10, bottom: 20),
  //                 child: Text(
  //                   'Entries',
  //                   style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
  //                 )),
  //             for (User user in userList)
  //               UserItem(
  //                 user: user,
  //                 onEntryEdit: () {},
  //                 onEntryDelete: () {},
  //               )
  //           ],
  //         ),
  //       ),
  //     ],
  //     ),
  //     //),
  //     //]
  //   )


  }
}