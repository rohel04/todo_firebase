import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    final authProvider=Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        elevation: 0.5,
        actions: [
          IconButton(onPressed: () async{await authProvider.signOut();}, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
