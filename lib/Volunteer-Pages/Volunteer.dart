import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:grad_proj/Login.dart';
import 'package:grad_proj/Organisation-Pages/All-Projects.dart';
import 'PersonalAccount.dart';

import 'MyFavourite.dart';
import 'ParticipeProjects.dart';

class Volunteer extends StatefulWidget {
  const Volunteer({super.key});

  @override
  State<Volunteer> createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
  int _counter = 0;

  final List<Widget> _children = [
    PersonalAccount(),
    AllProjects(),
    MyFavourite(),
    ParticipeProjects(),
  ];

  void onTabTapped(int count) {
    setState(() {
      _counter = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Image.asset("assets/1.jpg",height: 130,),
        centerTitle: true,
        leading:IconButton(onPressed: (){


        }, icon: Icon(Icons.notifications_active_outlined,color: Colors.grey,)) ,

        backgroundColor:Colors.white,
        actions: [IconButton(onPressed: (){}, icon: IconButton(onPressed: (){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Loging out??",style: TextStyle(fontFamily: "MyCustomFont"),),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFF00ADB5),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: MaterialButton(onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                }, child:Text("Yes",
                  style: TextStyle(fontFamily: "MyCustomFont",color: Colors.white),)),
              ),
              SizedBox(width: 25,),
              Container(
                decoration: BoxDecoration(
                    color:Color(0xFFF05F00),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: MaterialButton(onPressed: (){
                  Navigator.pop(context);
                }, child:Text("No",
                  style: TextStyle(fontFamily: "MyCustomFont",color: Colors.white),)),
              ),
              SizedBox(height: 20,)
            ],
          ),
        );
      });
    },icon: Icon(Icons.logout_outlined,color: Colors.grey,),))],
      ),
      body: _children[_counter],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _counter,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_4_outlined),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_customize),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_numbered), label: 'Participe'),
        ],
        selectedItemColor: Color(0xFF00ADB5),
        selectedLabelStyle: TextStyle(
          fontFamily: "MyCustomFont",
          color: Color(0xFF393E46),
          fontSize: 16,
        ),
      ),
    );
  }
}

class PersonalAcount {}
