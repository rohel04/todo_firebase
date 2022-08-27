import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formkey=GlobalKey<FormState>();
  String? email='';
  String? password='';
  String? username='';



  @override
  Widget build(BuildContext context) {

    final authProvider=Provider.of<AuthService>(context);

    startAuthentication(){
      bool? validity= _formkey.currentState?.validate();
      if(validity!)
      {
        _formkey.currentState?.save();
        authProvider.createWithEmailandPass(email!, password!, username!);
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
                Text('Hi.',style: Theme.of(context).textTheme.headline1),
                Text('Fill the Form',style:Theme.of(context).textTheme.headline1),
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
                          key: ValueKey('username'),
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return 'Username is empty';
                            }
                          },
                          onSaved: (value){
                            username=value;
                          },
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)
                              ),
                              labelText: 'Username',
                              labelStyle: Theme.of(context).textTheme.bodyText1
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: Theme.of(context).textTheme.bodyText1,
                          keyboardType: TextInputType.emailAddress,
                          key: ValueKey('password'),
                          validator: (value){
                            if(value!.isEmpty || value.length<8)
                            {
                              return 'Password too short';
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
                        ElevatedButton(onPressed: (){
                          startAuthentication();
                        },
                            child: Text('Sign Up'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20)
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Text('Already a member?',style: Theme.of(context).textTheme.bodyText1),
                            )

                          ],
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
