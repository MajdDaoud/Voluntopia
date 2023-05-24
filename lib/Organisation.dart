import 'package:flutter/material.dart';
import 'package:grad_proj/Organisation-Pages/AddProject.dart';

import 'Organisation-Pages/AccountManagement.dart';
import 'Organisation-Pages/All-Projects.dart';
import 'Organisation-Pages/Archive.dart';
import 'Organisation-Pages/MyProjects.dart';
class Organisation extends StatefulWidget {
  const Organisation({Key? key}) : super(key: key);

  @override
  State<Organisation> createState() => _OrganisationState();
}

class _OrganisationState extends State<Organisation> {
  int _currentIndex = 0;


  final List<Widget> _children = [
    AccountManagement(),
    AllProjects(),
    AddProject(),
    MyProjects(),
    Archive(),


  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Image.asset("assets/1.jpg",height: 130,),
        centerTitle: true,
        leading:IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active_outlined,color: Colors.grey,)) ,

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
                    child: MaterialButton(onPressed: (){}, child:Text("Yes",
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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'All ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined,size: 40,),
            label: 'Add ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favourite ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'My',
          ),
        ],
        selectedItemColor:Color(0xFF00ADB5),
        selectedLabelStyle: TextStyle(
          fontFamily: "MyCustomFont",
          color: Color(0xFF393E46),
          fontSize: 16,
        ),
      ),
    );
  }
}







