import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/Widgets/task-request-item.dart';

class Tasks extends StatelessWidget {
final String id;
final String projName;
  final String taskName;
  final String taskDuration;
  final String taskDescreption;
  final bool Situation;
  final List<TaskRequest> requests;

  Tasks({required this.projName, required this.id,required this.taskName, required this.taskDuration, required this.taskDescreption, required this.Situation, required this.requests});


  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       
        Padding(
          padding: const EdgeInsets.only(bottom: 17),
          child: Text(".",style: TextStyle(fontSize: 40),),
        ),
        SizedBox(width: 15,),
        Text(taskName,style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46),fontSize: 17)),
        SizedBox(width: 50,),
        IconButton(onPressed: (){
          showModalBottomSheet(context: context, builder: (context){

            return BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 1,sigmaX: 1),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
                child: BottomSheet(

                    onClosing: (){}, builder: (context){
                  return Material(

                    borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                    elevation: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                        children: [

                        Center(child: Text("Volunteer Now",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46),fontSize: 19))),
                        SizedBox(height: 30,),
                        Text(taskDescreption,style: TextStyle(fontFamily: "MyCustomFont",color: Colors.black45,fontSize: 17)),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(width: 8,),
                            Text("Confirm Your Application :",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46),fontSize: 17)),
                          ],
                        ),
                        SizedBox(height: 40,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF00ADB5),
                                    borderRadius: BorderRadius.all(Radius.circular(30))
                                ),
                                child: MaterialButton(onPressed: ()async{
                                  var uid = FirebaseAuth.instance.currentUser!.uid;
                                  var doc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
                                  await FirebaseFirestore.instance.collection("Projects").doc(this.projName).collection("requests").
                                  doc().set({
                                    "Volid" : uid,
                                    "taskName" : taskName,
                                    "volname" : doc["name"],


                                  });
                                  showDialog(context: context, builder: (context)=>AlertDialog(
                                    title: Text("success"),
                                    content: Text("You have add a volunteer request successfully"),
                                  ));
                                }, child:Text("Apply",
                                style: TextStyle(fontFamily: "MyCustomFont",color: Colors.white),)),
                              ),
                              SizedBox(width: 25,),
                              Container(
                                decoration: BoxDecoration(
                                    color:Color(0xFFF05F00),
                                    borderRadius: BorderRadius.all(Radius.circular(30))
                                ),
                                child: MaterialButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child:Text("Cancel",
                                  style: TextStyle(fontFamily: "MyCustomFont",color: Colors.white),)),
                              ),
                              SizedBox(height: 30,)
                            ],
                          )
                      ],),
                    ),
                  );
                }),
              ),
            );
          }
          );
        }, icon: Icon(Icons.add,color: Color(0xFFF05F00)))
        
        
        

    ],);
  }
}
