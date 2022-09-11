import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/todo_service.dart';

class EditTodoPage extends StatefulWidget {

  DocumentReference info;
  String? id;
  String? title;
  String? desc;
  EditTodoPage({Key? key,required this.info,required this.id,required this.title,required this.desc}) : super(key: key);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {


  TextEditingController _titleController=TextEditingController();
  TextEditingController _descController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text=widget.title!;
    _descController.text=widget.desc!;

  }

  @override
  Widget build(BuildContext context) {

    final todoprovider=Provider.of<TodoService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(onPressed: () async{
            await todoprovider.delete_todo(widget.info);
            Navigator.pop(context);
            
          }, icon: Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    labelStyle: Theme.of(context).textTheme.bodyText1
                ),

              ),
              SizedBox(height: 20),
              TextField(
                controller: _descController,
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 5,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  labelText: 'Description',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () async{
                await todoprovider.edit_todo(_titleController.text, _descController.text, widget.info);
                Navigator.pop(context);
              },
                child: Text('Update Todo'),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
