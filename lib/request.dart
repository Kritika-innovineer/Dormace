import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/notificationserviceclass.dart';
import 'allrequestsclass.dart';
import 'package:intl/intl.dart';

class requestPg extends StatefulWidget {
  @override
  State<requestPg> createState() => _requestPgState();
}

class _requestPgState extends State<requestPg> {
  var isUrgentClicked = false;
  List<StudentRequests> requests = [];
  bool isSelected = false;

  TextEditingController decripController = TextEditingController();
  TextEditingController itemkyahaicontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Item",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 380,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text("What are you looking for? *",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        ),
                        SizedBox.square(dimension: 15),
                        Center(
                          child: Container(
                            width: 330,
                            height: 50,
                            child: TextField(
                              controller: itemkyahaicontroller,
                              decoration: InputDecoration(
                                hintText: "eg: Maggi, milk, heels...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black26,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox.square(dimension: 22),
                Center(
                  child: Container(
                    width: 380,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text("Description *",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        ),
                        SizedBox.square(dimension: 15),
                        Center(
                          child: Container(
                            width: 330,
                            height: 70,
                            child: TextField(
                              controller: decripController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                hintText: "Describe what you want...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black26,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox.square(dimension: 22),
                Center(
                  child: Container(
                    width: 380,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text("How urgent is this? *",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        ),
                        SizedBox.square(dimension: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 155,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      !isUrgentClicked && isSelected
                                          ? Colors.green
                                          : Colors.white,
                                  side: BorderSide(
                                    color: !isUrgentClicked && isSelected
                                        ? Colors.green
                                        : Colors.black26,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isUrgentClicked = false;
                                    isSelected = true;
                                  });
                                },
                                child: Text("Not Urgent",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: !isUrgentClicked && isSelected
                                            ? Colors.white
                                            : Colors.black54)),
                              ),
                            ),
                            SizedBox.square(dimension: 15),
                            Container(
                              height: 50,
                              width: 155,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isUrgentClicked && isSelected
                                      ? Colors.redAccent
                                      : Colors.white,
                                  side: BorderSide(
                                    color: isUrgentClicked && isSelected
                                        ? Colors.redAccent
                                        : Colors.black26,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isUrgentClicked = true;
                                    isSelected = true;
                                  });
                                },
                                child: Text("Urgent",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: isUrgentClicked && isSelected
                                            ? Colors.white
                                            : Colors.black54)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox.square(dimension: 20),
                Center(
                  child: Container(
                    height: 50,
                    width: 330,
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        String itemname = itemkyahaicontroller.text;
                        String itemdesc = decripController.text;

                        try {
                          if (itemname.isEmpty ||
                              itemdesc.isEmpty ||
                              isSelected == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Please enter the required fields")),
                            );
                            return;
                          }

                          String curruid =
                              FirebaseAuth.instance.currentUser!.uid;

                          // ✅ GET USER DATA PROPERLY
                          DocumentSnapshot snapshot =
                              await FirebaseFirestore.instance
                                  .collection("userprofiledata")
                                  .doc(curruid)
                                  .get();

                          if (!snapshot.exists) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Profile not found")),
                            );
                            return;
                          }

                          var data =
                              snapshot.data() as Map<String, dynamic>;
 notificationserviceclass obj = notificationserviceclass();
                                    String? devicetokenofrequester = await    obj.getfcmToken();
                          // ✅ ADD REQUEST
                          await FirebaseFirestore.instance
                              .collection("studentsrequest")
                              .add({
                            "title": itemname,
                            "desc": itemdesc,
                            "createdat": FieldValue.serverTimestamp(),
                            "need":
                                isUrgentClicked ? "urgent" : "noturgent",
                            "roomno": data["roomno"],
                            "name": data["name"],
                            "uid": curruid,
                            "status": "notfulfilled",
                            "offerername": "nouserofferedyet",
                            "availability": "noavailabilityyet",
                            "helpofferedat": "notofferedyet",
                            "offereruid": "noofferyet",
                            "devicetokenofrequester": devicetokenofrequester,
                            "devicetokenofhelper": "",
                            
                          });

                          itemkyahaicontroller.clear();
                          decripController.clear();

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Request added successfully!"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Error: ${e.toString()}"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 6,
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child:
                          Text("Post request", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addrequest(
      StudentRequests request1, BuildContext context) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentReference docref = await db.collection("studentsrequest").add({
        "title": request1.title,
        "desc": request1.desc,
        "createdat": FieldValue.serverTimestamp(),
        "need": request1.need,
        "roomno": request1.roomno,
        "name": request1.name,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "status": "notfulfilled",
        "offerername": "nouserofferedyet",
        "instruction": "lala",
        "availability": "noavailabilityyet",
        "helpofferedat": "notofferedyet",
        "offereruid": "noofferyet",
      });
      await docref.update({
        "docid": docref.id,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Request added successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error : ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<Map<String, String>> getdatafornameandroomno() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("No user logged in");
        return {
          "name": "User",
          "roomno": "Not set",
        };
      }
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("userprofiledata")
          .doc(user.uid)
          .get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String name = data["name"]?.toString() ?? "User";
        String roomno = data["roomno"]?.toString() ?? "Not set";
        return {"name": name, "roomno": roomno};
      } else {
        return {
          "name": "User",
          "roomng": "Not set",
        };
      }
    } catch (e) {
      print("🔥 Error: ${e}");
      return {
        "name": "User",
        "roomng": "Not set",
      };
    }
  }
}
