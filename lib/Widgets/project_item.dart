import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/Organisation-Pages/ExistedProject.dart';
import 'package:grad_proj/Widgets/tasks-item.dart';

import '../Chat-Pages/ProjectChat.dart';
import '../Organisation-Pages/MyExistedProject.dart';

class ProjItem extends StatefulWidget {
  final String OrganisationId;
  final  String projName;
  final String imageUrl;
  final String date;
  final int duration;
  final int volReq;
  final String location;
  final String description;
  final List<Tasks> tasks;


  ProjItem({
    required this.projName, required this.imageUrl, required this.date, required this.duration,
    required this.volReq , required this.location , required this.description, required this.tasks,
    required this.OrganisationId

});

  @override
  State<ProjItem> createState() => _ProjItemState();
}

class _ProjItemState extends State<ProjItem> {
  bool isRed = false;
  bool isFavourite = false;
  var user = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    selectProject(){
      if(user == widget.OrganisationId){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyExistedProject(item: this.widget,)));}
      else{ Navigator.push(context, MaterialPageRoute(builder: (context)=>ExistedProject(item: this.widget,)));}
     }

    return InkWell(
      onTap:selectProject ,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7.0,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)
                  ),
                  child: Image.network(widget.imageUrl,height: 250,width: double.infinity,fit: BoxFit.cover,),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.8)
                      ],
                      stops: [0.6,1]
                    )
                  ),
                  height: 250,
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          IconButton(onPressed: ()async{
                            if(!isFavourite){await FirebaseFirestore.instance.collection("users").doc(user).collection("Favourite").doc(widget.OrganisationId).
                            set({
                              "status" : "Favourite"
                            });
                            setState(() {
                              isRed = true;

                            });
                            isFavourite = true;
                            }else{
                              await FirebaseFirestore.instance.collection("users").doc(user).collection("Favourite").doc(widget.OrganisationId).delete();
                              setState(() {
                                isRed = false;
                                isFavourite = false;
                              });
                            }

                          }, icon: Icon(Icons.favorite_border_outlined,size: 30,color: isRed ? Colors.red : Colors.white,)),
                          Text(widget.projName,style: TextStyle(color: Colors.white,fontFamily: "MyCustomFont",fontSize: 25 ),),
                        ],
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0,top: 20,bottom: 20,left: 25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  SizedBox(width: 3,),


                  Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xFFF05F00)),
                      SizedBox(width: 6),
                      Text(
                        widget.location,
                        style: TextStyle(
                          fontFamily: "MyCustomFont",
                          fontSize: 13,
                          color: Color(0xFF393E46),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 3,),

                  Row(
                    children: [
                      Icon(Icons.person_4_outlined, color: Color(0xFFF05F00)),
                      SizedBox(width: 6),
                      Text(
                        widget.volReq.toString(),
                        style: TextStyle(
                          fontFamily: "TimesNewRoman",
                          fontSize: 13,
                          color: Color(0xFF393E46),
                        ),
                      ),

                    ],
                  ),

                  SizedBox(width: 3,),
                  MaterialButton(
                    onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProjectChat(item: this.widget,)));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.chat_outlined, color: Color(0xFFF05F00)),
                        SizedBox(width: 6,),

                        Text(
                          "Chat",
                          style: TextStyle(
                            fontFamily: "MyCustomFont",
                            fontSize: 13,
                            color: Color(0xFF393E46),
                          ),
                        ),

                      ],
                    ),
                  ),



                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
