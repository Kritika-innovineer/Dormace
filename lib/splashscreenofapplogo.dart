import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/startoptions.dart';
import 'package:hostel_app/notificationserviceclass.dart';

class splashscreenofdormace extends StatefulWidget {
  @override
  State<splashscreenofdormace > createState() => _splashScreenState();
}

class _splashScreenState extends State<splashscreenofdormace > {
  @override
  void initState() {
  
    notificationserviceclass obj = notificationserviceclass();
    obj.requestnotificationPermission();
    obj.getfcmToken();
    
  
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => startoptions()));
    });


  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(
        
          child:     Container(
                height: 130,
              
                child: Image.asset("assets/images/dormace.png"),
              ),
           
        ),
      ),
    );
  }
}
