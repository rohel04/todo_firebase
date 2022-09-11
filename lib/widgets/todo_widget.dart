import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/screens/edit_todo.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String? id;

  @override
  Widget build(BuildContext context) {

    List<Color> color=[
      Colors.white,
      Colors.red.shade100,
      Colors.pink.shade100,
      Colors.orange.shade100,
      Colors.yellow.shade100,
      Colors.green.shade100,
      Colors.blue.shade100,

    ];

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('todos').doc(id).collection('mytodos').snapshots(),
        builder: (context,snapshot){
          print('Internal built');
          if(!snapshot.hasData){
            return Center(
                child: CircularProgressIndicator()
            );
          }
          else if(snapshot.data?.docs.length==0){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text('Your list is empty!!',style: Theme.of(context).textTheme.bodyText1),
                    Text('Plaese add some TODOs',style: Theme.of(context).textTheme.bodyText1)
                  ])
            );
          }
          else{
            final data=snapshot.data?.docs;
            return GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing:15
                ),
                itemCount: data?.length,
                itemBuilder: (context,index){
                  var colorIndex=Random().nextInt(color.length);
                  DocumentReference? info=snapshot.data!.docs[index].reference;
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditTodoPage(info: info,id: id,title: data?[index]['title'],desc: data?[index]['description'],)));
                    },
                    child: Container(
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        color: color[colorIndex],
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${data?[index]['title']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,fontFamily: 'Oswald')),
                               SizedBox(height: 5),
                                Text('${data?[index]['description']}',style: TextStyle(fontSize: 14,fontFamily: 'Oswald'))
                              ],
                            ),
                          ),
                        )
                        ,

                      ),
                    ),
                  );
                });
          }

        });
  }
}