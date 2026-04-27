import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/profilepgOfWarden.dart';
import 'package:hostel_app/studentattendanceoptions.dart';
import 'package:hostel_app/wardenattendancehomepg.dart';
import 'package:hostel_app/wardennamespg.dart';
import 'homepage.dart';
import 'wardenattendancedashboard.dart';
import 'wardencomplaintdashboard.dart';

class wardenhomepg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Warden Home Page",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.black,
              size: 26,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profilepgofWarden()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 130,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => wardenattendancehomepg()));
                },
                child: Stack(
                  children: [
                    Positioned(
                      left: 25,
                      top: 30,
                      child: Container(
                        height: 28,
                        child: Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 25,
                      child: Text("View Attendance",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Container(
              width: 300,
              height: 130,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Wardencomplaintdashboard()));
                },
                child: Stack(
                  children: [
                    Positioned(
                      left: 25,
                      top: 30,
                      child: Container(
                          height: 35,
                          child: Image.asset("assets/images/complaint.png")),
                    ),
                    Positioned(
                      top: 75,
                      left: 25,
                      child: Text("View Complaints",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
