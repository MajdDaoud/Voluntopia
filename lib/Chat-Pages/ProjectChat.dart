import 'package:flutter/material.dart';

class ProjectChat extends StatefulWidget {
  const ProjectChat({Key? key}) : super(key: key);

  @override
  State<ProjectChat> createState() => _ProjectChatState();
}

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
        )
    );
  }
}
