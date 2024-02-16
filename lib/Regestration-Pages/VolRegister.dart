import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/Login.dart';
enum Type { organisation, volunteer }
class VolRegister extends StatefulWidget {


  @override
  State<VolRegister> createState() => _VolRegisterState();
}

class _VolRegisterState extends State<VolRegister> {
   late String email ;
 late String password ;
   late String name ;
  String? _selectedCity;

  late String story ;
  late String study ;
  Future<void> registerUser(String email, String password, String name, String city, String story, String study) async {
    if (email.trim().isEmpty || password.isEmpty) {
      throw 'Email and password must not be empty';
    }
    var formdata = _formKey.currentState;
    formdata?.save();
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User? user = userCredential.user;
      // Add user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': name,
        'city': city,
        'story': story,
        'study': study,
        'type' : "Volunteer",
        'Status':'approved'

      });
    } catch (e) {
      print(e.toString());
    }
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

  TextEditingController _dateController = TextEditingController();
  Type _registrationType = Type.volunteer;
  void _handleRegistrationTypeChange(Type? value) {
    if (value != null) {
      setState(() {
        _registrationType = value;
      });
    }
  }
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            width: 300,
            child: TextFormField(

              onFieldSubmitted: (value){
                email=value;
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
          SizedBox(height: 25,),
          Container(
            width: 300,
            child: TextFormField(

              onFieldSubmitted: (value){
                password=value;
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
          SizedBox(height: 25),
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
            ),
          ),
          SizedBox(height: 25,),
          Container(
            width: 300,

            child: TextFormField(
              onFieldSubmitted: (value){
                story=value!;
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
                labelText: 'Tell us your story',
                labelStyle: TextStyle(
                  fontFamily: "MyCustomFont",
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.paste_outlined,
                  color: Colors.grey[400],
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your story';
                }
                return null;
              },
            ),
          ),

          SizedBox(height: 25,),
          Container(
            width: 300,
            child: TextFormField(
              onFieldSubmitted: (value){
                study=value!;
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
                labelText: 'Your Study',

                labelStyle: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: "MyCustomFont",
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.medical_services,
                  color: Colors.grey[400],
                ),

              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your study';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),

          SizedBox(
            height: 25,
          ),
          Container(
            width: 250,
            child:ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Call the registerUser method
                  await registerUser(
                    email.trim(),
                    password.trim(),
                    name,
                    _selectedCity!,

                    story,
                    study,
                  );
                  showDialog(context: context, builder: (context)=>AlertDialog(
                    title: Text("Regestration Success",style: TextStyle(fontFamily: "MyCustomFont"),),
                    content: TextButton(child: Text("Continue to Login"),onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    } ,),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),

                    ),

                  ));

                }
              },
              child: Text('Register'),
            ),
          ),
          SizedBox(height: 30,)

        ],

      ),
    );
  }
}
