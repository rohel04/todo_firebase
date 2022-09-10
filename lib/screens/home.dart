import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/screens/add_todo.dart';

import '../services/auth_service.dart';
import '../widgets/floating_button.dart';
import '../widgets/sidedrawer_widget.dart';
import '../widgets/todo_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? id='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_uid();
  }

  get_uid()
  {
    id=FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {

    final authProvider=Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingButton(),
      drawer: sidedrawer_widget(authProvider: authProvider),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Text('Hello,',style: Theme.of(context).textTheme.headline1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                Text('Welcome ${authProvider.getUserName()}',style: Theme.of(context).textTheme.headline1),
                ]
            ),
            SizedBox(height: 15),
            Expanded(
              child: TodoWidget(id: id),
            )
          ],
        ),
      )
    );
  }
}






