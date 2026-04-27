import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loginpgofstudent.dart';

class viewprofilepg extends StatelessWidget {
  final String requestorid;
  const viewprofilepg({super.key, required this.requestorid});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            SizedBox.square(
              dimension: 20,
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("userprofiledata")
                  .doc(requestorid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text("Profile not found"));
                }

                var data = snapshot.data!.data() as Map<String, dynamic>;

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.grey.shade100,
                  ),
                  height: 140,
                  width: 353,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox.square(dimension: 18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data["name"] ?? "Your name"),
                            Text(data["hostelname"] ?? "Not set"),
                            Text(data["roomno"] ?? "Not set"),
                            Text(data["studentId"] ?? "Not set"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
  ],
        ),
      ),

    );
  }
}
