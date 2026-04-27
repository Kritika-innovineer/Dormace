import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/chatpg.dart';

import 'package:hostel_app/notificationserviceclass.dart';

import 'homepage.dart';
import 'loginpgofstudent.dart';

class viewoffers extends StatelessWidget {
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  late final String documentid;
  viewoffers({required this.documentid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Offers",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("studentsrequest")
            .doc(documentid)
            .collection("offers")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 280,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Container(
              height: 280,
              child: Center(child: Text("No offers yet")),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final offers =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return Container(
                height: 200,
                padding: EdgeInsets.only(left: 13, right: 13),
                child: Card(
                  elevation: 2,
                  color: Colors.grey.shade50,
                  child: Stack(children: [
                    Positioned(
                      left: 15,
                      top: 15,
                      child: Text(offers["offerername"] ?? "Sender",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Positioned(
                        top: 40,
                        left: 15,
                        child:
                            Text("Availability : ${offers["availability"]}")),
                    Positioned(
                        top: 60,
                        left: 15,
                        child: Text("Instruction : ${offers["instruction"]}")),
                    Positioned(
                      left: 10,
                      top: 150,
                      child: Container(
                        height: 30,
                        width: 210,
                        child: ElevatedButton(
                            onPressed: () async {
                              FirebaseFirestore.instance
                                  .collection("studentsrequest")
                                  .doc(documentid)
                                  .update({"status": "rejected"});

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => homepage()));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade300,
                                foregroundColor: Colors.black54,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(
                              "Already got it, thanks",
                              style: TextStyle(fontSize: 14),
                            )),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 150,
                      child: Container(
                        height: 30,
                        width: 110,
                        child: ElevatedButton(
                            onPressed: () async {
                              FirebaseFirestore.instance
                                  .collection("studentsrequest")
                                  .doc(documentid)
                                  .update({
                                "status": "fulfilled",
                                "helpofferedat": FieldValue.serverTimestamp(),
                                "offereruid": offers["offereruid"],
                                "offerername": offers["offerername"],
                                "availability": offers["availability"],
                                "devicetokenofhelper":
                                    offers["devicetokenofhelper"],
                              });

                              String helpertoken =
                                  offers["devicetokenofhelper"] ?? "";

                              String currentUserId =
                                  FirebaseAuth.instance.currentUser!.uid;
                              DocumentSnapshot userDoc = await FirebaseFirestore
                                  .instance
                                  .collection("userprofiledata")
                                  .doc(currentUserId)
                                  .get();

                              notificationserviceclass objj =
                                  notificationserviceclass();
                              await objj.sendnotification(
                                  helpertoken,
                                  "Offer Accepted !",
                                  "${userDoc["name"]} accepted your offer !");

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(
                              "Accept",
                              style: TextStyle(fontSize: 14),
                            )),
                      ),
                    ),
                    Positioned(top: 15, right: 15, child: Text("12 mins ago")),
                    Positioned(
                      top: 109,
                      left: 10,
                      child: SizedBox(
                        height: 30,
                        width: 330,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.blueAccent.shade700,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onPressed: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => chatpg(
                                  receiverId:offers["offereruid"],
                                  receiverName:offers["offerername"] ?? "Offerername",
                                )
                              ),
                            );
                            

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.chat),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "Chat with ${offers["offerername"] ?? "Sender"}",
                                    style: TextStyle(fontSize: 14)),
                              ],
                            )),
                      ),
                    ),
                  ]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
