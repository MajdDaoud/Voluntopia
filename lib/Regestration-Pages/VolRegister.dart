import 'package:flutter/material.dart';
enum Type { organisation, volunteer }
class VolRegister extends StatefulWidget {


  @override
  State<VolRegister> createState() => _VolRegisterState();
}

class _VolRegisterState extends State<VolRegister> {
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
          Container(
            width: 300,
            child: TextFormField(
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
                labelText: 'Date of Birth',
                hintText: 'Select your date of birth',
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
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
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

        ],

      ),
    );
  }
}
