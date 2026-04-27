import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hostel_app/attendanceleaves.dart';
import 'package:hostel_app/homepage.dart';
import 'package:hostel_app/locationfetch.dart';
import 'package:hostel_app/markleave.dart';
import 'package:hostel_app/studentattnedancehistory.dart';
import 'package:hostel_app/wardenattendancedashboard.dart';

class attendanceoptions extends StatefulWidget {
  @override
  State<attendanceoptions> createState() => _attendanceoptionsState();
}

class _attendanceoptionsState extends State<attendanceoptions> {
  String locationText = "";

  String statusText = "";

  String distanceText = "";

  final double hostelLat = 29.1728;

  // change this
  final double hostelLong = 75.7305;

  // change this
  final double allowedRadius = 200;

  Future<bool> getcurrentlocation() async {
    // return true if and only if inside hostel premises
    try {
      bool islocation = await Geolocator.isLocationServiceEnabled();
      if (!islocation) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Turn ON location services")),
        );
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permission denied")),
        );
        return false;
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Permission denied forever, enable in settings")),
        );
        return false;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double distance = Geolocator.distanceBetween(
        hostelLat,
        hostelLong,
        pos.latitude,
        pos.longitude,
      );

      setState(() {
        locationText = "Latitude: ${pos.latitude}\nLongitude: ${pos.longitude}";
        distanceText = "Distance from hostel: ${distance} meters";

        if (distance <= allowedRadius) {
          statusText = "INSIDE hostel boundary";
        } else {
          statusText = "OUTSIDE hostel boundary";
        }
      });

      if (distance <= allowedRadius) {
        return true;
      }
      return false;
    }
      catch (e) {
      print("ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return false;
    }
     /* DateTime now = DateTime.now();

      String dateofcoming = "${now.day} - ${now.month} - ${now.year}";
      String timeofcoming = "${now.hour} : ${now.minute} : ${now.second}";
      // Close the dialog
      var querySnapshot = await FirebaseFirestore.instance
          .collection("studentsleave")
          .doc(curruid)
          .collection("leaves")
          .where("hostelstatus", isEqualTo: "left")
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var docSnapshot in querySnapshot.docs) {
          await docSnapshot.reference.update({
            "hostelstatus": "came",
            "dateofcoming": dateofcoming.toString(),
            "timeofcoming": timeofcoming.toString(),
          });
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text("Welcome back hostel !")),
      );*/
  
  }

  @override
  String curruid = FirebaseAuth.instance.currentUser!.uid;

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Options",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) => {
              if (value == "view")
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>studentattendancehistory())),
                }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                
                value: "view",
                child: Text(
                  "View my attendance",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => locationfetch()));
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
                      child: Text("Mark Attendance",
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => markleave()));
                },
                child: Stack(
                  children: [
                    Positioned(
                      left: 18,
                      top: 20,
                      child: Container(
                          height: 29,
                          child: Image.asset("assets/images/leave.png")),
                    ),
                    Positioned(
                      top: 55,
                      left: 18,
                      child: Text("Mark Leave",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      top: 85,
                      left: 18,
                      child: Text("Happy journey!",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400)),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Welcome back hostel !",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(
                                "Entry will only be marked inside hostel premises.",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal))
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                              
                                 onPressed: () async {
                             

                              String curruid = FirebaseAuth.instance.currentUser!.uid;

                              var existingLeaveQuery = await FirebaseFirestore.instance
                                  .collection("studentsleave")
                                  .doc(curruid)
                                  .collection("leaves")
                                  .where("hostelstatus", isEqualTo: "left")
                                  .get();

                              if (existingLeaveQuery.docs.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("You are already attending hostel, no need to entry !")));
                                return;
                              }

                            
                              if (await getcurrentlocation() == false ){ 
                                 ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("You are outside hostel premises, entry will not be marked !")));
                                return;

                                }

                              DateTime now = DateTime.now();

                              String dateofcoming =
                                  "${now.day} - ${now.month} - ${now.year}";
                              String timeofcoming =
                                  "${now.hour} : ${now.minute} : ${now.second}";
                              try {
                                 String curruid = FirebaseAuth.instance.currentUser!.uid;

                              var existingLeaveQuery = await FirebaseFirestore.instance
                                  .collection("studentsleave")
                                  .doc(curruid)
                                  .collection("leaves")
                                  .where("hostelstatus", isEqualTo: "left")
                                  .get();
                                if (existingLeaveQuery.docs.isNotEmpty) {
        for (var docSnapshot in existingLeaveQuery.docs) {
          await docSnapshot.reference.update({
            "hostelstatus": "came",
            "dateofcoming": dateofcoming.toString(),
            "timeofcoming": timeofcoming.toString(),
          });
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text("Welcome back hostel !")),
      );

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          attendanceoptions()));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Error : ${e.toString()}")));
                                return;

                              }
                               
                              },
                              child: Text("Mark As Returned"))
                        ],
                      );
                    },
                  );
                },
                child: Stack(
                  children: [
                    Positioned(
                      left: 18,
                      top: 20,
                      child: Container(
                          height: 29,
                          child: Image.asset("assets/images/entrylogo.png")),
                    ),
                    Positioned(
                      top: 55,
                      left: 18,
                      child: Text("Entry",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      top: 85,
                      left: 18,
                      child: Text("Welcome back hostel !",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400)),
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
