import 'package:cmsc23_b5l_project/models/user_model.dart';
import 'package:cmsc23_b5l_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";
import 'package:cmsc23_b5l_project/screens/student_detail_page.dart';
import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/widgets/user_item.dart';
import 'package:cmsc23_b5l_project/widgets/entry_item.dart';
import 'user_detail_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final userList = User.userList();

  static final List<String> _dropdownOptions = [
    "Default",
    "Quarantined",
    "Under monitoring"
  ];

  Map<String, dynamic> formValues = {
    'dropdownValue': _dropdownOptions.first,
  };

  void categorySelection(String? value) {
    setState(() {
      formValues["dropdownValue"] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot>? entriesStream;
    if (formValues["dropdownValue"] == "Quarantined") {
      entriesStream = context.watch<UserProvider>().quarantined;
    } else if (formValues["dropdownValue"] == "Under monitoring") {
      entriesStream = context.watch<UserProvider>().undermonitoring;
    } else {
      entriesStream = context.watch<UserProvider>().entries;
    }

    return StreamBuilder(
      stream: entriesStream, //change this based on dropdown value
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
                child: Text('Users', style: TextStyle(fontSize:50, fontWeight: FontWeight.w500),)
              ),
              // searchBox(),

              // dropdown to see if quarantined or under monitoring
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: DropdownButtonFormField<String>(
                    value: _dropdownOptions.first,
                    onChanged: categorySelection,
                    items: _dropdownOptions.map<DropdownMenuItem<String>>(
                    (String value) {
                        return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        );
                    },
                    ).toList(),
                    //onSaved only in forms
                    onSaved: (newValue) {
                      print("Dropdown onSaved method triggered");
                    },
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: ((context, index) {
                    User entry = User.fromJson(
                        snapshot.data?.docs[index].data() as Map<String, dynamic>);
                    entry.id = snapshot.data?.docs[index].id;
                    
                    return Dismissible(
                      key: Key(entry.id.toString()),
                      onDismissed: (direction) {
                //context.read<SlambookProvider>().deleteEntry(entry.id!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${entry.name} dismissed')));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailScreen(user: entry)));
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      tileColor: Colors.white,
                      title: Text(
                        entry.name, 
                        style: TextStyle(fontSize: 16)),
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
                              onPressed:(){
                                // print('click on delete icon');
                                // onDeleteItem(todo.id);
                              }),),
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
                              icon: Icon(Icons.delete),
                              onPressed:(){
                                print('click on delete icon');
                                // onDeleteItem(todo.id);
                              }
                            ),),
                    ],
                ),),),
                );
                }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
