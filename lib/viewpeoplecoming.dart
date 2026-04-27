import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/chatpg.dart';
import 'package:hostel_app/homepage.dart';

class viewpeoplecomingIndividualItems extends StatelessWidget {
  late final String documentid;
  viewpeoplecomingIndividualItems({required this.documentid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("People coming",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Allsellingitems")
            .doc(documentid)
            .collection("peoplecoming")
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
              child:
                  Center(child: Text("No one yet interested in your product")),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final peoplecoming =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return Container(
                height: 120,
                padding: EdgeInsets.only(left: 13, right: 13),
                child: Card(
                  elevation: 2,
                  color: Colors.grey.shade50,
                  child: Stack(children: [
                    Positioned(
                      left: 15,
                      top: 15,
                      child: Text(peoplecoming["buyername"] ?? "Buyer name",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Positioned(
                      top: 70,
                      left: 10,
                      child: SizedBox(
                        height: 30,
                        width: 190,
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
                                  receiverId: peoplecoming["buyeruid"],
                                  receiverName: peoplecoming["buyername"] ?? "Buyer",
                                )
                              ),
                            );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline_sharp,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    "Chat with ${peoplecoming["buyername"] ?? "Sender"}",
                                    style: TextStyle(fontSize: 12)),
                              ],
                            )),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 70,
                      child: Container(
                        height: 30,
                        width: 134,
                        child: ElevatedButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection("Allsellingitems")
                                  .doc(documentid)
                                  .update({
                                "status": "sold",
                                "buyername": peoplecoming["buyername"],
                                "buyeruid": peoplecoming["buyeruid"],
                                "devicetokenofbuyer":
                                    peoplecoming["devicetokenofbuyer"]
                              });

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(
                              "Mark As Sold",
                              style: TextStyle(fontSize: 12),
                            )),
                      ),
                    ),
                    Positioned(top: 15, right: 15, child: Text("12 mins ago")),
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
