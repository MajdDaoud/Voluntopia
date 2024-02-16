import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grad_proj/Login.dart';
import 'package:grad_proj/Organisation.dart';
import 'package:grad_proj/Volunteer-Pages/Volunteer.dart';

import 'Chat-Pages/ProjectChat.dart';
import 'Regestration-Pages/Register.dart';
import 'firebase_options.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),

      },
      home: AnimatedSplashScreen(splash: Hero(tag: "logo",child: Image(image: AssetImage("assets/1.jpg")
        ,width: 400,height: 400,)),
        nextScreen:LoginPage(),
      backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 500,

      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


