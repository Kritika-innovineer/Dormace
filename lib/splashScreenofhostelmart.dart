import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/homepage.dart';
import 'package:hostel_app/main.dart';
import 'package:hostel_app/startoptions.dart';


class splashScreenfohostelmart extends StatefulWidget {
  @override
  State<splashScreenfohostelmart> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreenfohostelmart> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomepgofStudentSection()));
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
              Text("HostelMart",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
              Container(
                height: 80,
                width: 80,
                child: Image.asset("assets/images/hostelmartlogo.gif"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
