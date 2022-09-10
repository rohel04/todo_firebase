import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../user.dart';

class AuthService{
    final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

    String? signInerror='';
    String? signUperror='';

    UserModel? _userFromFirebase(User? user)
    {
      if(user==null)
        {
          return null;
        }
      else
        {
          return UserModel(uid: user.uid, email: user.email);
        }
    }

    Stream<UserModel?> get user{
      return _firebaseAuth.authStateChanges().map(_userFromFirebase);
    }

    Future<UserModel?> createWithEmailandPass(String email,String password,String username,String fullname) async
    {
      try{
        final authResult=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        String? id=authResult.user?.uid;
        if(id!=null)
          {
            signUperror='';
          }
        await FirebaseFirestore.instance.collection('users').doc(id).set({'username':username,'email':email});
        await FirebaseAuth.instance.currentUser?.updateDisplayName(username);
        await _firebaseAuth.currentUser?.reload();
        return _userFromFirebase(authResult.user);
      }
      on FirebaseAuthException catch (e){
        switch(e.code)
        {
          case 'email-already-in-use':
            {
              signUperror="User already exists!!";
              break;
            }
        }
      }
    }

    Future<UserModel?> signWithEmailandPass(String email,String password) async
    {
      try{
        final authResult = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        return _userFromFirebase(authResult.user);
      }
      on FirebaseAuthException catch (e)
      {
        switch(e.code)
        {
          case 'user-not-found':
            {
              signInerror="User doesn't exists!!";
              break;
            }
          case 'wrong-password':
            {
              signInerror="Password not matched!!";
              break;
            }
          default:{
            signInerror="Please check your connection and try again!!";
          }
        }
      }
    }

    Future<void> signOut() async
    {
      await _firebaseAuth.signOut();
    }

    String? getUserName(){
      final user=_firebaseAuth.currentUser;
      final name=user?.displayName;
      return name;
    }
}
