import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hostel_app/studentattendanceoptions.dart';
import 'fingerprintRequired.dart';
import 'homepage.dart';
import 'main.dart';
import 'profileclass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class markleave extends StatefulWidget {
  @override
  State<markleave> createState() => _markleaveState();
}

class _markleaveState extends State<markleave> {
  TextEditingController namecontroller = TextEditingController();

  TextEditingController hostelnamecontroller = TextEditingController();

  TextEditingController roomnocontroller = TextEditingController();

  TextEditingController departmentcontroller = TextEditingController();

  TextEditingController addcontroller = TextEditingController();

  TextEditingController phonenocontroller = TextEditingController();

   String locationText = "";

  String statusText = "";

  String distanceText = "";

  final double hostelLat = 29.1728; 
 // change this
  final double hostelLong = 75.7305; 
 // change this
  final double allowedRadius = 200;

String dropdownvalue = "Select hostel";

var hostelname =["Select hostel", "Gh 1", "Gh 2","Gh 3","Gh 4"];
  Future<bool> getcurrentlocation() async { // return true if and only if inside hostel premises
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
    } catch (e) {
      print("ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mark As Leave",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.lightBlue.shade100,
            child: Center(
                child: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 70),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29),
                    color: Colors.white,
                  ),
                  height: 750,
                  width: 340,
                  child: Column(
                   
                    children: [
                      SizedBox.square(
                        dimension: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:20, right: 20 ),
                        child: Text(
                          "Leave will only be marked outside hostel premises !",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox.square(dimension: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          SizedBox.square(dimension: 9),
                          SizedBox(
                            height: 45,
                            width: 300,
                            child: TextField(
                              controller: namecontroller,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "Enter your name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox.square(dimension: 20),
                       Text("Hostel Name",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                           SizedBox.square(dimension: 9),
                          Container(
                              child:  DropdownButton(
                                    value: dropdownvalue,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    items: hostelname.map((String condn) {
                                      return DropdownMenuItem(
                                        child: Text(condn),
                                        value: condn,
                                      );
                                    }).toList(),
                                    onChanged: (String? newvalue) {
                                      setState(() {
                                       dropdownvalue = newvalue!;
                                      });
                                    }),
                             ),
                              SizedBox.square(dimension: 20),
                          Text("Room Number",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          SizedBox.square(dimension: 9),
                          SizedBox(
                            height: 45,
                            width: 300,
                            child: TextField(
                              controller: roomnocontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "eg - 101",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox.square(dimension: 20),
                          Text("Department",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          SizedBox.square(dimension: 9),
                          SizedBox(
                            height: 45,
                            width: 300,
                            child: TextField(
                              controller: departmentcontroller,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "Enter your department",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox.square(dimension: 20),
                          Text("Address",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          SizedBox.square(dimension: 9),
                          SizedBox(
                            height: 45,
                            width: 300,
                            child: TextField(
                              controller: addcontroller,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Address where you are going...",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox.square(dimension: 20),
                          Text("Phone No",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          SizedBox.square(dimension: 9),
                          SizedBox(
                            height: 45,
                            width: 300,
                            child: TextField(
                              controller: phonenocontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter your phone no",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox.square(dimension: 30),
                        ],
                      ),
                      Container(
                        height: 45,
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (namecontroller.text.isEmpty ||
                                 dropdownvalue == "Select hostel"||
                                  roomnocontroller.text.isEmpty ||
                                  phonenocontroller.text.isEmpty ||
                                  addcontroller.text.isEmpty ||
                                  departmentcontroller.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Please enter all the fields")));
                                return;
                              }

                              String curruid = FirebaseAuth.instance.currentUser!.uid;

                              var existingLeaveQuery = await FirebaseFirestore.instance
                                  .collection("studentsleave")
                                  .doc(curruid)
                                  .collection("leaves")
                                  .where("hostelstatus", isEqualTo: "left")
                                  .get();

                              if (existingLeaveQuery.docs.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("You are already on leave! Mark entry first.")));
                                return;
                              }

                            
                              if (await getcurrentlocation() ){ 
                                 ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("You are inside hostel premises, leave will not be marked")));
                                return;

                                }

                              DateTime now = DateTime.now();

                              String dateofleaving =
                                  "${now.day} - ${now.month} - ${now.year}";
                              String timeofleaving =
                                  "${now.hour} : ${now.minute} : ${now.second}";
                              try {
                                await FirebaseFirestore.instance
                                    .collection("studentsleave")
                                    .doc(curruid)
                                    .collection("leaves")
                                    .add(
                                  {
                                    "name": namecontroller.text,
                                    "hostelname":dropdownvalue.toString(),
                                    "roomno": roomnocontroller.text,
                                    "department": departmentcontroller.text,
                                    "address": addcontroller.text,
                                    "phoneno": phonenocontroller.text,
                                    "dataofleaving": dateofleaving.toString(),
                                    "timeofleaving": timeofleaving.toString(),
                                    "hostelstatus": "left",
                                    "dateofcoming":"",
                                    "timeofcoming": "",
                                    "timestamp": FieldValue.serverTimestamp(),
                                  },
                                );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Happy journey !")));

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
                            style: ElevatedButton.styleFrom(
                                elevation: 4,
                                backgroundColor: Colors.lightBlueAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                )),
                            child: Text(
                              "Mark Leave",
                              style: TextStyle(fontSize: 17),
                            )),
                      ),
                    ],
                  )),
            ))));
  }
}
