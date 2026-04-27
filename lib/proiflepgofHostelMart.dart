import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_app/chatpg.dart';

import 'package:hostel_app/viewpeoplecoming.dart';

import 'homepage.dart';


import 'profileclass.dart';
import 'generalprofileofStudent.dart';


class profilepgofhostelmart extends StatefulWidget {
  @override
  State<profilepgofhostelmart> createState() => _profilepgState();
}

class _profilepgState extends State<profilepgofhostelmart> {
  var isMyItemsSelected = true;
  bool issolditemsSelected = false;
  bool isboughtitemSelected = false;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
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
                  .doc(FirebaseAuth.instance.currentUser!.uid)
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
                    color: Colors.grey.shade50,
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
                            size: 30,
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
            SizedBox.square(
              dimension: 20,
            ),
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
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Allsellingitems")
                                  .where("uid",
                                      isEqualTo: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .where("status",
                                      whereIn: ["notsold", "pending"])
                                  .where("isbusiness", isEqualTo: false)
                                  .orderBy("keptforselltiming",
                                      descending: true)
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
                          Text("Active items"),
                        ],
                      ),
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
                                .collection("Allsellingitems")
                                .where("status", isEqualTo: "sold")
                                .where("uid",
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .where("isbusiness", isEqualTo: false)
                                .orderBy("soldatTime", descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("0",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27));
                              }
                              return Text(snapshot.data!.docs.length.toString(),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27));
                            }),
                        Text("Items sold"),
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
                                .collection("Allsellingitems")
                                .where("buyeruid",
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .where("isbusiness", isEqualTo: false)
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
                        Text("Items bought"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox.square(
              dimension: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 124,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMyItemsSelected = true;
                        isboughtitemSelected = false;
                        issolditemsSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Center(
                        child: Text(
                      "My Items",
                      style: TextStyle(
                          color: isMyItemsSelected
                              ? Colors.blueAccent
                              : Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                Container(
                    height: 40,
                    width: 124,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isMyItemsSelected = false;
                          isboughtitemSelected = false;
                          issolditemsSelected = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Center(
                          child: Text("Sold Items",
                              style: TextStyle(
                                  color: issolditemsSelected
                                      ? Colors.blueAccent
                                      : Colors.black54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold))),
                    )),
                Container(
                  height: 40,
                  width: 124,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMyItemsSelected = false;
                        isboughtitemSelected = true;
                        issolditemsSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Center(
                        child: Text(
                      "Purchased Items",
                      style: TextStyle(
                          color: isboughtitemSelected
                              ? Colors.blueAccent
                              : Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (isMyItemsSelected)
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Allsellingitems")
                    .where("uid",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where("status", whereIn: ["notsold", "pending"])
                    .where("isbusiness", isEqualTo: false)
                    .orderBy("keptforselltiming", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Text("No item kept for sell by you yet"));
                  }

                  var docs = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var doc = docs[index];
                      var data = doc.data() as Map<String, dynamic>;
                      String myuid = FirebaseAuth.instance.currentUser!.uid;
                      String docID = doc.id;
                      return Container(
                        height: 150,
                        padding: EdgeInsets.only(left: 13, right: 13),
                        child: Card(
                          elevation: 2,
                          color: Colors.grey.shade100,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 17,
                                  left: 15,
                                  child: Container(
                                      color: Colors.grey.shade200,
                                      height: 110,
                                      width: 110,
                                      child: Icon(Icons.image,
                                          size: 40, color: Colors.grey))),
                              Positioned(
                                left: 140,
                                top: 15,
                                child: Text(
                                  data["title"] ?? "No title",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 140,
                                  top: 35,
                                  child: Text("₹ ${data["price"]}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueAccent.shade700))),
                              Positioned(
                                left: 140,
                                top: 60,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 15,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      data["name"] ?? "No name",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 5,
                                child: IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("Allsellingitems")
                                          .doc(docs[index].id)
                                          .delete();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ),
                              /*   Positioned(
                                   top: 88,
                                      left: 150,
                                    child: Container(
                                     height: 33,
                                  width: 150,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                          Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>homepage(),
                                                       ));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey.shade300,
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          child: Text(
                                            "View Prices",
                                            style: TextStyle(fontSize: 14),
                                          )),
                                    ),
                                  ),*/
                              Positioned(
                                left: 140,
                                top: 95,
                                child: SizedBox(
                                  height: 30,
                                  width: 200,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            Colors.blueAccent.shade700,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  viewpeoplecomingIndividualItems(
                                                    documentid: docID,
                                                  )));
                                      FirebaseFirestore.instance
                                          .collection("Allsellingitems")
                                          .doc(docs[index].id)
                                          .update({
                                        "status": "pending",
                                      });
                                    },
                                    child: Text("View people coming",
                                        style: TextStyle(
                                          fontSize: 14,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            if (issolditemsSelected == true)
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Allsellingitems")
                    .where("status", isEqualTo: "sold")
                    .where("uid",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where("isbusiness", isEqualTo: false)
                    .orderBy("soldatTime", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No item of you sold yet"));
                  }

                  var docs = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var data = docs[index].data() as Map<String, dynamic>;

                      return Container(
                          height: 180,
                          width: 404,
                          padding: EdgeInsets.only(left: 13, right: 13),
                          child: Card(
                              color: Colors.white,
                              elevation: 2,
                              child: Stack(children: [
                                Positioned(
                                    top: 15,
                                    left: 15,
                                    child: Container(
                                        color: Colors.grey.shade200,
                                        height: 110,
                                        width: 110,
                                        child: Icon(Icons.image,
                                            size: 40, color: Colors.grey))),
                                Positioned(
                                  top: 15,
                                  left: 140,
                                  child: Text(data["title"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ),
                                Positioned(
                                    left: 140,
                                    top: 35,
                                    child: Text("₹ ${data["price"] ?? ""}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Colors.blueAccent.shade700))),
                                Positioned(
                                  left: 38,
                                  top: 60,
                                  child: SizedBox(
                                    height: 20,

                                    width: 400, // line length
                                    child: Image.asset(
                                      "assets/images/thinline.png",
                                      color: Colors.grey.shade700,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 132,
                                  left: 140,
                                  child: Container(
                                    height: 30,
                                    width: 200,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => chatpg(
                                                      receiverId:
                                                          data["buyeruid"],
                                                      receiverName:
                                                          data["buyername"] ??
                                                              "Buyer",
                                                    )),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.blueAccent.shade700,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: Text(
                                          "Chat with the ${data["buyername"] ?? "Buyer"}",
                                          style: TextStyle(fontSize: 13),
                                        )),
                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  left: 140,
                                  child: Text("Buyer"),
                                ),
                                Positioned(
                                  top: 80,
                                  right: 15,
                                  child: Column(
                                    children: [
                                      Text("Sold"),
                                      Text("2 days ago",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 140,
                                  child: Text(data["buyername"] ?? "Buyer",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                              ])));
                    },
                  );
                },
              ),
            if (isboughtitemSelected == true)
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Allsellingitems")
                    .where("buyeruid",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where("isbusiness", isEqualTo: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No item of you sold yet"));
                  }

                  var docs = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var data = docs[index].data() as Map<String, dynamic>;

                      return Container(
                          height: 180,
                          width: 404,
                          padding: EdgeInsets.only(left: 13, right: 13),
                          child: Card(
                              color: Colors.white,
                              elevation: 2,
                              child: Stack(children: [
                                Positioned(
                                    top: 15,
                                    left: 15,
                                    child: Container(
                                        color: Colors.grey.shade200,
                                        height: 110,
                                        width: 110,
                                        child: Icon(Icons.image,
                                            size: 40, color: Colors.grey))),
                                Positioned(
                                  top: 15,
                                  left: 140,
                                  child: Text(data["title"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ),
                                Positioned(
                                    left: 140,
                                    top: 30,
                                    child: Text("₹ ${data["price"] ?? ""}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Colors.blueAccent.shade700))),
                                Positioned(
                                  left: 38,
                                  top: 60,
                                  child: SizedBox(
                                    height: 20,

                                    width: 400, // line length
                                    child: Image.asset(
                                      "assets/images/thinline.png",
                                      color: Colors.grey.shade700,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 132,
                                  left: 140,
                                  child: Container(
                                    height: 30,
                                    width: 200,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => chatpg(
                                                      receiverId: data["uid"],
                                                      receiverName:
                                                          data["name"] ??
                                                              "Seller",
                                                    )),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.blueAccent.shade700,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: Text(
                                          "Chat with the ${data["name"]}",
                                          style: TextStyle(fontSize: 13),
                                        )),
                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  left: 140,
                                  child: Text("Seller"),
                                ),
                                Positioned(
                                  top: 80,
                                  right: 15,
                                  child: Column(
                                    children: [
                                      Text("Purchased "),
                                      Text("2 days ago",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 140,
                                  child: Text(data["name"] ?? "Seller",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                              ])));
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  /* Future<void> fetchuserdata() async {
    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("❌ ERROR: No user is logged in!");
        return;
      }

      print("✅ User is logged in!");
      print("📧 Email: ${user.email}");
      print("🔑 UID: ${user.uid}");

      // Try to fetch data from Firestore
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("userprofiledata")
          .doc(user.uid)
          .get();

      print("📄 Document exists? ${doc.exists}");

      if (doc.exists) {
        print("🎉 Found user data!");
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print("📊 Data: $data");

        setState(() {
          userdata = data;
        });
      } else {
        print("⚠️ No data found for this UID!");
        print("🔍 Trying to find by email...");

        // Search by email
        QuerySnapshot query = await FirebaseFirestore.instance
            .collection("userprofiledata")
            .where("email", isEqualTo: user.email)
            .get();

        if (query.docs.isNotEmpty) {
          print("✅ Found by email!");
          var doc = query.docs.first;
          setState(() {
            userdata = doc.data() as Map<String, dynamic>;
          });
        } else {
          print("❌ No data found at all!");
        }
      }
    } catch (e) {
      print("🔥 ERROR: $e");
    }
  }*/
}
