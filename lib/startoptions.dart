import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:hostel_app/wardenhomepg.dart';
import 'homepage.dart';
import 'loginpgforwarden.dart';
import 'loginpgofstudent.dart';
import 'signinOptions.dart';
import 'signupforphoneotp.dart';

import 'wardennamespg.dart';

class startoptions extends StatefulWidget {
  @override
  State<startoptions> createState() => _startoptionsState();
}

class _startoptionsState extends State<startoptions> {
  String dropdownvalue = "Faculty Role";

  List<String> roles = ["Faculty Role", "Warden", "Caretaker", "Coordinator"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 90, child: Image.asset("assets/images/gjulogo.png")),
            SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.center,
              "GURU JAMBHESHWAR UNIVERSITY",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900),
            ),
            Text("OF SCIENCE AND TECHNOLOGY",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900)),
            SizedBox(
              height: 60,
            ),
            Text(
              "Welcome to",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 100,
              child: Image.asset("assets/images/dormace.png"),
            ),
            SizedBox(
              height: 26,
            ),
            Text(
              "Select your role to continue",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => homepage()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => signInoptions()));
                    }
                  },
                  
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.blueAccent,
                    ),
                    height: 110,
                    width: 150,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 30,
                            child: Image.asset("assets/images/student.png")),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Student",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    )),
                  ),
                ),
                SizedBox.square(dimension: 12),
                InkWell(
                  onTap: () async {
                    try {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        String curruseruid = user.uid;
                        DocumentSnapshot snapshot = await FirebaseFirestore
                            .instance
                            .collection("wardenprofiledata")
                            .doc(curruseruid)
                            .get();

                        if (!snapshot.exists) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loginpgofwarden()));
                        } else {
                          var data = snapshot.data() as Map<String, dynamic>;

                        
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => wardenhomepg()));
                          }
                        
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginpgofwarden()));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${e}"),
                        ),
                      );
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.blueAccent,
                      ),
                      height: 110,
                      width: 150,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30,
                              child: Image.asset("assets/images/warden.png")),
                          SizedBox(
                            height: 8,
                          ),
                          DropdownButton<String>(
                            value: dropdownvalue,
                            dropdownColor: Colors.grey.shade700,
                            
                            items: roles.map((String role) {
                              return DropdownMenuItem<String>(
                                value: role,
                                child: Text(
                                  role,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ],
                      ))),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
