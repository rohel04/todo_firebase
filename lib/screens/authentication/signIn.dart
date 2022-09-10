import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/screens/authentication/signUp.dart';
import '../../services/auth_service.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  final _formkey=GlobalKey<FormState>();
  String? email='';
  String? password='';
  String? error='';

  @override
  Widget build(BuildContext context) {

    final authProvider=Provider.of<AuthService>(context);
    Future<void> startAuthentication() async{
      bool? validity= _formkey.currentState?.validate();
      if(validity!)
      {
        _formkey.currentState?.save();
        await authProvider.signWithEmailandPass(email!, password!);
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 80, 15, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Hello.',style: Theme.of(context).textTheme.headline1),
                Text('Sign in to continue,',style:Theme.of(context).textTheme.headline1),
                SizedBox(height: 20),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            keyboardType: TextInputType.emailAddress,
                            key: ValueKey('email'),
                            validator: (value){
                              if(value!.isEmpty||!value.contains('@'))
                              {
                                return 'Incorrect Email';
                              }
                            },
                            onSaved: (value){
                              email=value!;
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                labelText: 'Email',
                                labelStyle: Theme.of(context).textTheme.bodyText1
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            style: Theme.of(context).textTheme.bodyText1,
                            keyboardType: TextInputType.emailAddress,
                            key: ValueKey('password'),
                            validator: (value){
                              if(value!.isEmpty || value.length<8)
                              {
                                return 'Incorrect Password';
                              }
                            },
                            onSaved: (value){
                              password=value!;
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                labelText: 'Password',
                                labelStyle: Theme.of(context).textTheme.bodyText1
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(onPressed: () async{
                            await startAuthentication();
                            if(authProvider.signInerror!='')
                              {
                                setState(() {
                                  error=authProvider.signInerror;
                                });
                              }
                          },
                            child: Text('Sign In'),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20)
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                                  },
                                  child:Text('Create account',style: Theme.of(context).textTheme.bodyText1)
                              ),
                              SizedBox(height: 20),
                            ]
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('$error',style: TextStyle(color: Colors.redAccent))
                              ]
                          )
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
