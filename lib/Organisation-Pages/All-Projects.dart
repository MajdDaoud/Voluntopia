import 'package:flutter/material.dart';
import '../Widgets/project_item.dart';
import '../Widgets/task-request-item.dart';
import '../Widgets/tasks-item.dart';
class AllProjects extends StatefulWidget {


  @override
  State<AllProjects> createState() => _AllProjectsState();
}
List<ProjItem> items = [
  ProjItem(
    projName: 'Project 1',
    imageUrl: 'https://www.goodnet.org/photos/281x197/30086_hd.jpg',
    date: DateTime(2023, 4, 15),
    duration: Duration(hours: 2),
    volReq: 5,
    location: 'New York', description: 'The project is holding in alzreraa street and aiming 20 children with age 12-20,,all the volunteers should have an expirience with children',
    tasks: [Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],)],// Set location for Project 1
  ),
  ProjItem(
    projName: 'Project 2',
    imageUrl: 'https://www.volunteerforever.com/wp-content/uploads/2019/01/Cheap-Affordable-Volunteer-Programs-Header.jpg',
    date: DateTime(2023, 5, 1),
    duration: Duration(hours: 3),
    volReq: 10,
    location: 'London', description: '',
    tasks: [Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],)],// Set location for Project 2
  ),
  ProjItem(
    projName: 'Project 3',
    imageUrl: 'https://rs.projects-abroad.co.uk/v1/hero/product-5bd040fd884f6.[1600].jpeg',
    date: DateTime(2023, 6, 1),
    duration: Duration(hours: 4),
    volReq: 7,
    location: 'Tokyo', description: '',
    tasks: [Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],)],// Set location for Project 3
  ),
  ProjItem(
    projName: 'Project 4',
    imageUrl: 'https://borgenproject.org/wp-content/uploads/11220564165_17af23550c_c.jpg',
    date: DateTime(2023, 7, 1),
    duration: Duration(hours: 5),
    volReq: 8,
    location: 'Paris', description: '',
    tasks: [Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],)],// Set location for Project 4
  ),
  ProjItem(
    projName: 'Project 5',
    imageUrl: 'https://www.volunteeringsolutions.co.uk/blog/wp-content/uploads/2014/05/volunteer-group.jpg',
    date: DateTime(2023, 8, 1),
    duration: Duration(hours: 6),
    volReq: 12,
    location: 'Sydney', description: '',
    tasks: [Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true,requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],),Tasks(taskName: "Logistics adminstrator",taskDuration: 2,taskDescreption: "the volunteer should have the ability to be on field for  hours a day", Situation: true, requests: [TaskRequest(volname: "anya", volUrl: "https://images.pexels.com/photos/6347743/pexels-photo-6347743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")],)],// Set location for Project 5
  ),
];

class _AllProjectsState extends State<AllProjects> {
  double _opacity = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _opacity = 1.0;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _opacity = 0.8;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index){
      return ProjItem(projName:items[index].projName ,
        imageUrl:items[index].imageUrl,
        date: items[index].date ,
        duration: items[index].duration,
        volReq: items[index].volReq,
      location: items[index].location, description: items[index].description, tasks: items[index].tasks,);

    },itemCount:items.length ,);
  }
}
