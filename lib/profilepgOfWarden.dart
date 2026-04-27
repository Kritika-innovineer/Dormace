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

class profilepgofWarden extends StatefulWidget {
  
  @override
  State<profilepgofWarden> createState() => _profilepgofWardenState();
}

class _profilepgofWardenState extends State<profilepgofWarden> {
  bool currState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warden Profile",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body:


Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          child: Column(
            children: [
            SizedBox(height: 2,),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("wardenprofiledata").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),


                
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text("Profile not found"));
                }

                var data = snapshot.data!.data() as Map<String, dynamic>;

                return Container(
                 
                
               
                height: 150,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // Profile Image
                        CircleAvatar(
                          radius: 45,
                          

                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                        SizedBox(width: 20),
                        // Profile Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["name"] ?? "Your Name",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color:  Colors.grey.shade600),
                            ),
                           
                            Text(
                              data["phoneno"] ?? "Phone no",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                            ),
                            Text(
                              data["hostelname"] ?? "Hostel name",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                            ),
                            Text(
                              data["hosteltype"] ?? "hostel type",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
       
              SizedBox(
             height: 2,
              ),
          
             
              Container(
                padding: EdgeInsets.all(20),
                height: 70,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Text(
                  "App Settings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(
             height: 2,
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: 90,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Row(children: [
                  CircleAvatar(
                    radius: 25,
                    child: Icon(
                      Icons.notifications,
                      size: 17,
                    ),
                  ),
                  SizedBox.square(
                    dimension: 14,
                  ),
                  Text("Notifications", style: TextStyle(fontSize: 15)),
                  SizedBox(
                    width: 100,
                  ),
                  Switch(
                      value: currState,
                      onChanged: (value) {
                        setState(() {
                          currState = value;
                        });
                      })
                ]),
              ),
                SizedBox(height: 12,),
             
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Want to log out?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            ElevatedButton(
                                onPressed: () async {
                               

                                  await FirebaseAuth.instance.signOut();

                               Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) =>loginpgofwarden()),
  (route) => false,
);

                                },
                                child: Text("Logout")),
                          ],
                        );
                      });
                },
                child: Container(
                  padding: EdgeInsets.all(20),
               
                  height: 90,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Icon(
                        Icons.logout,
                    size: 17,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox.square(
                      dimension: 14,
                    ),
                    Text("Logout",
                        style: TextStyle(fontSize: 15, color: Colors.red)),
                  ]),
                ),
              ),
                SizedBox(height: 12,),



            ],
          ),
        ),
),
  




    );

  }
}