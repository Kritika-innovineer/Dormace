import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class attendancehistory extends StatefulWidget {
  @override
  State<attendancehistory> createState() => _attendancehistoryState();
}

class _attendancehistoryState extends State<attendancehistory> {
  TextEditingController searchbarcontroller = TextEditingController();
  String? selecteddate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance History",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance Records",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Container(
                    height: 40,
                    child: Image.asset("assets/images/calendar.png")),
                SizedBox(width: 16),
                ElevatedButton(
              
                  style: ElevatedButton.styleFrom(
                           elevation: 0,
                          side: BorderSide(
                            color: Colors.black26,

                          ),
                              shape: RoundedRectangleBorder(
                              
                                borderRadius: BorderRadius.circular(14),
                                
                              )),
                  onPressed: () async {
                    DateTime? pickeddate = await showDatePicker(
                      
                        context: context,
                        firstDate: DateTime(2026),
                        lastDate: DateTime.now());

                    if (pickeddate != null) {
                      setState(() {
                         String finalpickeddate = "${pickeddate.day}-${pickeddate.month}-${pickeddate.year}";
                        selecteddate = finalpickeddate;
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Text(selecteddate == null ?
                        "Pick A Date" : "${selecteddate}",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.black)),
                              SizedBox(width: 2,),
                              Icon(Icons.arrow_drop_down),

                    ],
                  ),
                ),
                   SizedBox(width: 16),
              
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 370,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Name"),
                  SizedBox(
                    width: 40,
                  ),
                  Text("Room No"),
                  SizedBox(
                    width: 40,
                  ),
                  Text("Time"),
                  SizedBox(
                    width: 40,
                  ),
                  Text("Status"),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collectionGroup("records")
                      .where("attendancestatus", isEqualTo: "present")
                      .orderBy("time", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No attendance records"));
                    }
                    var docs = snapshot.data!.docs;

                    return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          var doc = docs[index];
                          var data = doc.data() as Map<String, dynamic>;
if(data["date"]== selecteddate){
                          return Container(
                            height: 70,
                            width: 370,
                            child: Card(
                               color: Colors.grey.shade100,
                  elevation: 2,
                              child: Container(
                                height: 110,
                                padding: EdgeInsets.only(top: 22),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 5,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 9,
                                          ),
                                          Text(data["name"] ?? "Unknown",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        left: 120,
                                        child: Text(data["roomno"] ?? "--",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15))),
                                    Positioned(
                                        right: 80,
                                        child: Text(data["time"] ?? "--:--",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15))),
                                    Positioned(
                                        right: 10,
                                        child: Text(data["attendancestatus"] ?? data["status"] ?? "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15))),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        },

                  
              );

                  },


                  ),



            ),
          ],
        ),
      ),
    );
  }
}
