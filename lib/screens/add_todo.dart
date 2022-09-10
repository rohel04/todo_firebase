import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/services/todo_service.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

  TextEditingController _titleController=TextEditingController();
  TextEditingController _descController=TextEditingController();


  @override
  Widget build(BuildContext context) {

    final todoprovider=Provider.of<TodoService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
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
                  labelText: 'Title',
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
                await todoprovider.add_todo(_titleController.text, _descController.text);
                Navigator.pop(context);
              },
                  child: Text('Add Todo'),
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
