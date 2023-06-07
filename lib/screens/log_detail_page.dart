import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/log_model.dart';
import "package:provider/provider.dart";
import '../providers/log_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogDetailScreen extends StatelessWidget {
  LogDetailScreen({super.key, required this.log, this.type});

  final Log log;
  List<Widget>? textWidgetList;
  String? type;
  TextEditingController statusController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController studentnumController = TextEditingController();
  var formatter = DateFormat('MM/dd/yyyy');
  
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> entriesStream = context.watch<LogProvider>().underquarantine;

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
    
    return Scaffold(
      body: 
      
      type == 'add' ? Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          CircleAvatar(
              radius: 45,
              backgroundColor: Colors.purple[200],
              child: Text(log.name[0],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50))),
          Padding(padding: EdgeInsets.all(10)),
          Row(children: [
            Expanded(flex: 3,
              child: Text("Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${log.name}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Username", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${log.username}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Student number", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${log.studentnum}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("College", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
                           //if true, Yes, else No
              child: Text("${log.college}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Course", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${log.course}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${log.status}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Location", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${log.location}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Row(children: [
            Expanded(flex: 3,
              child: Text("Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Expanded(flex: 4,
              child: Text("${formatter.format(DateTime.fromMillisecondsSinceEpoch(log.date!.seconds * 1000))}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
            ),
          ],),

          Padding(padding: EdgeInsets.only(top: 30)),
          TextButton(
            onPressed: () {Navigator.pop(context);},
            child: const Text('Back',
            style: TextStyle(
              fontSize: 16)),
          ),
          ],
        ),
      ) : Column(children: [ //if edit
        Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              //initialValue: log.location,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter location",
                  labelText: "Location"),
              controller: locationController..text = log.location!,
            ),
          ),

        Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              //initialValue: log.status,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter status",
                  labelText: "Status"),
              controller: statusController..text = log.status!,
            ),
          ),

        Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              //initialValue: log.studentnum,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter student number",
                  labelText: "Student number"),
              controller: studentnumController..text = log.studentnum,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: TextButton(
              onPressed: () {  
                //update logs
                context.read<LogProvider>().updateLog(
                  log.id!, 
                  locationController.text,
                  statusController.text,
                  studentnumController.text);
                Navigator.pop(context);
              },
              child: const Text('Update Log', style: TextStyle(fontSize: 16))
            ),
          ),

          TextButton(
            onPressed: () {Navigator.pop(context);},
            child: const Text('Back',
            style: TextStyle(
              fontSize: 16)),
          ),
          ],
          ),
        );
      }
    );
  }
}