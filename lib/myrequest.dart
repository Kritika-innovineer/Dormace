import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/chatpg.dart';

import 'package:hostel_app/homepage.dart';

import 'viewoffers.dart';

class myrequest extends StatefulWidget {
  @override
  State<myrequest> createState() => _myrequestState();
}

class _myrequestState extends State<myrequest> {
  bool isMyRequestSelected = true;
  bool ismyrequestfullfilled = false;
  bool ishelpofferedSelected = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: Text("My Request",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isMyRequestSelected = true;
                            ishelpofferedSelected = false;
                            ismyrequestfullfilled = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Center(
                            child: Text(
                          "My Requests",
                          style: TextStyle(
                              color: isMyRequestSelected
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
                              ishelpofferedSelected = true;

                              isMyRequestSelected = false;
                              ismyrequestfullfilled = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          child: Center(
                              child: Text("Help Offered",
                                  style: TextStyle(
                                      color: ishelpofferedSelected
                                          ? Colors.blueAccent
                                          : Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))),
                        )),
                    Container(
                      height: 40,
                      width: 120,
                      child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                ismyrequestfullfilled = true;
                                isMyRequestSelected = false;
                                ishelpofferedSelected = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: Text(
                              "MyRequest Fulfilled",
                              style: TextStyle(
                                  color: ismyrequestfullfilled
                                      ? Colors.blueAccent
                                      : Colors.black54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              if (isMyRequestSelected == true)
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("studentsrequest")
                        .where("uid",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .where("status",
                            whereIn: ["notfulfilled", "statuspending"])
                        .orderBy("createdat", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                            child: Text("No requests posted by you yet"));
                      }
                      var docs = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          var doc = docs[index];
                          var data = doc.data() as Map<String, dynamic>;
                          String myuid = FirebaseAuth.instance.currentUser!.uid;
                          String docID = doc.id;

                          return Container(
                            height: 160,
                            padding: EdgeInsets.only(left: 13, right: 13),
                            child: Card(
                              elevation: 2,
                              color: Colors.grey.shade50,
                              child: Stack(
                                children: [
                                  Positioned(
                                      left: 15,
                                      top: 15,
                                      child: Text(data["title"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600))),
                                  Positioned(
                                      top: 40,
                                      left: 15,
                                      child: Text(data["desc"])),
                                  Positioned(
                                    right: 15,
                                    top: 15,
                                    child: Container(
                                      height: 33,
                                      width: 85,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: data["need"] == "urgent"
                                            ? Colors.redAccent.shade100
                                            : Colors.lightGreen.shade400,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(child: Text(data["need"])),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 45,
                                      right: 15,
                                      child: Text("12 mins ago")),
                                  Positioned(
                                    right: 10,
                                    bottom: 2,
                                    child: IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("studentsrequest")
                                              .doc(docID)
                                              .delete();
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red.shade300,
                                        )),
                                  ),
                                  Positioned(
                                    top: 110,
                                    left: 15,
                                    child: Container(
                                      height: 30,
                                      width: 200,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        viewoffers(
                                                            documentid:
                                                                docID)));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.blueAccent.shade700,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          child: Text(
                                            "View Offers",
                                            style: TextStyle(fontSize: 14),
                                          )),
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
                ),
              if (ishelpofferedSelected == true)
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("studentsrequest")
                        .where(
                          "offereruid",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                        )
                        .where("status", whereIn: [
                      "Statuspending",
                      "fulfilled"
                    ]).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                            child: Text("No help offered by you yet"));
                      }

                      var docs = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          var data = docs[index].data() as Map<String, dynamic>;

                          return Container(
                            height: 190,
                            padding: EdgeInsets.only(left: 13, right: 13),
                            child: Card(
                              elevation: 2,
                              color: Colors.grey.shade50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 15,
                                    top: 15,
                                    child: Text(data["title"] ?? "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Positioned(
                                      top: 45,
                                      left: 15,
                                      child: SizedBox(
                                          width: 320,
                                          child: Text(data["desc"] ?? ""))),
                                  Positioned(
                                      left: 15,
                                      top: 90,
                                      child: Row(
                                        children: [
                                          Text("My Availability : "),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(data["availability"] ?? "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      )),
                                  Positioned(
                                      top: 110,
                                      left: 15,
                                      child: Row(
                                        children: [
                                          Text("Instruction : "),
                                          Text(
                                            data["instruction"] ?? "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                  Positioned(
                                    top: 140,
                                    left: 15,
                                    child: Container(
                                      height: 30,
                                      width: 250,
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
                                                      BorderRadius.circular(
                                                          10))),
                                          child: Text(
                                            "Chat with ${data["name"]}",
                                            style: TextStyle(fontSize: 14),
                                          )),
                                    ),
                                  ),
                                  Positioned(
                                    right: 15,
                                    top: 10,
                                    child: Container(
                                      height: 33,
                                      width: 85,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: data["need"] == "urgent"
                                            ? Colors.redAccent.shade100
                                            : Colors.green,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                          child: Text(data["need"] ?? "")),
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
                ),
              if (ismyrequestfullfilled == true)
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("studentsrequest")
                        .where(
                          "uid",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                        )
                        .where("status", isEqualTo: "fulfilled")
                        .orderBy("helpofferedat", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No request fullfilled yet"));
                      }

                      var docs = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          var data = docs[index].data() as Map<String, dynamic>;

                          return Container(
                            height: 130,
                            padding: EdgeInsets.only(left: 13, right: 13),
                            child: Card(
                              elevation: 2,
                              color: Colors.grey.shade50,
                              child: Stack(
                                children: [
                                  Positioned(
                                      left: 15,
                                      top: 15,
                                      child: Text(data["title"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600))),
                                  Positioned(
                                      top: 40,
                                      left: 15,
                                      child: Text(data["desc"])),
                                  Positioned(
                                    right: 15,
                                    top: 15,
                                    child: Container(
                                      height: 33,
                                      width: 80,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent.shade100,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(child: Text(data["need"])),
                                    ),
                                  ),
                                  Positioned(
                                    top: 80,
                                    left: 15,
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
                                                            data["offereruid"],
                                                        receiverName: data[
                                                                "offerername"] ??
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
                                                      BorderRadius.circular(
                                                          10))),
                                          child: Text(
                                            "Chat With ${data["offerername"]}",
                                            style: TextStyle(fontSize: 14),
                                          )),
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}
