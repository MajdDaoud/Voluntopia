import 'dart:typed_data';

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

bool _isEditingDescription = false;
bool _isEditingLocation = false;
bool _isEditingValues = false;
bool _isEditingName =false;
int vol =10;
int proj =5;

File? _image = null;
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

  @override
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
                      child: Image.network(
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
                initialValue: _name,
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
                _name,
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
      initialValue: _description,
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
             Text(_description,style: TextStyle(
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
                initialValue: _location,
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
              Text(_location,style: TextStyle(
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




          ],
        ),
      ),
    );

  }
}
