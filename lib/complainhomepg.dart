import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'complainpage.dart';

class complainhomepage extends StatefulWidget {
  @override
  State<complainhomepage> createState() => _complainhomepageState();
}

class _complainhomepageState extends State<complainhomepage> {
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

  bool isallcomplaintsSelected = true;

  bool isattendedcomplaintsSelected = false;

  String typeselected = "All";
  TextEditingController searchbarcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("All Complaints",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              SizedBox(width: 120),
              CircleAvatar(
    backgroundColor: Colors.grey.shade200,
                child: IconButton(
                  color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => complainpage()));
                    },
                    icon: Icon(Icons.add)),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 188,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isallcomplaintsSelected = true;
                          isattendedcomplaintsSelected = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade50,
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
                      width: 165,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isallcomplaintsSelected = false;
                            isattendedcomplaintsSelected = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  Colors.grey.shade50,
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        child: Center(
                            child: Text("My Attended Complaints",
                                style: TextStyle(
                                    color: isattendedcomplaintsSelected
                                        ? Colors.blueAccent
                                        : Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))),
                      )),
                ],
              ),
              SizedBox(height: 15),
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
                        padding: EdgeInsets.only(left: 10, right: 10),
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
                        padding: EdgeInsets.only(left: 10, right: 10),
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
                        padding: EdgeInsets.only(left: 10, right: 10),
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
                        padding: EdgeInsets.only(left: 10, right: 10),
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
                        padding: EdgeInsets.only(left: 10, right: 10),
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
                        padding: EdgeInsets.only(left: 10, right: 10),
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
                        padding: EdgeInsets.only(left: 10, right: 10),
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
              SizedBox(height: 10),
              if (isallcomplaintsSelected)
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: typeselected == "All"
                        ? FirebaseFirestore.instance
                            .collection('complaints')
                            .where("status", isEqualTo: "pending")
                            .orderBy('Complaintpostedtiming', descending: true)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('complaints')
                            .where("status", isEqualTo: "pending")
                            .where("type", isEqualTo: typeselected)
                            .orderBy('Complaintpostedtiming', descending: true)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("No complaints added",
                              style: TextStyle(fontSize: 20)),
                        );
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final doc = snapshot.data!.docs[index];
                          final data = doc.data() as Map<String, dynamic>;
                          final Timestamp? ts = data["Complaintpostedtiming"];
                          final DateTime postedtime =
                              ts != null ? ts.toDate() : DateTime.now();
                          String myuid = FirebaseAuth.instance.currentUser!.uid;
                          return Card(
                        color: Colors.grey.shade50,
                            elevation: 2,
                            child: Container(
                              height: 120,
                              padding: EdgeInsets.all(3),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 5,
                                    left: 10,
                                    child: Container(
                                      width: 150,
                                      child: Text(data["desc"],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 5,
                                      left: 10,
                                      child: Text(timeago(postedtime),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ))),
                                  Positioned(
                                      top: 47,
                                      left: 10,
                                      child: Text(data["roomno"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))),
                                  Positioned(
                                      bottom: 25,
                                      left: 10,
                                      child: Row(
                                        children: [
                                          Text("Student Availability : ",
                                              style: TextStyle(
                                                fontSize: 12,
                                              )),
                                          Text(data["timing"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12)),
                                        ],
                                      )),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      height: 33,
                                      width: 115,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                          child: Text(data["type"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12))),
                                    ),
                                  ),
                                  if (data["uid"] == myuid)
                                    Positioned(
                                      right: 10,
                                      top: 65,
                                      child: IconButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection("complaints")
                                                .doc(doc.id)
                                                .delete();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              if (isattendedcomplaintsSelected)
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('complaints')
                        .where("status", isEqualTo: "completed")
                        .orderBy('Complaintpostedtiming', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("No complaints added",
                              style: TextStyle(fontSize: 20)),
                        );
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final doc = snapshot.data!.docs[index];
                          final data = doc.data() as Map<String, dynamic>;
                          final Timestamp? ts = data["Complaintpostedtiming"];
                          final DateTime postedtime =
                              ts != null ? ts.toDate() : DateTime.now();
                          String myuid = FirebaseAuth.instance.currentUser!.uid;
                          return Card(
                           color: Colors.grey.shade50,
                            elevation: 2,
                            child: Container(
                              height: 120,
                              padding: EdgeInsets.all(3),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 5,
                                    left: 10,
                                    child: Container(
                                      width: 150,
                                      child: Text(data["desc"],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 5,
                                      left: 10,
                                      child: Text(timeago(postedtime),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ))),
                                  Positioned(
                                      top: 47,
                                      left: 10,
                                      child: Text(data["roomno"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      height: 33,
                                      width: 105,
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
                                      bottom: 25,
                                      left: 10,
                                      child: Row(
                                        children: [
                                          Text("Student Availability : ",
                                              style: TextStyle(
                                                fontSize: 12,
                                              )),
                                          Text(data["timing"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12)),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ));
  }
}
