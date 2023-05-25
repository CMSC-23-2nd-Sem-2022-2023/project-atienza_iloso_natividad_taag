//  Last Updated: May 25, 2023
//  Last Updated By: Taag
//  Add Entry Page
//    When add entry button is clicked, User is routed here to answer a form.
//  Missing functionality:
//    Updating firebase when the add entry button is clicked.

import 'package:flutter/material.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage({super.key});
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
    final addEntryButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: ElevatedButton(
        onPressed: () async {
          // update firebase
        },
        child: const Text('Add Entry', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
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
                  const Text(
                    "Symptoms",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
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
                              addEntryMap.keys.elementAt(7)], //gets value
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
                        CheckboxListTile(
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  addEntryButton,
                  backButton
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
