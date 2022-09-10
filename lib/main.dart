import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/screens/authentication/signUp.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/services/auth_service.dart';
import 'package:todo_firebase/services/todo_service.dart';
import 'package:todo_firebase/wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (context)=>AuthService()),
        Provider<TodoService>(create: (context)=>TodoService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Color(0xFF2D365C)
          ),
          scaffoldBackgroundColor: Color(0xFF2D365C),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              elevation: 20,
              shadowColor: Colors.blueAccent
            )
          ),
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Oswald'),
            bodyText1: TextStyle(fontFamily: 'Oswald'),
          ).apply(displayColor: Colors.white,bodyColor: Colors.white)
        ),
      ),
    );
  }
}


