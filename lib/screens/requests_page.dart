import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/providers/entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import "package:provider/provider.dart";
import 'user_detail_page.dart';
import 'package:search_page/search_page.dart';
import '../providers/entry_provider.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {

  var formatter = DateFormat('MM/dd/yyyy');

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot>? editReqStream = context.watch<EntryProvider>().editRequests;
    Stream<QuerySnapshot>? deleteReqStream = context.watch<EntryProvider>().deleteRequests;

    // first stream builder for edit
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

        // 2nd stream builder for delete
        return StreamBuilder(
        stream: deleteReqStream, //change this based on dropdown value
        builder: (context, snapshot2) {
          if (snapshot2.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot2.error}"),
            );
          } else if (snapshot2.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot2.hasData) {
            return Center(
              child: Text("No Entries Found"),
            );
        }

        // edit stream
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
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

            // delete stream
            Container( 
              margin: const EdgeInsets.only(top:10, bottom:20),
              child: Text('Delete Requests', style: TextStyle(fontSize:20, fontWeight: FontWeight.w500),)
            ),

            Expanded(
              child: ListView.builder(
                itemCount: snapshot2.data?.docs.length,
                itemBuilder: ((context, index) {
                  Entry entry2 = Entry.fromJson(
                      snapshot2.data?.docs[index].data() as Map<String, dynamic>);
                  entry2.id = snapshot2.data?.docs[index].id;

                  return
                  Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    tileColor: Colors.white,
                    title: Text('id: ${entry2.id}',
                      style: TextStyle(fontSize: 16)
                    ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //approve requests
                          Container( //delete button
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
                                List<String> ill = [];
                                context.read<EntryProvider>().deleteEntry(entry2.id!);
                              }
                            ),
                          ),

                          // reject requests
                          Container(
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
                                // change toDelete to false
                                context.read<EntryProvider>().makeDeleteRequest(entry2.id!, false);
                              }
                            ),

                          ),
                        ],
                      ),
                    )
                  );
                }
              ),
            ),),],
          ),
        );},
        );
      }
    );
  }
}