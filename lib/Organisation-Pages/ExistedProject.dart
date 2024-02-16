import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/Widgets/tasks-item.dart';
import '../Widgets/project_item.dart';
import 'All-Projects.dart';
class ExistedProject extends StatefulWidget {

  late final ProjItem item;
  ExistedProject({required this.item});


  @override
  State<ExistedProject> createState() => _ExistedProjectState();

}

class _ExistedProjectState extends State<ExistedProject> {


  @override

  Widget build(BuildContext context) {
    CollectionReference orderref = FirebaseFirestore.instance.collection("Projects").doc(widget.item.projName).collection("tasks");
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.keyboard_return,color: Colors.grey[400],),onPressed: (){
          Navigator.pop(context);
        },),
        title: Image.asset("assets/1.jpg",height: 130,),
        centerTitle: true,

        backgroundColor:Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)
                        ),
                        child: Image.network(widget.item.imageUrl,height: 250,width: double.infinity,fit: BoxFit.cover,),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0),
                                    Colors.black.withOpacity(0.8)
                                  ],
                                  stops: [0.6,1]
                              )
                          ),
                          height: 250,
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                            child: Text(widget.item.projName,style: TextStyle(color: Colors.white,fontFamily: "MyCustomFont",fontSize: 25 ),),
                          ))
                    ],
                  ),
                    SizedBox(height: 25,),
                  Row(
                    children: [
                      Icon(Icons.description_outlined, color: Color(0xFFF05F00)),
                      SizedBox(width: 5,),
                      Text("Project Descreption :",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46),fontWeight: FontWeight.bold,fontSize: 18),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(widget.item.description,style: TextStyle(fontFamily:"MyCustomFont",color: Colors.black45,fontSize: 15 ),),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: Color(0xFFF05F00)),
                              SizedBox(width: 5,),
                              Text("Location:",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46),fontWeight: FontWeight.bold,fontSize: 18),),

                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(widget.item.location,style: TextStyle(fontFamily:"MyCustomFont",color: Colors.black45,fontSize: 15 ),),
                        ],
                      ),
                      SizedBox(width: 70,),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.date_range_rounded, color: Color(0xFFF05F00)),
                              SizedBox(width: 5,),
                              Text("Start Date:",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46),fontWeight: FontWeight.bold,fontSize: 18),),

                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(widget.item.date.toString().substring(0, 10),style: TextStyle(fontFamily:"TimesNewRoman",color: Colors.black45,fontSize: 15 ),),
                        ],
                      )
                    ],
                  ),

                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Icon(Icons.task_alt, color: Color(0xFFF05F00)),
                      SizedBox(width: 5,),
                      Text("Tasks :",style: TextStyle(fontFamily: "MyCustomFont",color: Color(0xFF393E46),fontWeight: FontWeight.bold,fontSize: 18),),

                    ],
                  ),
                 SizedBox( height:10),
                 FutureBuilder(
                      future: orderref.get(),
                     builder: (context,snapshot){
                        if(snapshot.hasData){
                          return ListView.builder(shrinkWrap: true,itemCount:snapshot.data!.docs.length,itemBuilder: (context,index){
                            var doc = snapshot.data!.docs[index];
                            return Tasks(taskName: doc["taskName"],
                              taskDuration: doc["taskDuration"],
                              taskDescreption:  doc["taskDescreption"],
                              Situation:  doc["Status"], requests: [],id: widget.item.OrganisationId,projName: widget.item.projName,);
                          });
                        }else{
                          return Center(child: CircularProgressIndicator());
                        }


                 }),









                ],
          ),
        ),
      ),
    );
  }
}
