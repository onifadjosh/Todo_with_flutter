import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import '../model/todo.dart';


class TodoItem extends StatelessWidget {
  final ToDo todo;
  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom:20 ),
          child: ListTile(
            onTap: (){},
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ) ,
            tileColor: Colors.white,
            leading: Icon(todo.isDone? Icons.check_box: Icons.check_box_outline_blank, color: tdBlue,),
            title: Text(todo.todoText!, style: TextStyle(fontSize: 16, color: tdBlack, decoration:todo.isDone ? TextDecoration.lineThrough: null),),
            trailing: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical:12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: tdRed,
                borderRadius: BorderRadius.circular(5)
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: Icon(Icons.delete),
                onPressed: (){
                  print('clicked on a todo item');
                },
              ),
            ),
        
          ),
        ),
      ],
    );
  }
}