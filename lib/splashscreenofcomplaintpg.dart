import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'complainhomepg.dart';
import 'homepage.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashScreenofcomplaint extends StatefulWidget {
  @override
  State<splashScreenofcomplaint > createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreenofcomplaint > {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => complainhomepage()));
    });

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade50,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Complaints",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
              Container(
                height: 80,
                width: 80,
                child: Image.asset("assets/images/logoofcomplaint.gif"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
