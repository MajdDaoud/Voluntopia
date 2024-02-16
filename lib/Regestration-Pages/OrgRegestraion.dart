import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grad_proj/Login.dart';
import 'package:image_picker/image_picker.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class OrgRegestration extends StatefulWidget {


  @override
  State<OrgRegestration> createState() => _OrgRegestrationState();
}
bool _obscurePassword = true;
bool isloading =true;
class _OrgRegestrationState extends State<OrgRegestration> {
  Future<void> signUpWithImage(
      String email,
      String password,
      String name,
      String city,
      String mission,
      File imageFile) async {


    // Create a Firebase Authentication user with the given email and password
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final String userId = userCredential.user!.uid;
      User? user = userCredential.user;
      final Reference storageReference = FirebaseStorage.instance.ref().child('users/$userId/Decleration-picture.jpg');
      final TaskSnapshot storageTask = await storageReference.putFile(imageFile);
      final String imageUrl = await storageTask.ref.getDownloadURL();
      setState(() {
        isloading=false;
      });
      // Add user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        "id" : user.uid,
        'name': name,
        'city': city,
        'Mission': mission,

        'type' : "Organisation",
        'Status': 'waiting',
        'decision': imageUrl,
        "imageUrl" : ""
      });


    } catch (e) {
      print(e.toString());

    }

  }
  late String email ;
  late String password ;
  late String name ;


  late String mission ;

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
  final _formKey = GlobalKey<FormState>();
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
  @override
  Widget build(BuildContext context) {
    return Form(
        key:_formKey,
        child: Column(children: [
      Container(
        width: 300,
        child: TextFormField(
          onFieldSubmitted: (value){
            email=value!;
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
            labelText: 'Email',
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
      ),
       SizedBox(
         height: 25,
       ),
      Container(
        width: 300,
        child: TextFormField(
          onFieldSubmitted: (value){
            password=value!;
          },
          obscureText: _obscurePassword,
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
            labelText: 'Password',

            labelStyle: TextStyle(
              color: Colors.grey[400],
              fontFamily: "MyCustomFont",
              fontSize: 16,
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.grey[400],
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey[400],
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
      ),
      SizedBox(
        height: 25,
      ),
      Container(
        width: 300,
        child: TextFormField(
          onFieldSubmitted: (value){
            name=value!;
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
            labelText: 'Name',
            prefixIcon: Icon(Icons.person_4_outlined,color: Colors.grey[400]),

            labelStyle: TextStyle(
              color: Colors.grey[400],
              fontFamily: "MyCustomFont",
              fontSize: 16,
            ),


          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
      ),
      SizedBox(
        height: 25,
      ),
      Container( width: 300,
        child: DropdownButtonFormField<String>(
          onSaved: (value){
            _selectedCity=value;
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
      ),
      SizedBox(
        height: 25,
      ),
      Container(
        width: 300,

        child: Flex(
          direction: Axis.vertical,
          children: [
            TextFormField(
              onFieldSubmitted: (value){
                mission=value!;
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
                labelText: 'Your Mission',
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: "MyCustomFont",
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.bookmark,
                  color: Colors.grey[400],
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Mission';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      SizedBox(
        height: 25,
      ),
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
                      'Upload your declaration decision',
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
                        'Upload your declaration decision',
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
      ),
      SizedBox(
        height: 25,
      ),


      Container(
        width: 250,
        child: ElevatedButton(
          onPressed: () async{
            if (_formKey.currentState!.validate()) {
              var formdata = _formKey.currentState;
              formdata?.save();

                await signUpWithImage(email, password, name, _selectedCity!, mission, _image!);
              if(isloading)
                showDialog(context: context, builder: (context)=>AlertDialog(
                  content: CircularProgressIndicator(),
                ));
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Registration successful',style: TextStyle(fontFamily: 'MyCustomFont',color:Color(0xFF393E46) ),),
                    content: Text('Your account has been created.',style: TextStyle(fontFamily: 'MyCustomFont',color:Color(0xFF393E46) )),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                        },
                      ),
                    ],
                  );
                },
              );





              // Perform login operation
            }
          },
          child: Text(
            'Register',
            style: TextStyle(
              fontFamily: "MyCustomFont",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            primary: Color(0xFF00ADB5),
            padding: EdgeInsets.symmetric(vertical: 16),

          ),
        ),
      ),
          SizedBox(height: 30,)
    ],));
  }
}
