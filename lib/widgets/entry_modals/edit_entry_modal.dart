import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_b5l_project/providers/entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEntryModal extends StatefulWidget {
  final Entry entry;
  const EditEntryModal({super.key, required this.entry});
  @override
  _EditEntryPageState createState() => _EditEntryPageState();
}

class _EditEntryPageState extends State<EditEntryModal> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> editEntryMap = {
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
    "isExposed": false,
  };

  @override
  void initState() {
    super.initState();
    initializeEntryMap();
  }

  void initializeEntryMap() {
    var sourceMap = widget.entry.illnesses;
    sourceMap.putIfAbsent('None of the above', () => false);
    sourceMap.forEach((key, value) {
      if (editEntryMap.containsKey(key)) {
        editEntryMap[key] = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String uid = widget.entry.uid;
    String? entryRefId = widget.entry.id;
    Timestamp date = widget.entry.date;
    Random rng = Random(42);
    int id = Timestamp.now().seconds + rng.nextInt(420);

    var formatter = DateFormat('MM/dd/yyyy');
    String formattedDate = formatter.format(
        DateTime.fromMillisecondsSinceEpoch(widget.entry.date.seconds * 1000));

    final editEntryButton = SizedBox(
      width: 300.0,
      height: 40.0,
      child: ElevatedButton(
        onPressed: () async {
          // update firebase
          var tempMap = editEntryMap;
          tempMap.remove("None of the above");
          EntryEditRequest temp = EntryEditRequest(
              id: id.toString(),
              entryRefId: entryRefId,
              date: date,
              illnesses: tempMap,
              uid: uid);

          context.read<EntryProvider>().createEditRequest(temp);
          context.read<EntryProvider>().updateEditRequest(entryRefId!, true);

          Navigator.of(context).pop();
        },
        child: const Text(
          'Edit Entry',
        ),
      ),
    );

    final resetButton = SizedBox(
      width: 300.0,
      height: 40.0,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            editEntryMap[editEntryMap.keys.elementAt(10)] = false;
            for (int i = 0; i < (editEntryMap.length - 2); i++) {
              editEntryMap[editEntryMap.keys.elementAt(i)] = false;
            }
          });
        },
        child: const Text('Reset',
            style: TextStyle(color: Color.fromARGB(255, 53, 0, 0))),
      ),
    );

    final backButton = SizedBox(
      width: 300.0,
      height: 40.0,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back',
            style: TextStyle(color: Color.fromARGB(255, 75, 75, 75))),
      ),
    );

    return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Editing entry for $formattedDate"),
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
                        padding: EdgeInsets.fromLTRB(0, 9, 0, 8),
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
                              title: Text(editEntryMap.keys.elementAt(0)),
                              value: editEntryMap[
                                  editEntryMap.keys.elementAt(0)], //gets value
                              onChanged: (bool? value) {
                                setState(() {
                                  editEntryMap[editEntryMap.keys.elementAt(0)] =
                                      value;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text(editEntryMap.keys.elementAt(1)),
                              value: editEntryMap[
                                  editEntryMap.keys.elementAt(1)], //gets value
                              onChanged: (bool? value) {
                                setState(() {
                                  editEntryMap[editEntryMap.keys.elementAt(1)] =
                                      value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text(editEntryMap.keys.elementAt(2)),
                              value: editEntryMap[
                                  editEntryMap.keys.elementAt(2)], //gets value
                              onChanged: (bool? value) {
                                setState(() {
                                  editEntryMap[editEntryMap.keys.elementAt(2)] =
                                      value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text(editEntryMap.keys.elementAt(3)),
                              value: editEntryMap[
                                  editEntryMap.keys.elementAt(3)], //gets value
                              onChanged: (bool? value) {
                                setState(() {
                                  editEntryMap[editEntryMap.keys.elementAt(3)] =
                                      value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text(editEntryMap.keys.elementAt(4)),
                              value: editEntryMap[
                                  editEntryMap.keys.elementAt(4)], //gets value
                              onChanged: (bool? value) {
                                setState(() {
                                  editEntryMap[editEntryMap.keys.elementAt(4)] =
                                      value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text(editEntryMap.keys.elementAt(5)),
                              value: editEntryMap[
                                  editEntryMap.keys.elementAt(5)], //gets value
                              onChanged: (bool? value) {
                                setState(() {
                                  editEntryMap[editEntryMap.keys.elementAt(5)] =
                                      value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text(editEntryMap.keys.elementAt(6)),
                              value: editEntryMap[
                                  editEntryMap.keys.elementAt(6)], //gets value
                              onChanged: (bool? value) {
                                setState(() {
                                  editEntryMap[editEntryMap.keys.elementAt(6)] =
                                      value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text(editEntryMap.keys.elementAt(7)),
                              value: editEntryMap[
                                  editEntryMap.keys.elementAt(7)], //gets value
                              onChanged: (bool? value) {
                                setState(() {
                                  editEntryMap[editEntryMap.keys.elementAt(7)] =
                                      value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text(editEntryMap.keys.elementAt(8)),
                              value: editEntryMap[
                                  editEntryMap.keys.elementAt(8)], //gets value
                              onChanged: (bool? value) {
                                setState(() {
                                  editEntryMap[editEntryMap.keys.elementAt(8)] =
                                      value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text(editEntryMap.keys.elementAt(9)),
                              value: editEntryMap[
                                  editEntryMap.keys.elementAt(9)], //gets value
                              onChanged: (bool? value) {
                                setState(() {
                                  editEntryMap[editEntryMap.keys.elementAt(9)] =
                                      value!;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            resetButton,
                            const SizedBox(
                              height: 28,
                            ),
                            const Text(
                              "Exposure",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25),
                            ),
                            SwitchListTile(
                                title: const Text(
                                    'Did you have a face-to-face encounter or contact with a confirmed COVID-19 case?'),
                                value: editEntryMap["isExposed"],
                                onChanged: (bool value) {
                                  setState(() {
                                    editEntryMap["isExposed"] = value;
                                  });
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      editEntryButton,
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
        ));
  }
}
