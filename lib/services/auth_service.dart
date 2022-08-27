import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../user.dart';

class AuthService{
    final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

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

    Future<UserModel?> createWithEmailandPass(String email,String password,String username) async
    {
      final authResult=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      String? id=authResult.user?.uid;
      print(id);
      await FirebaseFirestore.instance.collection('users').doc(id).set({'username':username,'email':email});
      return _userFromFirebase(authResult.user);
    }

    Future<UserModel?> signWithEmailandPass(String email,String password) async
    {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(authResult.user);
    }

    Future<void> signOut() async
    {
      await _firebaseAuth.signOut();
    }
}
