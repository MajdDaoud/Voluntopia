import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/project_item.dart';
class Archive extends StatefulWidget {
  const Archive({Key? key}) : super(key: key);

  @override
  State<Archive> createState() => _ArchiveState();
}
CollectionReference orderref = FirebaseFirestore.instance.collection("Projects");
var user = FirebaseAuth.instance.currentUser!.uid;
 late List<QueryDocumentSnapshot<Map<String, dynamic>>> favlist;
   List<String> favId = [];
class _ArchiveState extends State<Archive> {
void retrieveFavs ()async{
   await FirebaseFirestore.instance.collection("users").doc(user).collection("Favourite").get().
  then((value) {
    favlist  = value.docs.toList();
    for(var doc in favlist){
      print(doc.id);
      favId.add(doc.id);

    }
  });
}

  @override
  void initState() {
    super.initState();
// Get the list of favorite organization IDs.
    retrieveFavs();
  }

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
          future:  orderref.where("OrganisationId",whereIn: favId).get(),
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