import 'package:flutter/material.dart';

class TaskRequest extends StatelessWidget {
  final String volname;
  final String volUrl;
   TaskRequest({ required this.volname, required this.volUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar( ),

          Text(volname,style:  TextStyle(
                      fontFamily: "MyCustomFont",
                      fontSize: 19,
                      color: Color(0xFF393E46),
                       ),),
          SizedBox(width: 30,),

          Container(
            decoration: BoxDecoration(
                color: Color(0xFF00ADB5),
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: MaterialButton(onPressed: (){}, child:Text("Accept",
              style: TextStyle(fontFamily: "MyCustomFont",color: Colors.white),)),
          ),

          Container(
            decoration: BoxDecoration(
                color:Color(0xFFF05F00),
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: MaterialButton(onPressed: (){
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: Center(child: Text("Cancel",style: TextStyle(fontFamily: "MyCustomFont",fontSize: 19,color: Color(0xFF393E46)),)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                  content: Text("The Request Is Cancelled",style: TextStyle(fontFamily: "MyCustomFont",fontSize: 17,color: Color(0xFF393E46))),

                );
              });
            }, child:Text("Cancel",
              style: TextStyle(fontFamily: "MyCustomFont",color: Colors.white),)),
          ),




        ],
      ),
    );
  }
}
