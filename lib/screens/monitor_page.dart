import 'package:cmsc23_b5l_project/models/log_model.dart';
import 'package:cmsc23_b5l_project/providers/log_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";
import 'log_detail_page.dart';
import 'package:search_page/search_page.dart';


class EntranceMonitorPage extends StatefulWidget {
  const EntranceMonitorPage({super.key});

  @override
  State<EntranceMonitorPage> createState() => _EntranceMonitorPageState();
}

class _EntranceMonitorPageState extends State<EntranceMonitorPage> {
  List<Log> userSearchItem = [];

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> logsStream = context.watch<LogProvider>().logs;

    return StreamBuilder(
      stream: logsStream,
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

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Container( 
                margin: const EdgeInsets.only(top:10, bottom:20),
                child: Text('Logs', style: TextStyle(fontSize:50, fontWeight: FontWeight.w500),)
              ),

              // dropdown to see if quarantined or under monitoring
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: 
                
                Row(
                  children: [
                  Expanded(
                    child: FloatingActionButton.extended(// search
                      label: Text('Search student logs'),
                      icon: const Icon(Icons.search),
                      tooltip: 'Search students',
                      onPressed: () => showSearch(
                        context: context,
                        delegate: SearchPage(
                          onQueryUpdate: print,
                          items: userSearchItem,
                          searchLabel: 'Search students',
                          suggestion: const 
                          Padding(
                            padding: EdgeInsets.all(30),
                            child: Center(
                            child: Text('Filter students by name, course, college, student number, status, location, and date'),
                          )),
                          failure: const Center(
                            child: Text('No person found :('),
                          ),
                          filter: (log) => [
                            log.name,
                            log.college,
                            log.course,
                            log.studentnum,
                            log.status,
                            log.location,
                            log.date
                          ],
                          sort: (a, b) => a.compareTo(b),
                          builder: (entry) => 
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              tileColor: Colors.white,
                              title: Text(entry.name, style: TextStyle(fontSize: 16)),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(entry.studentnum),
                                Text('${entry.college} - ${entry.course}'),
                              ],
                            ),
                            )
                        ),
                      ),
                    ),
                  ),
                ],)
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: ((context, index) {
                    Log log = Log.fromJson(
                        snapshot.data?.docs[index].data() as Map<String, dynamic>);
                    log.id = snapshot.data?.docs[index].id;
                    userSearchItem.add(log);
                    
                    return Dismissible(
                      key: Key(log.id.toString()),
                      onDismissed: (direction) {
                //context.read<SlambookProvider>().deleteEntry(entry.id!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${log.name} dismissed')));
                    },

                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),

                  child: 
                    Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LogDetailScreen(log: log, type: 'add')));
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      tileColor: Colors.white,
                      title: Text(
                        log.name, 
                        style: TextStyle(fontSize: 16)
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                              icon: Icon(Icons.edit_outlined),
                              onPressed:(){ //widget.log.name
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LogDetailScreen(log: log, type: 'edit')));
                              }
                            ),
                          
                          ),
                        ],
                      ),
                      )
                    ),
                  );
                }
              ),
            ),),
            ],
          ),
        );
      },
    );
  }
}