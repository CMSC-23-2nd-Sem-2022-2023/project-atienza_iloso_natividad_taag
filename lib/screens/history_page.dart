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
    // Stream<QuerySnapshot> entryStream = context.watch<EntryProvider>().entries;
    Stream<QuerySnapshot> entryStream = context.watch<EntryProvider>().entries;
    return Center(
        child: Column(children: [
      const Padding(
          // color:Colors.blue,
          padding: EdgeInsets.only(top: 10, bottom: 20),
          child: Text(
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
            return const Center(
                child:  Text("You have no entries yet :<")
            );
          }

          context.watch<EntryProvider>().setEntryCount(snapshot.data!.docs.length);
          
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              Entry entry = Entry.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
              entry.id = snapshot.data?.docs[index].id;

              return EntryItem(
                  key: Key(entry.id!),
                  entry: entry,
                  onEntryEdit: () {},
                  onEntryDelete: () {});
            }),
          );
        },
      ))
    ]));
  }
}
