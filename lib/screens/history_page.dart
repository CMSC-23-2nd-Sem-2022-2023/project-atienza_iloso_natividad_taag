import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/widgets/entry_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
    final entryList = Entry.entryList();

  @override
  Widget build(BuildContext context) {
    return       Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                // searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        // color:Colors.blue,
                        margin: EdgeInsets.only(top:50, bottom:20),
                        child:Text('Entries', style: TextStyle(fontSize:30, fontWeight: FontWeight.w500),)
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
          ),
        ]
      );
  }
}