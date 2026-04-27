import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hostel_app/chatpg.dart';
import 'homepage.dart';
import 'loginpgforwarden.dart';
import 'loginpgofstudent.dart';
import 'signinOptions.dart';
import 'signupforphoneotp.dart';

import 'wardennamespg.dart';

class businesscollecitonpg extends StatelessWidget {
  final String collectionid;
  final String businesstitle;

  businesscollecitonpg({required this.collectionid, 
  required this.businesstitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(businesstitle,style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Allsellingitems").doc(collectionid).snapshots(),

           
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text("No business items found for this collection"),
            );
          }

          // Group by collection info from the first document
          
          final storeData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storeData["collectiontitle"] ?? "Collection",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text(
                        storeData["desc"] ?? "",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 18, color: Colors.blueAccent.shade700,),
                          SizedBox(width: 5),
                          Text(storeData["roomno"] ?? "",),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 18, color: Colors.blueAccent.shade700,),
                          SizedBox(width: 5),
                          Text(storeData["timing"] ?? ""),
                        ],
                      ),
                      SizedBox(height: 15),
                      // 🔵 CHAT BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => chatpg(
                                  receiverId: storeData["uid"] ?? "",
                                  receiverName: storeData["name"] ?? "Seller",
                                )
                              ),
                            );
                          },
                          icon: Icon(Icons.chat_bubble_outline),
                          label: Text("Chat with Seller"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Allsellingitems")
                      .doc(collectionid)
                      .collection("items")
                      .snapshots(),

                  builder: (context, itemSnapshot) {

                    if (!itemSnapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: itemSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {

                        final item =
                            itemSnapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                        return Container(
                          height: 140,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),

                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            child: Stack(
                              children: [

                                Positioned(
                                  left: 12,
                                  top: 12,
                                  child: Container(
                                    height: 108,
                                    width: 108,
                                    color: Colors.grey.shade200,
                                    child: Icon(Icons.image),
                                  ),
                                ),

                                Positioned(
                                  left: 135,
                                  top: 15,
                                  child: Text(
                                    item["individualtitle"] ?? "",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                                Positioned(
                                  left: 135,
                                  top: 40,
                                  child: Text(
                                    item["individualdesc"] ?? "",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54
                                     ),
                                  ),
                                ),

                                Positioned(
                                  left: 135,
                                  bottom: 15,
                                  child: Text(
                                    "₹ ${item["price"]}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent),
                                  ),
                                ),

                                Positioned(
                                  right: 15,
                                  bottom: 15,
                                  child: Text(
                                    "Qty: ${item["quantity"]}",
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
              ],
            ),
          );
        },
      ),
    );
  }
}