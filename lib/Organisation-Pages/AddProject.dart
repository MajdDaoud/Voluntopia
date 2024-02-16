
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/Organisation-Pages/AccountManagement.dart';
import 'package:grad_proj/Volunteer-Pages/PersonalAccount.dart';
import 'package:grad_proj/Widgets/task-request-item.dart';
import 'package:grad_proj/Widgets/tasks-item.dart';
import 'package:image_picker/image_picker.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}


class _AddProjectState extends State<AddProject> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _durationController = TextEditingController();

  late String name;
  late String descreption;
   String? city;
  late String date;
  late int duration;
   List<Tasks> tasks =[];
  late String taskName;
  late String taskDescreption;
  late int taskDuration;
  late int taskNumber;
  bool isloading = true;
  late String imageUrl;
  void _getImageUrl() async {
    // Get the reference to the image
    var ref = FirebaseStorage.instance.ref('Projects/$id/Project-picture.jpg');

    // Get the download URL of the image
    var url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });

  }

  List<String> syrianBiggestCities = [
    'Aleppo',
    'Damascus',
    'Homs',
    'Latakia',
    'Hama',
    'Deir ez-Zor',
    'Raqqa',
    'Hasakah',
    'Idlib',
    'Daraa',
    'As-Suwayda',
  ];
  final storageRef = FirebaseStorage.instance.ref("ProjectImages");
  String? _selectedCity;
  final _formKey = GlobalKey<FormState>();
  int currentstep =0;
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
    return Theme(
      data: ThemeData(colorScheme: ColorScheme.light(primary: Color(0xFF00ADB5),secondary:Color(0xFFF05F00) )),
      child: Stepper(


        currentStep: currentstep,
           onStepContinue: (){

          print(currentstep);

             if(currentstep==3){

              showDialog(context: context, builder: (context){
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                    title: Text("Confirmation",style:  TextStyle(fontFamily: "MyCustomFont",fontSize: 19,color: Color(0xFF393E46)),),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Text("Do You Want To Add This Project?",style: TextStyle(
                    fontFamily: "MyCustomFont",color: Colors.black45
                  ),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF00ADB5),
                              borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          child: MaterialButton(onPressed: ()async{

                            var user = FirebaseAuth.instance.currentUser;

// Store the list of tasks in a separate document.

                            final id = user!.uid;
                            final Reference storageReference = FirebaseStorage.instance.ref().child('Projects/$id/Project-picture.jpg');
                            await storageReference.putFile(_image!);
                            _getImageUrl();


                             final docRef =await FirebaseFirestore.instance.collection('Projects').doc(name).set({
                              "ProjectName" : name,
                              "ProjectDescreption" : descreption,
                              "ProjectCity": city,
                              "projectDate" : date,
                              "projectDuration": duration,
                              "OrganisationId":user!.uid,
                               "imageUrl":imageUrl,
                               "Status" : "Waiting",
                               "volreq" : 10

                            });
                            for(Tasks  task in tasks){
                              DocumentReference tasksDocument = FirebaseFirestore.instance.collection("Projects").doc(name).collection("tasks").doc(docref.id);
                              tasksDocument.set({"taskName": task.taskName,
                                "taskDescreption": task.taskDescreption,
                                "taskDuration" : task.taskDuration.toString(),
                                "Status" : task.Situation,

                              });
                            }





                            print(name);
                          }, child:Text("Add",
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
                        SizedBox(height: 20,)
                      ],
                    )
                ],),
                   );
              })
              ;
             }
             else
          setState(() => currentstep+=1);
           },
          onStepCancel: (){
          if(currentstep==0){return null;}
          else
            setState(() => currentstep-=1);
          },
          steps: [
        Step(


            
            state: currentstep>=1? StepState.complete:StepState.disabled,
            
            isActive: currentstep>=0,
            title: Text("Name & Description",style: TextStyle(fontFamily: "MyCustomFont"),),
            content: Column(
              children: [
                TextFormField(
                  onFieldSubmitted: (value){
                    name=value;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.grey,
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
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      fontFamily: "MyCustomFont",
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.accessibility,
                      color: Colors.grey[400],
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Project name';
                    }
                    return null;
                  },

                ),
                SizedBox(height: 10,),
                Flex(
                  direction: Axis.vertical,
                  children: [TextFormField(
                    onFieldSubmitted: (value){
                      descreption =value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:Colors.grey,
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
                      labelText: 'Descreption',
                      labelStyle: TextStyle(
                        fontFamily: "MyCustomFont",
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),

                      prefixIcon: Icon(
                        Icons.description,
                        color: Colors.grey[400],
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Project name';
                      }
                      return null;
                    },
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                  ),]
                ),
              ],


            )

          ),
            Step(
                state: currentstep>=2? StepState.complete:StepState.disabled,
                isActive: currentstep>=1,
                title: Text("Date & Location",style: TextStyle(fontFamily: "MyCustomFont"),),
                content: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      onSaved: (value){
                        city=value!;
                      },
                      decoration: InputDecoration(
                        errorStyle:  TextStyle( color:Color(0xFFF05F00)),
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
                        labelText: 'City',
                        labelStyle: TextStyle(
                          fontFamily: "MyCustomFont",
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.grey[400],
                        ),
                      ),
                      value: city,
                      onChanged: (value) {
                        setState(() {
                          city = value!;
                        });
                      },
                      items: syrianBiggestCities
                          .map((city) => DropdownMenuItem(
                        value: city,
                        child: Text(city,style: TextStyle(fontFamily: "MyCustomFont", color: Color(0xFF393E46),fontSize: 16 ),),
                      ))
                          .toList(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your City';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      onFieldSubmitted: (value){
                        date=value;
                      },
                      onChanged: (value){
                        date=value;
                      },
                      onSaved: (value){
                        date=value!;
                      },
                      style: TextStyle(fontFamily: "MyCustomFont", color: Color(0xFF393E46),fontSize: 16 ),
                      controller: _dateController,
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
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: "MyCustomFont",
                          fontSize: 16,
                        ),
                        labelText: 'Date of Start',
                        hintText: 'Select project date of start',
                        prefixIcon: Icon(Icons.calendar_today,color: Colors.grey[400],),
                      ),
                      onTap: () async {
                        DateTime date = DateTime(2000);
                        FocusScope.of(context).requestFocus(new FocusNode()); // hide the keyboard
                        date = (await showDatePicker(

                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),

                        ))!;
                        _dateController.text = date.toString().substring(0, 10);
                        this.date=date.toString().substring(0, 10);
                        _dateController.text = date.toString().substring(0, 10);
                      },
                    )
                  ],
                ))  ,
            Step(
                state: currentstep>=3? StepState.complete:StepState.disabled,
                isActive: currentstep>=2,
                title: Text("Duration & Tasks",style: TextStyle(fontFamily: "MyCustomFont"),),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        onFieldSubmitted: (value){
                          duration=int.parse(value);
                        },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:Colors.grey,
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
                        labelText: 'Duration',
                        labelStyle: TextStyle(
                          fontFamily: "MyCustomFont",
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.timelapse_outlined,
                          color: Colors.grey[400],
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Project Duration';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 315,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(
                        Radius.circular(30)
                      ),
                        color: Color(0xFFF05F00)
                      ),
                      child: MaterialButton(onPressed: (){showDialog(context: context, builder: (context){
                        return SingleChildScrollView(
                          child: AlertDialog(

                            title: Center(child: Text("Add New Task",style: TextStyle(fontFamily: "MyCustomFont",fontSize: 19,color: Color(0xFF393E46)),)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),

                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Add Task Name:",style: TextStyle(fontFamily: "MyCustomFont",fontSize: 17,color: Color(0xFF393E46)),),
                                SizedBox(height: 15,),
                                TextFormField(
                                  onFieldSubmitted: (value){
                                    taskName=value;
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:Colors.grey,
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
                                    labelText: 'Name',
                                    labelStyle: TextStyle(
                                      fontFamily: "MyCustomFont",
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.task_alt_outlined,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Task name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15,),
                                Text("Add Task Descreption",style: TextStyle(fontFamily: "MyCustomFont",fontSize: 17,color:Color(0xFF393E46)),),
                                SizedBox(height: 15,),
                                TextFormField(
                                  onFieldSubmitted: (value){
                                    taskDescreption =value;
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:Colors.grey,
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
                                    labelText: 'Descreption',
                                    labelStyle: TextStyle(
                                      fontFamily: "MyCustomFont",
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.description_outlined,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Task Descreption';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10,),
                                Text("Add Task Duration",style: TextStyle(fontFamily: "MyCustomFont",fontSize: 17,color: Color(0xFF393E46)),),
                                SizedBox(height: 10,),
                                TextFormField(
                                  onFieldSubmitted: (value){
                                    taskDuration=int.parse(value);
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:Colors.grey,
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
                                    labelText: 'Duration',
                                    labelStyle: TextStyle(
                                      fontFamily: "MyCustomFont",
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.timelapse_outlined,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Task name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15,),
                                Center(
                                  child: Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF05F00) ,
                                        borderRadius: BorderRadius.all(Radius.circular(30))),
                                    child: MaterialButton(onPressed: (){


                                      Tasks t = Tasks(taskName: taskName, taskDuration: taskDuration.toString(), taskDescreption: taskDescreption, Situation: true, requests: [],
                                                id: FirebaseAuth.instance.currentUser!.uid,projName: name,
                                      );
                                      tasks.add(t);
                                      print(tasks);
                                    },child: Text("Add Task",style: TextStyle(fontFamily: "MyCustomFont",
                                      color:Colors.white )
                                      )
                                      ,),
                                  ),
                                )
                              ],),
                          ),
                        );
                      }
                      );
                        },
                        child: Text("Add Task",style: TextStyle(fontFamily: "MyCustomFont",color: Colors.white)),),
                    )



                  ],
                )),
            Step(
                state: currentstep>=4? StepState.complete:StepState.disabled,

                isActive: currentstep>=3,
                title: Text("Photo",style: TextStyle(fontFamily: "MyCustomFont"),),
                content: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border()),
                      width: 300,
                      height: 200,
                      child: GestureDetector(
                        onTap: _pickImageFromGallery,
                        child: Stack(
                          children: [
                            _image != null
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
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Upload your Project Photo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                      color: Colors.grey[400],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Upload your Project Photo',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),

      ]),
    );
  }
}