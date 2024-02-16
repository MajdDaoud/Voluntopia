import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/Organisation-Pages/AccountManagement.dart';
class Message extends StatefulWidget {

  final String content;
  final Timestamp time;
  final String id;
  Message({
    required this.content , required this.time , required this.id
});
  @override
  State<Message> createState() => _MessageState();
}
var user = FirebaseAuth.instance.currentUser!.uid;
class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    if(id == user){return Container(
      width: 10,
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(widget.content,style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46)),),
        ],
      ),
    ); }
    else{
      return Container(
          decoration: BoxDecoration(
            color: Color(0xFF00ADB5)
          ),
          child: Text(widget.content,style: TextStyle(fontFamily: "MyCustomFont",color: Colors.white),),);
    }

  }
}
