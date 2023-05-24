import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/Regestration-Pages/OrgRegestraion.dart';
import 'package:grad_proj/Regestration-Pages/VolRegister.dart';
import 'package:image_picker/image_picker.dart';

enum Type { organisation, volunteer }
TextEditingController _dateController = TextEditingController();
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
 late File _image1;


// Create a focus node for the text field
final FocusNode _focusNode = FocusNode();

// Define the default and focused colors for the icon
final Color _defaultIconColor = Colors.grey[400]!;
final Color _focusedIconColor = Color(0xFF00ADB5);
String? _selectedCity;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();


}

class _RegisterPageState extends State<RegisterPage> {
  Type _registrationType = Type.volunteer;
   File? _image =null;

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
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.keyboard_backspace,color: Colors.black45,),),
        title: Image.asset("assets/1.jpg",height: 130,),

        backgroundColor:Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Volunteer',style: TextStyle(fontFamily: "MyCustomFont", color: Color(0xFF393E46),fontSize:14 ),),
                      leading: Radio(
                        value: Type.volunteer,
                        groupValue: _registrationType,
                        onChanged: _handleRegistrationTypeChange,
                        activeColor: Color(0xFF00ADB5),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Organization',style: TextStyle(fontFamily: "MyCustomFont", color: Color(0xFF393E46),fontSize: 14 ),),
                      leading: Radio(
                        value: Type.organisation,
                        groupValue: _registrationType,
                        onChanged: _handleRegistrationTypeChange,
                        activeColor: Color(0xFF00ADB5),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,


              ),
              if(_registrationType==Type.volunteer)
                VolRegister()
              else
                OrgRegestration()



            ],
          ),
        ),
      ),
    );
  }
}
