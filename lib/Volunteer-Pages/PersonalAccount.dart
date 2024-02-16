import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';


class PersonalAccount extends StatefulWidget {
  const PersonalAccount({Key? key}) : super(key: key);

  @override
  State<PersonalAccount> createState() => _PersonalAccountState();
}
String user = FirebaseAuth.instance.currentUser!.uid;
DocumentReference docref = FirebaseFirestore.instance.collection("users").doc(user);
class _PersonalAccountState extends State<PersonalAccount> {
  String name = 'My Personal Account Name';
  String description = 'Description of me';
  String age = 'My age';
  String college = 'My college';
  String location = 'My location';
  late String newName;
  late String newDesreption;
  late String newAge;
  late String newCollege;
  late String newLocation;


  bool isEditingName = false;
  bool isEditingDescription = false;
  bool isEditingAge = false;
  bool isEditingCollege = false;
  bool isEditingLocation = false;

  int hours = 15;
  int proj = 10;

  List<String> missions = ["Sympathy", "Initiative", "Cooperation"];

  File? image = null;
  String originalImage = "";

  Future<void> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery );
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }
  late Map<String, dynamic> _user;
  void _getUser() async {
    // Get the user document
    var userDoc = await FirebaseFirestore.instance.collection("users").doc(user).get();

    // Get the user's data
    var data = userDoc.data()!;

    // Set the state of the widget
    setState(() {
      _user = data;
    });
  }
  void _getImageUrl() async {
    // Get the reference to the image
    var ref = FirebaseStorage.instance.ref('userPicture/$user/Profile-picture.jpg');

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: pickImageFromGallery,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: pickImageFromGallery,
                    child: image != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.file(
                        image!,
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
                        'https://www.shutterstock.com/image-photo/young-handsome-african-american-man-260nw-1801178389.jpg',
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
                  isEditingName = true;
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
            if (isEditingName)
              TextFormField(
                onFieldSubmitted: (value){
                  newName=value;
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
                    name = value;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    isEditingName = false;
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
                  isEditingDescription = true;
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Description : ',
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
            if (isEditingDescription)
              TextFormField(
                onFieldSubmitted: (value){
                  newDesreption =value;
                },
                initialValue: _user["story"],
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
                    description = value;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    isEditingDescription = false;
                  });
                },
              )
            else
              Text(
                _user["story"],
                style: TextStyle(
                  fontFamily: "MyCustomFont",
                  color: Color(0xFF393E46),
                  fontSize: 16,
                ),
              ),



            SizedBox(height: 46,),
            InkWell(
              onTap: () {
                setState(() {
                  isEditingCollege = true;
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'College : ',
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

            if (isEditingCollege)
              TextFormField(
                onFieldSubmitted: (value){
                  newCollege =value;
                },
                initialValue: _user["study"],
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
                  college = value;
                },
                onEditingComplete: () {
                  setState(() {
                    isEditingCollege = false;
                  });
                },
              )
            else
              Text(
                _user["study"],
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
                  isEditingLocation = true;
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Location : ',
                      style:TextStyle(
                        fontFamily: "MyCustomFont",
                        color: Color(0xFF393E46),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit_location_alt_outlined,
                    color: Color(0xFFF05F00),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            if (isEditingLocation)
              TextFormField(
                onFieldSubmitted: (value){
                  newLocation = value;
                },
                initialValue: _user["city"],
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
                    location = value;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    isEditingLocation = false;
                  });
                },
              )
            else
              Text(
                _user["city"],
                style: TextStyle(
                  fontFamily: "MyCustomFont",
                  color: Color(0xFF393E46),
                  fontSize: 16,
                ),
              ),
            SizedBox(height: 16.0),
            SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                    child: Text(
                      'Total Hours : ',
                      style: TextStyle(
                        fontFamily: "MyCustomFont",
                        color: Color(0xFF393E46),
                        fontSize: 16,
                      ),
                    )),
                Icon(
                  Icons.access_time_rounded,
                  color: Color(0xFFF05F00),
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              hours.toString(),
              style: TextStyle(
                fontFamily: "MyCustomFont",
                color: Color(0xFF393E46),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Participe Projects : ',
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
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              proj.toString(),
              style:TextStyle(
                fontFamily: "MyCustomFont",
                color: Color(0xFF393E46),
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 46,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.all(Radius.circular(30)) ),
              color:Color(0xFF00ADB5) ,
              onPressed: ()async{
                await FirebaseFirestore.instance.collection('users').doc(user).update({
                  'name': newName,
                  'city': newLocation,
                  'story': newDesreption,
                  'study' : newCollege


                });
                final Reference storageReference = FirebaseStorage.instance.ref().child('userPicture/$user/Profile-picture.jpg');
                final TaskSnapshot storageTask = await storageReference.putFile(image!);
                showDialog(context: context, builder: (context)=>AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
                  title: Text("Success",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46)),),
                  content: Text("You informations updated successfully",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46)),),
                ));
              },child: Text("Update",style: TextStyle(fontFamily: "Font",color: Colors.white),),)
          ],
        ),
      ),
    );
  }
}