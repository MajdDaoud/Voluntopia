import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';


class PersonalAccount extends StatefulWidget {
  const PersonalAccount({Key? key}) : super(key: key);

  @override
  State<PersonalAccount> createState() => _PersonalAccountState();
}

class _PersonalAccountState extends State<PersonalAccount> {
  String name = 'My Personal Account Name';
  String description = 'Description of me';
  String age = 'My age';
  String college = 'My college';
  String location = 'My location';

  bool isEditingName = false;
  bool isEditingDescription = false;
  bool isEditingAge = false;
  bool isEditingCollege = false;
  bool isEditingLocation = false;

  int hours = 15;
  int proj = 10;

  List<String> missions = ["Sympathy", "Initiative", "Cooperation"];

  File? image;

  Future<void> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery );
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
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
                initialValue: name,
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
                name,
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
                initialValue: description,
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
                description,
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
                  isEditingAge = true;
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Age : ',
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

            if (isEditingAge)
              TextFormField(
                initialValue: age,
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
                  age = value;
                },
                onEditingComplete: () {
                  setState(() {
                    isEditingAge = false;
                  });
                },
              )
            else
              Text(
                age,
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
                initialValue: college,
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
                college,
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
                initialValue: location,
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
                location,
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
          ],
        ),
      ),
    );
  }
}