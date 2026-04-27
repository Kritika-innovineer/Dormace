import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'fingerprintRequired.dart';
import 'homepage.dart';
import 'main.dart';
import 'profileclass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hostel_app/notificationserviceclass.dart';
import 'package:hostel_app/deviceidService.dart';

class moreinfopg extends StatefulWidget {
  @override
  State<moreinfopg> createState() => _moreinfopgState();
}

class _moreinfopgState extends State<moreinfopg> {
  var namecontroller = TextEditingController();

  var hostelnamecontroller = TextEditingController();

  var roomnocontroller = TextEditingController();

  var studentidcontroller = TextEditingController();

  String dropdownvalueOFHOSTELNAME = "Select hostel name";

  var hostelname = [
    "Select hostel name",
    "Kasturba Bhavan",
    "Saraswati Bhavan",
    "Girls Hostel 3",
    "Amrita Devi Bhavan",
    "Kalpana Chawla Bhawan"
  ];

  String dropdownvalueOFHOSTELTYPE = "Select hostel type";

  var hosteltype = ["Select hostel type", "Girls Hostel", "Boys Hostel"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Setting profile",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.lightBlue.shade100,
            child: SingleChildScrollView(
              child: Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 25, bottom: 75),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: Colors.white,
                      ),
                      width: 370,
                      child: Column(
                        children: [
                          SizedBox.square(
                            dimension: 25,
                          ),
                          Text("DormACe",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30)),
                          Text(
                            "Complete your profile",
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            padding: EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500)),
                                SizedBox.square(dimension: 9),
                                SizedBox(
                                  height: 60,
                                  width: 300,
                                  child: TextField(
                                    controller: namecontroller,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: "Enter your name",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox.square(dimension: 20),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Hostel Type",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500)),
                                        Container(
                                          child: DropdownButton(
                                              value: dropdownvalueOFHOSTELTYPE,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              items: hosteltype
                                                  .map((String hosteltype) {
                                                return DropdownMenuItem(
                                                  child: Text(
                                                    hosteltype,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  value: hosteltype,
                                                );
                                              }).toList(),
                                              onChanged: (String? newvalue) {
                                                setState(() {
                                                  dropdownvalueOFHOSTELTYPE =
                                                      newvalue!;
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Hostel Name",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500)),
                                        Container(
                                          child: DropdownButton(
                                              value: dropdownvalueOFHOSTELNAME,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              items: hostelname
                                                  .map((String hostelname) {
                                                return DropdownMenuItem(
                                                  child: Text(hostelname,
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                  value: hostelname,
                                                );
                                              }).toList(),
                                              onChanged: (String? newvalue) {
                                                setState(() {
                                                  dropdownvalueOFHOSTELNAME =
                                                      newvalue!;
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox.square(dimension: 20),
                                Text("Room Number",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500)),
                                SizedBox.square(dimension: 9),
                                SizedBox(
                                  height: 60,
                                  width: 300,
                                  child: TextField(
                                    controller: roomnocontroller,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "eg - 101",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox.square(dimension: 20),
                                Text("Student ID",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500)),
                                SizedBox.square(dimension: 9),
                                SizedBox(
                                  height: 60,
                                  width: 300,
                                  child: TextField(
                                    controller: studentidcontroller,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Enter your rollno",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox.square(dimension: 30),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 300,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (namecontroller.text.isEmpty ||
                                      dropdownvalueOFHOSTELNAME.isEmpty ||
                                      roomnocontroller.text.isEmpty ||
                                      studentidcontroller.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Please enter all the fields")));
                                    return;
                                  }

                                  notificationserviceclass obj =
                                      notificationserviceclass();
                                  String? studentdeviceToken =
                                      await obj.getfcmToken();
                                  String currentDeviceId =
                                      await DeviceIdService.getDeviceId();

                                  await FirebaseFirestore.instance
                                      .collection("userprofiledata")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .set(
                                    {
                                      "name": namecontroller.text,
                                      "hostelname": dropdownvalueOFHOSTELNAME,
                                      "roomno": roomnocontroller.text,
                                      "studentId": studentidcontroller.text,
                                      "biometricEnabled": true,
                                      "hosteltype": dropdownvalueOFHOSTELTYPE,
                                      "uid": FirebaseAuth
                                          .instance.currentUser!.uid,
                                      "studentdeviceToken": studentdeviceToken,
                                      "deviceId": currentDeviceId,
                                    },
                                  );

                                  User user =
                                      FirebaseAuth.instance.currentUser!;

                                  DocumentSnapshot doc = await FirebaseFirestore
                                      .instance
                                      .collection("userprofiledata")
                                      .doc(user.uid)
                                      .get();

                                  if (!doc.exists) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => moreinfopg()),
                                    );
                                  } else {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => homepage()),
                                      (route) => false,
                                    );
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
                                  "Ready To Go !",
                                  style: TextStyle(fontSize: 17),
                                )),
                          ),
                          SizedBox(height: 50),
                        ],
                      ))),
            )));
  }
}
