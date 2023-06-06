import 'package:flutter/material.dart';
import '../models/user_model.dart';
import "package:provider/provider.dart";
import '../providers/user_provider.dart';

class StudentDetailScreen extends StatelessWidget {
  StudentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 45,
                backgroundColor: Colors.purple[200],
                child: Text('A',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50))),
            Padding(padding: EdgeInsets.all(10)),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Name",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
