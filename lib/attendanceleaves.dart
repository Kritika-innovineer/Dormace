import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'homepage.dart';
import 'loginpgforwarden.dart';
import 'loginpgofstudent.dart';
import 'signinOptions.dart';
import 'signupforphoneotp.dart';

import 'wardennamespg.dart';

class leaveofstudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students Leave",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body:
    Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Text("All Students Leave", style: TextStyle(fontSize: 18,  fontWeight: FontWeight.w600)),
      
         StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collectionGroup("leaves")
                .orderBy('timeofleaving', descending: true).where("hostelstatus", isEqualTo: "left")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No student leave", style: TextStyle(fontSize: 20)),
                );
              }
      
              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      final data = doc.data() as Map<String, dynamic>;
      
                      return Card(
                       elevation: 3,
                        child: Container(
                          
                          height: 230,
                          padding: EdgeInsets.all(15),
                          child: Stack(
                            children: [
                              Positioned(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 23,
                                        child: Icon(
                                          Icons.person,
                                          size: 20,
                                        )),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(data["name"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 38,
                                  left: 60,
                                  child: Text("Room No : ${data["roomno"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13))),
                              Positioned(
                                  top: 60,
                                  left: 60,
                                  child: Text(data["hostelname"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13))),
                              Positioned(
                                  top: 80,
                                  left: 60,
                                  child: Text(
                                      "Department : ${data["department"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13))),
                              Positioned(
                                  top: 100,
                                  left: 60,
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("+91 ${data["phoneno"]}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13)),
                                        ],
                                      ),
                                    ],
                                  )),
                              Positioned(
                                  top: 130,
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 18,
                                          child: Image.asset(
                                              "assets/images/location.png")),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Destination : ${data["address"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13)),
                                    ],
                                  )),
                              Positioned(
                                  top: 155,
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 18,
                                          child: Image.asset(
                                              "assets/images/calendar.png")),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          "Date of leaving : ${data["dataofleaving"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13)),
                                    ],
                                  )),
                              
                              Positioned(
                                  top: 180,
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 18,
                                          child: Image.asset(
                                              "assets/images/clock.png")),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Time : ${data["timeofleaving"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13)),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      );
      
                    }),
              );
            }),
            ],),
    )
    );
  }
}
