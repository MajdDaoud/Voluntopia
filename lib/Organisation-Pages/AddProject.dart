import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
                          child: MaterialButton(onPressed: (){

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
                  onSaved: (value){
                    name=value!;
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
                      value: _selectedCity,
                      onChanged: (value) {
                        setState(() {
                          _selectedCity = value;
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
                        return AlertDialog(

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
                                  child: MaterialButton(onPressed: (){},child: Text("Add Task",style: TextStyle(fontFamily: "MyCustomFont",
                                    color:Colors.white )
                                    )
                                    ,),
                                ),
                              )
                            ],),
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