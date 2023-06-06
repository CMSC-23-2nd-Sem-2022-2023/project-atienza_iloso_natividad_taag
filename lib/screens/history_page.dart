import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/providers/user_provider.dart';
import 'package:cmsc23_b5l_project/widgets/entry_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../providers/entry_provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final entryList = Entry.entryList();

  @override
  Widget build(BuildContext context) {
    // TODO : Confirm use of stack; found unnecessary at current layout.
    // TODO : Add conditional for user, admin, emonitor view
    // Stream<QuerySnapshot> entryStream = context.watch<UserProvider>().entries;

    return // Stack(
        //children: [
        Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: buildEntries(),

      // for (Entry entry in entryList)
      //   EntryItem(
      //     entry: entry,
      //     onEntryEdit: () {},
      //     onEntryDelete: () {},
      //   )
      //),
      //]
    );
  }

  Widget buildEntries() {
    Stream<QuerySnapshot> entryStream = context.watch<UserProvider>().entries;
    return Center(
        child: Column(children: [
      Container(
          // color:Colors.blue,
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          child: const Text(
            'Entries',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
          )),
      Flexible(
          child: StreamBuilder(
        stream: entryStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 300.0,
                    height: 40.0,
                    // height: 100.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Entry entry = Entry.fromJson(snapshot.data?.docs[0]
                            .data() as Map<String, dynamic>);
                        print(entry);
                      },
                      child: const Text('Add Entry',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Text("You have no entries yet :<")
                ],
              ),
            );
          }
          return Column(
            children: [
              SizedBox(
                width: 300.0,
                height: 40.0,
                // height: 100.0,
                child: ElevatedButton(
                  onPressed: () {
                    Entry entry = Entry.fromJson(
                        snapshot.data?.docs[0].data() as Map<String, dynamic>);
                    print(entry);
                  },
                  child: const Text('Add Entry',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: ((context, index) {
                  Entry entry = Entry.fromJson(snapshot.data?.docs[index].data()
                      as Map<String, dynamic>);
                  entry.id = snapshot.data?.docs[index].id;
                  return EntryItem(
                      key: Key(entry.id!),
                      entry: entry,
                      onEntryEdit: () {},
                      onEntryDelete: () {});
                }),
              )
            ],
          );
        },
      ))
    ]));
  }
}
