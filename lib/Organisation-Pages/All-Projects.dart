import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Widgets/project_item.dart';
import '../Widgets/task-request-item.dart';
import '../Widgets/tasks-item.dart';
class AllProjects extends StatefulWidget {


  @override
  State<AllProjects> createState() => _AllProjectsState();

}

class _AllProjectsState extends State<AllProjects> {
  double _opacity = 1.0;
  var _users;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _opacity = 1.0;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _opacity = 0.8;
    });
  }
  CollectionReference orderref = FirebaseFirestore.instance.collection("Projects");



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: orderref.where("Status",isEqualTo: "Approved").get(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView.builder(itemBuilder: (context,index){

            var doc = snapshot.data!.docs[index];



            return ProjItem(projName:doc['ProjectName'] ,
              imageUrl:doc['imageUrl'],
              date: doc['projectDate'] ,
              duration: doc['projectDuration'],
              volReq: 20,
              location: doc['ProjectCity'], description: doc['ProjectDescreption'], tasks: [], OrganisationId: doc["OrganisationId"],);

          },itemCount:snapshot.data!.docs.length ,);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },

    );
  }
}
