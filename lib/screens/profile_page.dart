// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// import 'package:cmsc23_b5l_project/models/entry.dart';
// import 'package:cmsc23_b5l_project/providers/auth_provider.dart';
// import '../providers/entry_provider.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       child: _buildQR(),
//     );
//   }

//   Widget _buildQR() {
//     final entryProvider = Provider.of<EntryProvider>(context);
//     final user = context.watch<AuthProvider>().getCurrentUser;

//     return FutureBuilder<Entry?>(
//       future: entryProvider.getLatestEntryForUid(user.uid),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasData) {
//           final entry = snapshot.data!;
//           final isValidEntry = _isTodayValidEntry(entry);

//           if (isValidEntry) {
//             return Center(
//               child: Column(
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(top: 10, bottom: 20),
//                     child: Text(
//                       'Building Pass',
//                       style:
//                           TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   QrImageView(
//                     data: "Pass",
//                     version: QrVersions.auto,
//                     size: 200.0,
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Center(
//               child: Text(
//                 _getInvalidEntryMessage(entry),
//               ),
//             );
//           }
//         }

//         return Center(
//           child: const Text("To generate QR, add a health entry for today"),
//         );
//       },
//     );
//   }

//   bool _isTodayValidEntry(Entry entry) {
//     final date = entry.date.toDate();
//     final today = DateTime.now();

//     return date.year == today.year &&
//         date.month == today.month &&
//         date.day == today.day;
//   }

//   String _getInvalidEntryMessage(Entry entry) {
//     final isWithSymptoms = entry.illnesses.containsValue(true);
//     final isWithContact = entry.illnesses['isExposed'] == true;

//     if (isWithSymptoms && isWithContact) {
//       return "Cannot generate building pass. You are with symptoms and with contact.";
//     } else if (isWithSymptoms) {
//       return "Cannot generate building pass. You are with symptoms.";
//     } else if (isWithContact) {
//       return "Cannot generate building pass. You are with contact.";
//     } else {
//       return "To generate QR, add a health entry for today";
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/providers/auth_provider.dart';
import '../providers/entry_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: _buildQR(),
    );
  }

  Widget _buildQR() {
    final entryProvider = Provider.of<EntryProvider>(context);
    final user = context.watch<AuthProvider>().getCurrentUser;

    return FutureBuilder<Entry?>(
      future: entryProvider.getLatestEntryForUid(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final entry = snapshot.data!;
          final isValidEntry = _isTodayValidEntry(entry);

          if (isValidEntry) {
            final name = context.watch<AuthProvider>().getCurrentUserName;
            final validUntil = entry.date.toDate();

            return Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      'Building Pass',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
                    ),
                  ),
                  QrImageView(
                    data: _generatePassText(name, validUntil),
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                _getInvalidEntryMessage(entry),
              ),
            );
          }
        }

        return Center(
          child: const Text("To generate QR, add a health entry for today"),
        );
      },
    );
  }

  bool _isTodayValidEntry(Entry entry) {
    final date = entry.date.toDate();
    final today = DateTime.now();

    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  String _generatePassText(String name, DateTime validUntil) {
    final formattedDate = DateFormat.yMd().format(validUntil);

    return "This certifies that $name may pass the building. It is valid until $formattedDate";
  }

  String _getInvalidEntryMessage(Entry entry) {
    final isWithSymptoms = entry.illnesses.containsValue(true);
    final isWithContact = entry.illnesses['isExposed'] == true;

    if (isWithSymptoms && isWithContact) {
      return "Cannot generate building pass. You are with symptoms and with contact.";
    } else if (isWithSymptoms) {
      return "Cannot generate building pass. You are with symptoms.";
    } else if (isWithContact) {
      return "Cannot generate building pass. You are with contact.";
    } else {
      return "To generate QR, add a health entry for today";
    }
  }
}
