import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/notificationserviceclass.dart';

class Wardencomplaintdashboard extends StatefulWidget {
  @override
  State<Wardencomplaintdashboard> createState() =>
      _WardencomplaintdashboardState();
}

class _WardencomplaintdashboardState extends State<Wardencomplaintdashboard> {
  String timeago(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return "just now";
    if (diff.inHours < 1) {
      return "${diff.inMinutes} min ago";
    }
    if (diff.inDays < 1) return "${diff.inHours} hours ago";
    if (diff.inDays < 7) return "${diff.inDays} day ago";
    return "long time ago";
  }

  TextEditingController searchbarcontroller = TextEditingController();

  bool isallcomplaintsSelected = true;

  bool isattendedcomplaintsSelected = false;

  String typeselected = "All";


  void initState() {
    super.initState();
    searchbarcontroller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Complaint DashBoard",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.grey.shade100,
                    ),
                    height: 100,
                    width: 110,
                    
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("complaints")                              
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text("Null",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27));
                                }
                                return Text(
                                    snapshot.data!.docs.length.toString(),
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27));
                              }),
                          Text("Total"),
                        ],
                      ),
                    
                  ),
                  SizedBox.square(dimension: 12),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.grey.shade100,
                    ),
                    width: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("complaints")
                                
                                .where("status", isEqualTo: "pending")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Null",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27));
                              }
                              return Text(snapshot.data!.docs.length.toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27));
                            }),
                        Text("Pending"),
                      ],
                    ),
                  ),
                  SizedBox.square(dimension: 12),
                  Container(
  height: 100,
  width: 110,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(9),
    color: Colors.grey.shade100,
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
                    StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("complaints")
                                
                                  .where("status", isEqualTo: "completed")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text("Null",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27));
                                }
                                return Text(
                                    snapshot.data!.docs.length.toString(),
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 27)

                    );

                              }
                    
                    ),


                        Text("Completed"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        typeselected = "All";
                      });
                    },
                    child: Container(
                      height: 38,
                     
                      padding: EdgeInsets.only(left : 10, right:10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Text(
                        "All",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                      SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        typeselected = "Electrical";
                      });
                    },
                    child: Container(
                      height: 38,
                      
                      padding: EdgeInsets.only(left : 10, right:10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Text(
                        "Electrical",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        typeselected = "Water";
                      });
                    },
                    child: Container(
                      height: 38,
                      
                      padding: EdgeInsets.only(left : 10, right:10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Text(
                        "Water",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        typeselected = "Mess Food";
                      });
                    },
                    child: Container(
                      height: 38,
                      
                      padding: EdgeInsets.only(left : 10, right:10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Text(
                        "Mess Food",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        typeselected = "Infrastructure";
                      });
                    },
                    child: Container(
                      height: 38,
                      
                      padding: EdgeInsets.only(left : 10, right:10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Text(
                        "Infrastructure",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        typeselected = "Wifi";
                      });
                    },
                    child: Container(
                      height: 38,
                      
                      padding: EdgeInsets.only(left : 10, right:10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Text(
                        "Wifi",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        typeselected = "Cleanliness";
                      });
                    },
                    child: Container(
                      height: 38,
                      
                      padding: EdgeInsets.only(left : 10, right:10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Text(
                        "Cleanliness",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        typeselected = "Others";
                      });
                    },
                    child: Container(
                      height: 38,
                      
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Text(
                        "Others",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 145,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isallcomplaintsSelected = true;
                          isattendedcomplaintsSelected = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      child: Center(
                          child: Text(
                        "All Complaints",
                        style: TextStyle(
                            color: isallcomplaintsSelected
                                ? Colors.blueAccent
                                : Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Container(
                      height: 50,
                      width: 182,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isallcomplaintsSelected = false;
                            isattendedcomplaintsSelected = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        child: Center(
                            child: Text("Attended Complaints",
                                style: TextStyle(
                                    color: isattendedcomplaintsSelected
                                        ? Colors.blueAccent
                                        : Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))),
                      )),
                ],
              ),
            ),
            if (isallcomplaintsSelected == true)
              StreamBuilder<QuerySnapshot>(
                 stream: typeselected == "All" ? FirebaseFirestore.instance
                    .collection('complaints')
                    .where("status", isEqualTo: "pending")
                    .orderBy('Complaintpostedtiming', descending: true)
                    .snapshots(): 

                FirebaseFirestore.instance
                    .collection('complaints')
                    .where("status", isEqualTo: "pending").where("type", isEqualTo: typeselected )
                    .orderBy('Complaintpostedtiming', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child:
                          Text("No complaints", style: TextStyle(fontSize: 20)),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        final data = doc.data() as Map<String, dynamic>;
                        final Timestamp? ts = data["Complaintpostedtiming"];
                        final DateTime postedtimee =
                            ts != null ? ts.toDate() : DateTime.now();

                        return Container(
                          height: 180,
                          child: Card(
                        color:  Colors.grey.shade100,
                            elevation: 2,
                            child: Container(
                              height: 130,
                              padding: EdgeInsets.all(3),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 10,
                                    top: 8,
                                    child: Container(
                                      height: 33,
                                      width: 120,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                          child: Text(
                                        data["type"],
                                        style: TextStyle(fontSize: 12),
                                      )),
                                    ),
                                  ),
                                  Positioned(
                                    top: 50,
                                    left: 10,
                                    child: Container(
                                      width: 380,
                                      child: Text(data["desc"],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  Positioned(
                                       left: 10,
                                      top: 100,
                                      child: Text(data["name"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))),
                                  Positioned(
                                      top: 123,
                                      left: 10,
                                      child: Text(data["roomno"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))),
                                  Positioned(
                                       bottom: 2,
                                      left: 10,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Student Availability : ",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(data["timing"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500, fontSize: 12)),
                                        ],
                                      )),
                                  Positioned(
                                      bottom: 5,
                                      right: 10,
                                      child: Text(timeago(postedtimee),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ))),
                                  Positioned(
                                      right: 8,
                                      top: 8,
                                      child: Container(
                                        width: 160,
                                        height: 33,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 4,
                                                backgroundColor: Colors.green,
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                )),
                                            onPressed: () async {
                                               final DateTime attendedtime =
                            ts != null ? ts.toDate() : DateTime.now();
                                              await FirebaseFirestore.instance
                                                  .collection("complaints")
                                                  .doc(doc.id)
                                                  .update({
                                                "status": "completed",
                                                "complainattendedtiming":
                                                    Timestamp.now(),
                                              });

                                              var complaintData =
                                                  doc.data() as Map<String, dynamic>;
                                              
                                              String studenttoken = complaintData["deviceToken"];
                                            
                                           
                                                notificationserviceclass obj =
                                                    notificationserviceclass();
                                                await obj.sendnotification(studenttoken,
                                                    "Your complaint has been attended",
                                                    "${complaintData["desc"]}");
                                              
                                            },
                                            child: Text(
                                              "Mark Complete",
                                              style: TextStyle(fontSize: 12),
                                            )),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            if (isattendedcomplaintsSelected == true)
              StreamBuilder<QuerySnapshot>(
                stream: typeselected == "All" ? FirebaseFirestore.instance
                    .collection('complaints')
                    .where("status", isEqualTo: "completed")
                    .orderBy('complainattendedtiming', descending: true)
                    .snapshots(): 

                FirebaseFirestore.instance
                    .collection('complaints')
                    .where("status", isEqualTo: "completed").where("type", isEqualTo: typeselected )
                    .orderBy('complainattendedtiming', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("No complaints attended yet",
                          style: TextStyle(fontSize: 20)),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        final data = doc.data() as Map<String, dynamic>;
                     final Timestamp? ts = data["complainattendedtiming"];
final DateTime attendedtime =
    ts != null ? ts.toDate() : DateTime.now();
                       

                        return Card(
                     color:      Colors.grey.shade100,

elevation: 2,                          child: Container(
                              height: 180,
                            padding: EdgeInsets.all(3),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 10,
                                  top: 8,
                                  child: Container(
                                    height: 33,
                                    width: 105,
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                        child: Text(data["type"],
                                            style: TextStyle(fontSize: 12))),
                                  ),
                                ),
                                Positioned(
                                  top: 50,
                                  left: 10,
                                  child: Container(
                                    child: Text(data["desc"],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                Positioned(
                                     left: 10,
                                      top: 100,
                                    child: Text(
                                      data["name"],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Positioned(
                                     top: 126,
                                      left: 10,
                                    child: Text(data["roomno"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12))),
                                Positioned(
                                    bottom: 2,
                                      left: 10,
                                    child: Row(
                                      children: [
                                        Text("Student Availability : ",
                                            style: TextStyle(fontSize: 12)),
                                        Text(data["timing"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12)),
                                      ],
                                    )),
                                Positioned(
                                    bottom: 5,
                                    right: 10,
                                    child: Text(timeago(attendedtime),
                                        style: TextStyle(fontSize: 12))),
                              ],
                            ),
                          ),
                        );
                      },
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
