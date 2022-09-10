import 'package:flutter/material.dart';

import '../screens/add_todo.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTodoPage()));
      },
      backgroundColor: Colors.blueAccent,
      child: Icon(Icons.add),
    );
  }
}