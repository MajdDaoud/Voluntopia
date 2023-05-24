import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grad_proj/Widgets/task-request-item.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/project_item.dart';

class MyExistedProject extends StatefulWidget {
  late final ProjItem item;

  MyExistedProject({required this.item});



  @override
  State<MyExistedProject> createState() => _MyExistedProjectState();
}

class _MyExistedProjectState extends State<MyExistedProject> {
  File? _image = null;

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // TODO: Handle the picked image file here
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.keyboard_return,color: Colors.grey[400],),onPressed: (){
          Navigator.pop(context);
        },),
        title: Image.asset("assets/1.jpg",height: 130,),
        centerTitle: true,

        backgroundColor:Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Stack(children: [
                GestureDetector(
                  onTap: _pickImageFromGallery,
                  child: _image != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.memory(
                      Uint8List.fromList(_image!.readAsBytesSync()),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      widget.item.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),





              ],),
              SizedBox(height: 25,),
              Row(
                children: [
                  Icon(Icons.description_outlined, color: Color(0xFFF05F00)),
                  SizedBox(width: 5,),
                  Text("Project Descreption :",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46),fontWeight: FontWeight.bold,fontSize: 18),),
                ],
              ),
              SizedBox(height: 10,),
              Text(widget.item.description,style: TextStyle(fontFamily:"MyCustomFont",color: Colors.black45,fontSize: 15 ),),
              SizedBox(height: 25,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Color(0xFFF05F00)),
                          SizedBox(width: 5,),
                          Text("Location:",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46),fontWeight: FontWeight.bold,fontSize: 18),),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(widget.item.location,style: TextStyle(fontFamily:"MyCustomFont",color: Colors.black45,fontSize: 15 ),),
                    ],
                  ),
                  SizedBox(width: 70,),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range_rounded, color: Color(0xFFF05F00)),
                          SizedBox(width: 5,),
                          Text("Start Date:",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46),fontWeight: FontWeight.bold,fontSize: 18),),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(widget.item.date.toString().substring(0, 10),style: TextStyle(fontFamily:"TimesNewRoman",color: Colors.black45,fontSize: 15 ),),
                    ],
                  )
                ],
              ),

              SizedBox(height: 25,),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.item.tasks.length,
                itemBuilder: (context, taskIndex) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.tasks[taskIndex].taskName + "  :",
                        style: TextStyle(
                          fontFamily: "MyCustomFont",
                          color: Color(0xFF393E46),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.item.tasks[taskIndex].requests.length,
                        itemBuilder: (context, requestIndex) {
                          return TaskRequest(
                            volname: widget.item.tasks[taskIndex].requests[requestIndex].volname,
                            volUrl: widget.item.tasks[taskIndex].requests[requestIndex].volUrl,
                          );
                        },
                      ),
                      SizedBox(height: 20,)
                    ],
                  );
                },
              )

            ],
          ),


        ),

      ),
    );
  }
}
