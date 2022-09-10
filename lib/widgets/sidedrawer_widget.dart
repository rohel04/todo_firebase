import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/auth_service.dart';

class sidedrawer_widget extends StatelessWidget {
  const sidedrawer_widget({
    Key? key,
    required this.authProvider,
  }) : super(key: key);

  final AuthService authProvider;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                maxRadius: 30.0,
              ),
              SizedBox(height: 20),
              Divider(height: 10,color: Colors.white,),
              ListTile(
                onTap: () async{
                  await authProvider.signOut();
                },
                title: Text('Sign out'),
                leading: Icon(Icons.logout,color: Colors.white,),
              ),
              ListTile(
                onTap: (){
                  SystemNavigator.pop();
                },
                title: Text('Quit'),
                leading: Icon(Icons.power_settings_new,color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}