import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:cmsc23_b5l_project/providers/entry_provider.dart';
import 'package:cmsc23_b5l_project/widgets/entry_modals/edit_entry_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EntryItem extends StatelessWidget {
  const EntryItem({
    Key? key,
    required this.entry,
  });

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    var formatter = DateFormat('MM/dd/yyyy');
    String formattedDate = formatter
        .format(DateTime.fromMillisecondsSinceEpoch(entry.date.seconds * 1000));

    if (entry.toDelete == true) {
      return renderMarkedTile('delete', formattedDate);
    } else if (entry.toEdit == true) {
      return renderMarkedTile('edit', formattedDate);
    } else {
      return renderTile(context, formattedDate);
    }
  }

  Widget renderTile(BuildContext context, String formattedDate) => Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          onTap: () {
            // print('click on to do item');
            // onToDoChanged(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: const Color.fromARGB(255, 240, 244, 250),
          title: Text(
              //text
              formattedDate,
              style: const TextStyle(
                fontSize: 16,
              )),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                //edit button
                padding: const EdgeInsets.all(0),
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 209, 228, 255),
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                    color: const Color.fromARGB(255, 0, 28, 53),
                    iconSize: 18,
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return EditEntryModal(
                            entry: entry,
                          );
                        },
                      );
                    }),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 201, 130, 130),
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                    color: const Color.fromARGB(255, 53, 0, 0),
                    iconSize: 18,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDeleteConfirmationModal(context, entry);
                      // onDeleteItem(todo.id);
                    }),
              ),
            ],
          ),
        ),
      );

  Widget renderMarkedTile(String mark, String formattedDate) => Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: AbsorbPointer(
          absorbing: true, // Disable user interaction
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            onTap: null, // Disable tap action
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            tileColor: const Color.fromARGB(255, 240, 244, 250),
            title: Text(
              "$formattedDate\n(Pending $mark)",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey, // Grayed out text color
                // decoration: todo.isDone? TextDecoration.lineThrough:null,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  // Edit button
                  padding: const EdgeInsets.all(0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey, // Grayed out button color
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const IconButton(
                    color: Colors.grey, // Grayed out icon color
                    iconSize: 18,
                    icon: Icon(Icons.edit_outlined),
                    onPressed: null, // Disable button press
                  ),
                ),
                Container(
                  // Delete button
                  padding: const EdgeInsets.all(0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey, // Grayed out button color
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const IconButton(
                    color: Colors.grey, // Grayed out icon color
                    iconSize: 18,
                    icon: Icon(Icons.delete),
                    onPressed: null, // Disable button press
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      void showDeleteConfirmationModal(BuildContext context, Entry entry) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Are you sure you want to delete this entry?'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<EntryProvider>().makeDeleteRequest(entry.id!, true);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 201, 130, 130),
                  ),
                ),
                child: const Text(
                  'Delete entry',
                  style: TextStyle(color: Color.fromARGB(255, 53, 0, 0)),
                ),
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    },
  );
}

}
