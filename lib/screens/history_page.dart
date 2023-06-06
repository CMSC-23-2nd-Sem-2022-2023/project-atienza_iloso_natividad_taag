import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/models/user_model.dart';
import 'package:cmsc23_b5l_project/widgets/entry_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
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

    return Container(
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
                child: Text("PANIC! There are no entries in the database!!"));
          }

          context
              .watch<EntryProvider>()
              .setEntryCount(snapshot.data!.docs.length);

          var user = context.watch<AuthProvider>().getCurrentUser;

          final entries = snapshot.data!.docs;
          final userEntries =
              entries.where((entry) => entry['uid'] == user.uid).toList();

          if (userEntries.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    'Hello, ${user.displayName}!',
                    style: const TextStyle(
                        fontSize: 50, fontWeight: FontWeight.w500),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    'You have no entries yet',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            );
          }

          bool headerRendered = false;
          return ListView.builder(
            itemCount: userEntries.length + 1,
            itemBuilder: ((context, index) {
              final adjustedIndex = index - 1;
              if (headerRendered == false) {
                headerRendered = true;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        'Hello, ${user.displayName}!',
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                );
              } else {
                final entry = Entry.fromJson(snapshot.data?.docs[adjustedIndex]
                    .data() as Map<String, dynamic>);
                entry.id = snapshot.data?.docs[adjustedIndex].id;

                return EntryItem(
                  key: Key(entry.id!),
                  entry: entry,
                );
              }
              // print(index);
            }),
          );
        },
      ))
    ]));
  }
}
