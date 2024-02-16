import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class AccountManagement extends StatefulWidget {

  const AccountManagement({Key? key}) : super(key: key);


  @override
  State<AccountManagement> createState() => _AccountManagementState();
}


String _name = 'My Organization'; // default name
String _description = 'Description of my organization'; // default description
String _location = 'My location'; // default location
late String newName;
late String newDescreption;
late String newLocation;
var user = FirebaseAuth.instance.currentUser;
String id = user!.uid;
DocumentReference  userDoc = FirebaseFirestore.instance.collection("users").doc(id);



bool _isEditingDescription = false;
bool _isEditingLocation = false;
bool _isEditingValues = false;
bool _isEditingName =false;
int vol =10;
int proj =5;


File? _image = null;
 String originalImage = "" ;
List missions = [
  "Sympathy","Initiative","Cooperation"
];


class _AccountManagementState extends State<AccountManagement> {
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // TODO: Handle the picked image file here
    }
  }
  late Map<String, dynamic> _user;

  void _getUser() async {
    // Get the user document
    var userDoc = await FirebaseFirestore.instance.collection("users").doc(id).get();

    // Get the user's data
    var data = userDoc.data()!;

    // Set the state of the widget
    setState(() {
      _user = data;
    });
  }

  void _getImageUrl() async {
    // Get the reference to the image
    var ref = FirebaseStorage.instance.ref('userPicture/$id/Profile-picture.jpg');

    // Get the download URL of the image
    var url = await ref.getDownloadURL();
       setState(() {
         originalImage = url;
       });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
    _getImageUrl();
    
  }
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImageFromGallery,
              child: Stack(
                children: [
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
                      child:originalImage.isNotEmpty?Image.network(originalImage,

                      height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ) :Image.network(
                        'https://www.shutterstock.com/image-vector/people-logo-design-community-human-260nw-2278208987.jpg',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],

              ),
            ),
            SizedBox(height: 46.0),
            InkWell(
              onTap: () {
                setState(() {
                  _isEditingName = true;
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Name : ',
                      style: TextStyle(
                        fontFamily: "MyCustomFont",
                        color: Color(0xFF393E46),
                        fontSize: 16,

                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: Color(0xFFF05F00),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            if (_isEditingName)
              TextFormField(
                onFieldSubmitted: (value){
                  newName = value;
                },
                initialValue: _user["name"],
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
                ),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    _isEditingName = false;
                  });
                },
              )
            else
              Text(
                _user["name"],
                style: TextStyle(
                  fontFamily: "MyCustomFont",
                  color: Color(0xFF393E46),
                  fontSize: 16,
                ),
              ),
            SizedBox(height: 46.0),
            InkWell(

          onTap: () {
            setState(() {
              _isEditingDescription = true;
            });
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontFamily: "MyCustomFont",
                    color: Color(0xFF393E46),
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(
                Icons.edit_outlined,
                color: Color(0xFFF05F00),
              ),
            ],
          ),
        ),
            SizedBox(height: 16.0),
        if (_isEditingDescription)
             TextFormField(
               onFieldSubmitted: (value){
                 newDescreption = value;
               },
      initialValue: _user["Mission"],
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






      ),
      onChanged: (value) {
        setState(() {
          _description = value;
        });
      },
      onEditingComplete: () {
        setState(() {
          _isEditingDescription = false;
               });
            },
          )
         else
             Text(_user["Mission"],style: TextStyle(
      fontFamily: "MyCustomFont",
      color: Color(0xFF393E46),
      fontSize: 16,
            ),),
            SizedBox(height: 46.0),

            InkWell(
              onTap: () {
                setState(() {
                  _isEditingLocation = true;
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Location',
                      style: TextStyle(
                        fontFamily: "MyCustomFont",
                        color: Color(0xFF393E46),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: Color(0xFFF05F00),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            if (_isEditingLocation)
              TextFormField(
                onFieldSubmitted: (value){
                  newLocation = value;
                },
                initialValue:_user["city"],
                decoration:  InputDecoration(
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

                ),
                onChanged: (value) {
                  setState(() {
                    _location = value;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    _isEditingLocation = false;
                  });
                },
              )
            else
              Text(_user["city"],style: TextStyle(
                fontFamily: "MyCustomFont",
                color: Color(0xFF393E46),
                fontSize: 16,
              ),),
            SizedBox(height: 16.0),
            SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Volunteers Number',
                    style: TextStyle(
                      fontFamily: "MyCustomFont",
                      color: Color(0xFF393E46),
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(Icons.person_4_outlined,color: Color(0xFFF05F00),)
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(vol.toString(),style: TextStyle(
              fontFamily: "MyCustomFont",
              color: Color(0xFF393E46),
              fontSize: 16,
            ),),
            SizedBox(height: 16.0),
            SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Projects Number',
                    style: TextStyle(
                      fontFamily: "MyCustomFont",
                      color: Color(0xFF393E46),
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(Icons.pending_actions_rounded,color:  Color(0xFFF05F00),)
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(proj.toString(),style: TextStyle(
              fontFamily: "MyCustomFont",
              color: Color(0xFF393E46),
              fontSize: 16,
            ),),
            SizedBox(height: 46,),
            MaterialButton(onPressed: ()async{
              await FirebaseFirestore.instance.collection('users').doc(id).update({
                'name': newName,
                'city': newLocation,
                'Mission': newDescreption,


              });
              final Reference storageReference = FirebaseStorage.instance.ref().child('userPicture/$id/Profile-picture.jpg');
              final TaskSnapshot storageTask = await storageReference.putFile(_image!);
              showDialog(context: context, builder: (context)=>AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
                title: Text("Success",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46)),),
                content: Text("You informations updated successfully",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46)),),
              ));
            },child: Text("Upadate ",style: TextStyle(fontFamily: "MyCustomFont",color: Colors.white),),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),color:Color(0xFF00ADB5) )




          ],
        ),
      ),
    );

  }
}
