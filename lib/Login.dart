import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_proj/Organisation.dart';
import 'package:grad_proj/Regestration-Pages/Register.dart';
import 'package:grad_proj/Volunteer-Pages/Volunteer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    // Get the user document from the Firestore 'users' collection
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    // Check if the user document exists and has 'type' and 'status' fields
    if (userDoc.exists &&
        userDoc.get('type') != null &&
        userDoc.get('Status') != null) {
      // Return the user type and status
      return {'type': userDoc.get('type'), 'status': userDoc.get('Status')};
    } else {
      // If the user document doesn't exist or doesn't have 'type' and 'status' fields, return null
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400,
                height: 200,
                child: Hero(
                  tag: "logo",
                  child: Image(
                    image: AssetImage(
                      "assets/1.jpg",
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    "You've Been Missed",
                    style: TextStyle(
                        color: Color(0xFF393E46),
                        fontFamily: 'MyCustomFont',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Please Login",
                    style: TextStyle(
                        fontFamily: "MyCustomFont",
                        color: Color(0xFF393E46),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              //Beginning of the form section
              SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      //TextField to enter email
                      child: TextFormField(
                        controller: emailController,
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
                    //TextField to enter password
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: passwordController,
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
                      width: 200,
                      child: ElevatedButton(

                        onPressed: () async {
                          if(_formKey.currentState!.validate()){
                            try{

                              final UserCredential userCredential =
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              final userData = await getUserData(userCredential.user!.uid);
                              if(userData!=null){
                                final userType = userData['type'];
                                final userStatus = userData['Status'];
                                if(userType=='Volunteer'){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Volunteer()));
                                }else if(userType=='Organisation'){

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Organisation()));
                                  /*else{
                                    showDialog(context: context, builder: (context)=>AlertDialog(
                                      
                                      content: Text("your account is still waiting admin's approval",style: TextStyle(fontFamily: "MyCustomFont"),),
                                    ));
                                  }*/
                                }

                              }

                            }

                            catch(e){
                                    print(e);
                            }
                          }
                        },
                        child: Text(
                          'LOGIN',
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text("Dont have an account?",style: TextStyle(color:Color(0xFF393E46),fontFamily: "MyCustomFont" ),),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                      }, child: Text("Register Now",style: TextStyle(color:Color(0xFF00ADB5),fontFamily: "MyCustomFont" ),))
                    ],)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}