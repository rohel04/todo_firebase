import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                  return Container(
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      color: color[colorIndex],
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
                      )
                      ,

                    ),
                  );
                });
          }

        });
  }
}