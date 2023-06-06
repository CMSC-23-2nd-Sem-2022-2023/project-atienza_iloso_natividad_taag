import 'package:cmsc23_b5l_project/models/entry.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

 
class EntryItem extends StatelessWidget {
  const EntryItem({
    Key? key,
    required this.entry,
    required this.onEntryEdit,
    required this.onEntryDelete,
  });

  final Entry entry;
  final onEntryEdit; //method
  final onEntryDelete; //method

  @override
  Widget build(BuildContext context) {
return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        onTap: (){
          // print('click on to do item');
          // onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        // leading: Icon( //checkbox
        //   todo.isDone? Icons.check_box:Icons.check_box_outline_blank, 
        //   color: tdBlue),
        title: Text( //text
          entry.date!, 
          style: const TextStyle(
            fontSize: 16, 
            // color: tdBlack, 
            // decoration: todo.isDone? TextDecoration.lineThrough:null,
          )
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container( //edit button
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              height:35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5)
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: const Icon(Icons.edit_outlined),
                onPressed:(){
                  print('click on edit icon');
                  // onDeleteItem(todo.id);
                }
              ),
            
            ),
            Container( //delete button
              // padding: EdgeInsets.only(),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              height:35,
              width: 35,
              decoration: BoxDecoration(
                color: const Color(0xFFDA4040),
                borderRadius: BorderRadius.circular(5)
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: const Icon(Icons.delete),
                onPressed:(){
                  print('click on delete icon');
                  // onDeleteItem(todo.id);
                }
              ),
            
            ),
          ],
        ),
      ),
    );
  }
}