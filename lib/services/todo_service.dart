import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService{

  Future<void> add_todo(String? title,String? description)
  async {
    String? uid=FirebaseAuth.instance.currentUser?.uid;
    var time=DateTime.now();
    await FirebaseFirestore.instance.collection('todos').doc(uid).collection('mytodos').doc(time.toString()).set({'title':title,'description':description});

  }

  Future<void> edit_todo(String? title,String? desc,DocumentReference info) async{
    Map<String,dynamic> newinfo={
      'title':title,
      'description':desc
    };
    await FirebaseFirestore.instance.runTransaction((Transaction transaction) async{
     transaction.update(info, newinfo);
    });
  }

  Future<void>  delete_todo(DocumentReference info) async{
    await FirebaseFirestore.instance.runTransaction((transaction) async{
      transaction.delete(info);
    });
  }

}