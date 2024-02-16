import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/Chat-Pages/message1.dart';
import 'package:grad_proj/Widgets/project_item.dart';

class ProjectChat extends StatefulWidget {
    final ProjItem item;


    ProjectChat({required this.item});

  @override
  State<ProjectChat> createState() => _ProjectChatState();
}
late String message;
TextEditingController cont = new TextEditingController();
class _ProjectChatState extends State<ProjectChat> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset("assets/1.jpg",height: 130,),
           leading: IconButton(icon: Icon(Icons.keyboard_return,color: Colors.grey[400],),onPressed: (){
      Navigator.pop(context);
        },),

          backgroundColor:Colors.white,
        ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(radius: 25,
                backgroundImage: NetworkImage(widget.item.imageUrl),),
                SizedBox(width: 20,),
                Text(widget.item.projName,style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46)),)
              ],
            ),
          ),
         FutureBuilder(
             future: FirebaseFirestore.instance.collection("Projects").doc(widget.item.projName).
              collection("Chat").get(),
              builder: (context,snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(

                        itemCount: snapshot.data!.size,
                      itemBuilder: (context,index){
                        var doc = snapshot.data!.docs[index];
                        return Message(
                            content: doc["Message"],
                            id: doc["id"],
                            time: doc["time"]);
                      },shrinkWrap: true,);
                }else{
                  return
                      Center(child: CircularProgressIndicator());
                }

              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: ()async{
                  await FirebaseFirestore.instance.collection("Projects").doc(widget.item.projName).
                  collection("Chat").
                  doc(widget.item.projName).set({
                    "projName" : widget.item.projName,
                    "Message" : message,
                    "time" : DateTime.timestamp(),
                    "id" : FirebaseAuth.instance.currentUser!.uid
                  });
                  cont.clear();

                }, icon: Icon(Icons.send_outlined,color: Color(0xFFF05F00),size: 30,)),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 250,
                  height: 50,
                  child: TextFormField(
                    controller: cont,
                  onFieldSubmitted: (value){
                  message = value;
                  },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF00ADB5),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText:"Type Messsage Here",
                      labelStyle: TextStyle(
                        fontFamily: "MyCustomFont",
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey[400],
                      ),
                    ),

                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
