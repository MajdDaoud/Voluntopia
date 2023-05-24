import 'package:flutter/material.dart';
import 'package:grad_proj/Regestration-Pages/Register.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

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
                width:400,
                height: 200,
                child: Hero(
                  tag: "logo",
                  child: Image(
                    image: AssetImage("assets/1.jpg",),
                  ),
                ),
              ),

              Column(
                children: [
                  Text("You,ve Been Missed", style: TextStyle(
                    color: Color(0xFF393E46),fontFamily: 'MyCustomFont', fontSize: 25,fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    height: 5 ,
                  ),Text("Please Login",style: TextStyle(fontFamily: "MyCustomFont", color: Color(0xFF393E46),fontSize: 20 ,fontWeight: FontWeight.bold),)
                ],
              ),

              //Beginning of the form section
              SizedBox(height:50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      //TextField to enter email
                      child: TextFormField(
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
                    SizedBox(height: 25,),
                    //TextField to enter password
                    Container(
                      width: 300,
                      child: TextFormField(
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
                    SizedBox(height: 40),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Perform login operation
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
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Don,t have an account?",style: TextStyle(
                       color:  Color(0xFF393E46)
                           ,fontFamily: "MyCustomFont"
                      ),
                      ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(onPressed: (){
                          Navigator.pushNamed(context, '/register');
                        }, child: Text("Register",style: TextStyle(color: Color(0xFF00ADB5),fontFamily: "MyCustomFont" ),))
                      ],
                    )
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