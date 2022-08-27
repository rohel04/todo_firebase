import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/screens/authentication/signIn.dart';
import 'package:todo_firebase/services/auth_service.dart';
import 'package:todo_firebase/user.dart';
import 'package:todo_firebase/screens/home.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {


  @override
  Widget build(BuildContext context) {

  final authProvider=Provider.of<AuthService>(context);

    return StreamBuilder<UserModel?>(
      stream: authProvider.user,
        builder: (context,AsyncSnapshot<UserModel?> snapshot){
        if(snapshot.connectionState==ConnectionState.active)
          {
            final UserModel? userModel=snapshot.data;
            return userModel==null ? SigninScreen() : HomeScreen();
          }
        else
          {
            return Center(
              child: CircularProgressIndicator()
            );
          }

      });
  }
}
