import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:hostel_app/homepage.dart';
import 'package:hostel_app/notificationserviceclass.dart';
import 'package:hostel_app/viewprofilepg.dart';
import 'chatpg.dart';

class productdetails extends StatefulWidget {
  final String documentid;

  const productdetails({
    Key? key,
    required this.documentid,
  }) : super(key: key);

  @override
  State<productdetails> createState() => _productdetailsState();
}

class _productdetailsState extends State<productdetails> {
  Map<String, dynamic>? productdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product details",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Allsellingitems")
              .doc(widget.documentid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 280,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Container(
                height: 280,
                child: Center(child: Text("Product not found")),
              );
            }

            final productdata = snapshot.data!.data() as Map<String, dynamic>;

            String myuid = FirebaseAuth.instance.currentUser!.uid;

            return Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 350,
                      width: 390,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(19),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 0,
                                left: 120,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8)),
                                    height: 110,
                                    width: 110,
                                    child: Icon(Icons.image,
                                        size: 40, color: Colors.grey))),
                            Positioned(
                              left: 0,
                              top: 130,
                              child: Text(productdata["title"] ?? "No title",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17)),
                            ),
                            Positioned(
                                left: 0,
                                top: 150,
                                child: Text(
                                  productdata!['desc'] ??
                                      "No description available",
                                  style: TextStyle(fontSize: 15),
                                )),
                            Positioned(
                              left: 0,
                              top: 180,
                              child: Text("₹ ${productdata["price"] ?? "0"}",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blueAccent.shade700)),
                            ),
                            Positioned(
                                left: 0,
                                top: 200,
                                child: Text(
                                  "Condition : ${productdata['condition'] ?? "No condition"}",
                                  style: TextStyle(fontSize: 14),
                                )),
                            Positioned(
                              left: 0,
                              top: 220,
                              child: Row(
                                children: [
                                  Text("Sellor Availability : "),
                                  Text(
                                    productdata["timing"] ?? "Not available",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 255,
                              child: SizedBox(
                                height: 55,
                                width: 324,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            Colors.blueAccent.shade700,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        )),
                                    onPressed: () async {
                                      try {
                                        String uid = FirebaseAuth
                                            .instance.currentUser!.uid;
                                        var userDoc = await FirebaseFirestore
                                            .instance
                                            .collection("userprofiledata")
                                            .doc(uid)
                                            .get();
                                        notificationserviceclass obj =
                                            notificationserviceclass();
                                        String? devicetokenofbuyer =
                                            await obj.getfcmToken();
                                        await FirebaseFirestore.instance
                                            .collection("Allsellingitems")
                                            .doc(widget.documentid)
                                            .collection("peoplecoming")
                                            .doc(uid)
                                            .set({
                                          "buyername": userDoc["name"],
                                          "buyeruid": userDoc["uid"],
                                          "devicetokenofbuyer":
                                              devicetokenofbuyer,
                                        });

                                        await FirebaseFirestore.instance
                                            .collection("Allsellingitems")
                                            .doc(widget.documentid)
                                            .update({
                                          "status": "pending",
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Person will be notified !")),
                                        );
                                        String currentUserId = FirebaseAuth
                                            .instance.currentUser!.uid;
                                        DocumentSnapshot userdoc =
                                            await FirebaseFirestore.instance
                                                .collection("userprofiledata")
                                                .doc(currentUserId)
                                                .get();

                                        String sellertoken =
                                            productdata["devicetokenofseller"];

                                        notificationserviceclass objj =
                                            notificationserviceclass();
                                        await objj.sendnotification(
                                            sellertoken,
                                            "Someone is interested in your product !",
                                            "${userdoc["name"]} wants to visit your room");

                                            Navigator.pop(context);

                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text("Error : ${e}")),
                                        );
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.location_on_outlined),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Visit Room",
                                            style: TextStyle(fontSize: 17)),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 55,
                      width: 390,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => viewprofilepg(
                                    requestorid: productdata["uid"]),
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 20,
                                child: Image.asset(
                                  "assets/images/eyeimg.png",
                                  color: Colors.black,
                                )),
                            SizedBox(width: 10),
                            Text(
                              "View sellor profile",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 55,
                      width: 390,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.grey.shade300,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              )),
                          onPressed: () {
                            String currentUID =
                                FirebaseAuth.instance.currentUser!.uid;

                            if (currentUID == productdata["uid"]) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("You cannot chat with yourself")),
                              );
                              return;
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => chatpg(
                                  receiverId: productdata["uid"],
                                  receiverName: productdata["name"] ?? "Seller",
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
                              Text("Chat with seller",
                                  style: TextStyle(fontSize: 17)),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*    SizedBox(
                      height: 55,
                      width: 390,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.grey.shade300,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              )),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Bargain"),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            "When can they come to your room? *"),
                                        SizedBox(height: 10),
                                        TextField(
                                        
                                          decoration: InputDecoration(
                                              hintText: "eg : after 6 pm",
                                              border: OutlineInputBorder()),
                                        ),
                                        SizedBox(height: 20),
                                        Text("Any instruction"),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller:
                                            
                                          decoration: InputDecoration(
                                              hintText:
                                                  "Any specific instructions",
                                              border: OutlineInputBorder()),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 36,
                                  child:
                                      Image.asset("assets/images/bargain.png")),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Bargain", style: TextStyle(fontSize: 17)),
                            ],
                          )),
                    ),*/
                    SizedBox(
                      height: 20,
                    ),
                    /*  SizedBox(
                      height: 55,
                      width: 390,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.blueAccent.shade700,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              )),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => bargainedbuypg(
                                        documentid: widget.documentid)));
                          },
                          child: Text(
                            "Buy",
                            style: TextStyle(fontSize: 17),
                          )),
                    ),*/
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /* Future<void> fetchproductdetails() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("Allsellingitems")
          .doc(widget.documentid)
          .get();
      if (snapshot.exists) {
        setState(() {
          productdata = snapshot.data() as Map<String, dynamic>;
        });
        print("Product data loaded");
      } else {
        print("No product found");
      }
    } catch (e) {
      print("Error fetching product: $e");
    }
  }*/
}
