import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/widgets/entry_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    //final entryList = Entry.entryList();

  @override
  Widget build(BuildContext context) {
    return       Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Text('add page')
              ]
            ),
          ),
        ]
      );
  }
}