import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/widgets/entry_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import '../providers/entry_provider.dart';
import '../models/entry.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: buildQR(),
    );
  }

  Widget buildQR() {
    final entryProvider = Provider.of<EntryProvider>(context);
    return FutureBuilder<Entry?>(
      future: entryProvider.entryLatest,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          Entry? entry = snapshot.data;
          if (entry != null) {
            DateTime date = entry.date.toDate();
            DateTime today = DateTime.now();
            bool isToday = date.year == today.year &&
                date.month == today.month &&
                date.day == today.day;
            if (isToday) {
              // Health entry is valid. Evaluate student for building pass generation.
              bool isWithSymptoms = false;
              bool isWithContact = false;
              entry.illnesses.forEach((key, value) {
                if (value == true) {
                  if (key == "isExposed") {
                    isWithContact = true;
                  }
                  isWithSymptoms = true;
                }
                print('Key: $key, Value: $value');
              });
              if (isWithSymptoms == true && isWithContact == true) {
                return const Center(
                  child: Text(
                      "Cannot generate building pass. You are with symptoms and with contact."),
                );
              } else if (isWithSymptoms == true) {
                return const Center(
                  child: Text(
                      "Cannot generate building pass. You are with symptoms."),
                );
              } else if (isWithContact == true) {
                return const Center(
                  child: Text(
                      "Cannot generate building pass. You are with contact."),
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(
                            'Building Pass',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.w500),
                          )),
                      QrImageView(
                        data: entry.uid,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ],
                  ),
                );
              }
            } else {
              return const Center(
                  child: Text("To generate QR, add a health entry for today"));
            }
          }
        }
        return const Center(
            child: Text("To generate QR, add a health entry for today"));
      },
    );
  }
}
