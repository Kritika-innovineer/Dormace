import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/studentattendanceoptions.dart';
import 'locationfetch.dart';


class splashScreenfoattendance extends StatefulWidget {
  @override
  State<splashScreenfoattendance> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreenfoattendance> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>attendanceoptions()));
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
              Text("Attendance",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
              Container(
                height: 80,
                width: 80,
                child: Image.asset("assets/images/logoofattendance.gif"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
