//  Last Updated: May 25, 2023
//  Last Updated By: Atienza
//  Add Entry Page
//    When add entry button is clicked, User is routed here to answer a form.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_b5l_project/providers/entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class AddEntryPage extends StatefulWidget {
  final Entry? entry;
  const AddEntryPage({super.key, this.entry});
  @override
  _AddEntryPageState createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> addEntryMap = {
    "Fever (37.8 C and above)": false,
    "Feeling feverish": false,
    "Muscle or joint pains": false,
    "Cough": false,
    "Colds": false,
    "Sore throat": false,
    "Difficulty of breathing": false,
    "Diarrhea": false,
    "Loss of taste": false,
    "Loss of smell": false,
    "None of the above": false,
    "isExposed": false,
  };

  @override
  Widget build(BuildContext context) {
    String uid = context.watch<AuthProvider>().getCurrentUser.uid;
    int id = context.watch<EntryProvider>().entryCount! + 1;

    final addEntryButton = SizedBox(
      width: 300.0,
      height: 40.0,
      // height: 100.0,
      child: ElevatedButton(
        onPressed: () async {
          // update firebase
          var tempMap = addEntryMap;
          tempMap.remove("None of the above");
          Entry temp = Entry(id: id.toString(), date: Timestamp.now(), illnesses: tempMap, uid: uid);

          context.read<EntryProvider>().addEntry(temp);
          Navigator.of(context).pop();
        },
        child: const Text('Add Entry', style: TextStyle(color: Color.fromARGB(255, 75, 75, 75))),
      ),
    );

    final backButton = SizedBox(
      width: 300.0,
      height: 40.0,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Color.fromARGB(255, 75, 75, 75))),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add today's entry"),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 28, 0, 8),
                    child: Text(
                      "Symptoms",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  const Text(
                    "Please tick all the symptoms that apply",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13),
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      minWidth: 150,
                      maxWidth: 300,
                    ),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: Text(addEntryMap.keys.elementAt(0)),
                          value: addEntryMap[
                              addEntryMap.keys.elementAt(0)], //gets value
                          onChanged: (bool? value) {
                            setState(() {
                              addEntryMap[addEntryMap.keys.elementAt(0)] =
                                  value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(addEntryMap.keys.elementAt(1)),
                          value: addEntryMap[
                              addEntryMap.keys.elementAt(1)], //gets value
                          onChanged: (bool? value) {
                            setState(() {
                              addEntryMap[addEntryMap.keys.elementAt(1)] =
                                  value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(addEntryMap.keys.elementAt(2)),
                          value: addEntryMap[
                              addEntryMap.keys.elementAt(2)], //gets value
                          onChanged: (bool? value) {
                            setState(() {
                              addEntryMap[addEntryMap.keys.elementAt(2)] =
                                  value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(addEntryMap.keys.elementAt(3)),
                          value: addEntryMap[
                              addEntryMap.keys.elementAt(3)], //gets value
                          onChanged: (bool? value) {
                            setState(() {
                              addEntryMap[addEntryMap.keys.elementAt(3)] =
                                  value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(addEntryMap.keys.elementAt(4)),
                          value: addEntryMap[
                              addEntryMap.keys.elementAt(4)], //gets value
                          onChanged: (bool? value) {
                            setState(() {
                              addEntryMap[addEntryMap.keys.elementAt(4)] =
                                  value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(addEntryMap.keys.elementAt(5)),
                          value: addEntryMap[
                              addEntryMap.keys.elementAt(5)], //gets value
                          onChanged: (bool? value) {
                            setState(() {
                              addEntryMap[addEntryMap.keys.elementAt(5)] =
                                  value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(addEntryMap.keys.elementAt(6)),
                          value: addEntryMap[
                              addEntryMap.keys.elementAt(6)], //gets value
                          onChanged: (bool? value) {
                            setState(() {
                              addEntryMap[addEntryMap.keys.elementAt(6)] =
                                  value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(addEntryMap.keys.elementAt(7)),
                          value: addEntryMap[
                              addEntryMap.keys.elementAt(7)], //gets value
                          onChanged: (bool? value) {
                            setState(() {
                              addEntryMap[addEntryMap.keys.elementAt(7)] =
                                  value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(addEntryMap.keys.elementAt(8)),
                          value: addEntryMap[
                              addEntryMap.keys.elementAt(8)], //gets value
                          onChanged: (bool? value) {
                            setState(() {
                              addEntryMap[addEntryMap.keys.elementAt(8)] =
                                  value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(addEntryMap.keys.elementAt(9)),
                          value: addEntryMap[
                              addEntryMap.keys.elementAt(9)], //gets value
                          onChanged: (bool? value) {
                            setState(() {
                              addEntryMap[addEntryMap.keys.elementAt(9)] =
                                  value!;
                            });
                          },
                        ),
                        SwitchListTile(
                          title: Text(addEntryMap.keys.elementAt(10)),
                          value: addEntryMap[
                              addEntryMap.keys.elementAt(10)], //gets value
                          onChanged: (bool? value) {
                            setState(() {
                              addEntryMap[addEntryMap.keys.elementAt(10)] =
                                  value!;
                              for (int i = 0;
                                  i < (addEntryMap.length - 2);
                                  i++) {
                                addEntryMap[addEntryMap.keys.elementAt(i)] =
                                    false;
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Exposure",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                        SwitchListTile(
                            title: const Text(
                                'Did you have a face-to-face encounter or contact with a confirmed COVID-19 case?'),
                            value: addEntryMap["isExposed"],
                            onChanged: (bool value) {
                              setState(() {
                                addEntryMap["isExposed"] = value;
                              });
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  addEntryButton,
                  const SizedBox(
                    height: 8,
                  ),
                  backButton,
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
