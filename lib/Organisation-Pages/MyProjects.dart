import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/Widgets/task-request-item.dart';

import '../Widgets/project_item.dart';
import '../Widgets/tasks-item.dart';
class MyProjects extends StatefulWidget {
  const MyProjects({Key? key}) : super(key: key);

  @override
  State<MyProjects> createState() => _MyProjectsState();
}
CollectionReference orderref = FirebaseFirestore.instance.collection("Projects");
var user = FirebaseAuth.instance.currentUser!.uid;

class _MyProjectsState extends State<MyProjects> {
  @override
  Widget build(BuildContext context) {
    return
    FutureBuilder(
        future:  orderref.where("OrganisationId",isEqualTo: user).get(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(itemBuilder: (context,index){
              var doc = snapshot.data!.docs[index];
                return ProjItem(projName:doc['ProjectName'] ,
                  imageUrl:doc['imageUrl'],
                  date: doc['projectDate'] ,
                  duration: doc['projectDuration'],
                  volReq: 20,
                  location: doc['ProjectCity'],  description: doc['ProjectDescreption'], tasks: [],OrganisationId: doc["OrganisationId"] ,);


            },itemCount: snapshot.data!.docs.length ,);
          }else{
            return Center(child: CircularProgressIndicator());
          }

    });


  }
}
