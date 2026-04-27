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

class businessdashboard extends StatefulWidget {
  @override
  State<businessdashboard> createState() => _businessdashboardState();
}

class _businessdashboardState extends State<businessdashboard> {
  bool isAvailableItemsSeledted = true;
  bool isSoldItemsSeledted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Business Dashboard",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),

            /// SizedBox(width: 40,),
            //  CircleAvatar(
            //   child: IconButton(onPressed: (){

            //  }, icon:
            //  Icon(Icons.add)),)
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
                                .collectionGroup("items")
                                .where("uid",
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .where("status",
                                    whereIn: ["notsold", "sold"]).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("0",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27));
                              }
                              return Text(snapshot.data!.docs.length.toString(),
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27));
                            }),
                        Text("Total Item"),
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
                                .collectionGroup("items")
                                .where("uid",
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .where("status", isEqualTo: "notsold")
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
                        Text("Available"),
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
                                .collectionGroup("items")
                                .where("uid",
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .where("status", isEqualTo: "sold")
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
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27));
                            }),
                        Text("Sold"),
                      ],
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
                      width: 175,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isAvailableItemsSeledted = true;
                            isSoldItemsSeledted = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Center(
                            child: Text("Available",
                                style: TextStyle(
                                    color: isAvailableItemsSeledted
                                        ? Colors.blueAccent
                                        : Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))),
                      )),
                  Container(
                      height: 50,
                      width: 175,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isAvailableItemsSeledted = false;
                            isSoldItemsSeledted = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Center(
                            child: Text("Sold",
                                style: TextStyle(
                                    color: isSoldItemsSeledted
                                        ? Colors.blueAccent
                                        : Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))),
                      )),
                ],
              ),
            ),
            if (isAvailableItemsSeledted == true)
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collectionGroup("items")
                    .where("uid",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where("status", isEqualTo: "notsold")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text("No business item added by you yet"),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        final data = doc.data() as Map<String, dynamic>;

                        return Container(
                          height: 160,
                          child: Card(
                            color: Colors.grey.shade100,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// 🔵 LEFT SIDE IMAGE
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade200,
                                      image: data["imageUrl"] != null
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  data["imageUrl"]),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                    child: data["imageUrl"] == null
                                        ? Icon(Icons.image,
                                            size: 40, color: Colors.grey)
                                        : null,
                                  ),

                                  SizedBox(width: 12),

                                  /// 🔵 RIGHT SIDE CONTENT
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// 🔹 TITLE (Top Right)
                                        Text(
                                          data["individualtitle"] ?? "No Title",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        SizedBox(height: 6),

                                        /// 🔹 DESCRIPTION
                                        Text(
                                          data["individualdesc"] ??
                                              "No Description",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        SizedBox(height: 6),

                                        /// 🔹 PRICE
                                        Text(
                                          "₹ ${data["price"] ?? "0"}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green.shade700,
                                          ),
                                        ),

                                        Spacer(),

                                        /// 🔹 BUTTON (Bottom Right)
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: SizedBox(
                                            height: 35,
                                            width: 210,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueAccent.shade700,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onPressed: () async {
                                                doc.reference.update({
                                                  "status": "sold",
                                                  "soldatTime": FieldValue
                                                      .serverTimestamp(),
                                                });
                                              },
                                              child: Text(
                                                "Mark As Sold",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
            if (isSoldItemsSeledted)
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collectionGroup("items")
                    .where("uid",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where("status", isEqualTo: "sold")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          "No item sold yet",
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        final data = doc.data() as Map<String, dynamic>;

                        return Container(
                          height: 130,
                          child: Card(
                            color: Colors.grey.shade100,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// 🔵 LEFT SIDE IMAGE
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade200,
                                      image: data["imageUrl"] != null
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  data["imageUrl"]),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                    child: data["imageUrl"] == null
                                        ? Icon(Icons.image,
                                            size: 40, color: Colors.grey)
                                        : null,
                                  ),

                                  SizedBox(width: 12),

                                  /// 🔵 RIGHT SIDE CONTENT
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// 🔹 TITLE (Top Right)
                                        Text(
                                          data["individualtitle"] ?? "No Title",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        SizedBox(height: 6),

                                        /// 🔹 DESCRIPTION
                                        Text(
                                          data["individualdesc"] ??
                                              "No Description",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        SizedBox(height: 6),

                                        /// 🔹 PRICE
                                        Text(
                                          "₹ ${data["price"] ?? "0"}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
          ],
        ),
      ),
    );
  }
}
