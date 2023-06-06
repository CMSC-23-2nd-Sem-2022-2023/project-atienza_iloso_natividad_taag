import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/widgets/entry_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
    final entryList = Entry.entryList();

  @override
  Widget build(BuildContext context) { // TODO : Confirm use of stack; found unnecessary at current layout.
    return      // Stack(
        //children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                // searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container( 
                        // color:Colors.blue,
                        margin: const EdgeInsets.only(top:10, bottom:20),
                        child: Text('Entries', style: TextStyle(fontSize:50, fontWeight: FontWeight.w500),)
                      ),
                      
                      for(Entry entry in entryList)
                        EntryItem(
                          entry: entry, 
                          onEntryEdit: (){}, 
                          onEntryDelete: (){},
                        )
                    ],
                  ),
                ),
              ]
            ),
          //),
        //]
      );
  }
}