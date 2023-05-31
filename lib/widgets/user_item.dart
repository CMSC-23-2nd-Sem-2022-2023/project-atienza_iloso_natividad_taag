import 'package:cmsc23_b5l_project/models/user_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  UserItem({
    Key? key,
    required this.user,
    required this.onEntryEdit,
    required this.onEntryDelete,
  });

  final User user;
  final onEntryEdit; //method
  final onEntryDelete; //method
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        onTap: () {
          // print('click on to do item');
          // onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        // leading: Icon( //checkbox
        //   todo.isDone? Icons.check_box:Icons.check_box_outline_blank,
        //   color: tdBlue),
        title: Text(
            //text
            user.name,
            style: TextStyle(
              fontSize: 16,
              // color: tdBlack,
              // decoration: todo.isDone? TextDecoration.lineThrough:null,
            )),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              //edit button
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              child: IconButton(
                  color: Colors.white,
                  iconSize: 18,
                  icon: Icon(Icons.edit_outlined),
                  onPressed: () {
                    // print('click on delete icon');
                    // onDeleteItem(todo.id);
                  }),
            ),
            Container(
              //delete button
              // padding: EdgeInsets.only(),
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Color(0xFFDA4040),
                  borderRadius: BorderRadius.circular(5)),
              child: IconButton(
                  color: Colors.white,
                  iconSize: 18,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print('click on delete icon');
                    // onDeleteItem(todo.id);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
