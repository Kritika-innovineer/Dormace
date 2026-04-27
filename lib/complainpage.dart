import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/notificationserviceclass.dart';
import 'complainhomepg.dart';
import 'homepage.dart';

class complainpage extends StatefulWidget {
  @override
  State<complainpage> createState() => _complainpageState();
}

class _complainpageState extends State<complainpage> {
  TextEditingController namecontroller = TextEditingController();

  TextEditingController roomnocontroller = TextEditingController();

  TextEditingController timingcontroller = TextEditingController();

  TextEditingController descriptioncontroller = TextEditingController();

  String dropdownvalue = "Select Category";
  var typesofcomplaints = [
    "Select Category",
    "Electrical",
    "Water",
    "Mess Food",
    "Infrastructure",
    "Wifi",
    "Cleanliness",
    "Washing Machine",
    "Others",
  ];
  Future<void> addcomplaint() async {
    notificationserviceclass obj = notificationserviceclass();
    String? studenttoken = await obj.getfcmToken();
    await FirebaseFirestore.instance.collection("complaints").add({
      "name": namecontroller.text,
      "roomno": roomnocontroller.text,
      "desc": descriptioncontroller.text,
      "type": dropdownvalue,
      "timing": timingcontroller.text,
      "Complaintpostedtiming": FieldValue.serverTimestamp(),
      "status": "pending",
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "complainattendedtiming": "",
      "deviceToken": studenttoken,
    });
    /* await FirebaseFirestore.instance.collection("notifications").add({
                                  "type": dropdownvalue,
                                  "roomno": roomnocontroller.text,
                                  "complaintaddedtiming": FieldValue.serverTimestamp(),
"seen": false,

                                  })
                                  */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Complaint",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.lightBlue.shade100,
        child: SingleChildScrollView(
          child: Center(
              child: Container(
            height: 760,
            margin: EdgeInsets.only(top: 40, bottom: 70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(29),
              color: Colors.white,
            ),
            width: 370,
            child: Column(
              children: [
                SizedBox.square(
                  dimension: 25,
                ),
                Text("Submit complaint",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                Text(
                  "Any problem you are facing in hostel",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox.square(dimension: 30),
                Container(
                  padding: EdgeInsets.only(bottom: 30, left: 32, right: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox.square(dimension: 5),
                      Text("Name",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                      SizedBox.square(dimension: 9),
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: TextField(
                          controller: namecontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter your name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                      SizedBox.square(dimension: 20),
                      Text("RoomNo",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                      SizedBox.square(dimension: 9),
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: TextField(
                          controller: roomnocontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter your roomo no",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                      SizedBox.square(dimension: 20),
                      Text("Timing",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                      SizedBox.square(dimension: 9),
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: TextField(
                          controller: timingcontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText:
                                "Enter time when complain can be rectified",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                      SizedBox.square(dimension: 20),
                      Text("Description",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                      SizedBox.square(dimension: 9),
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: TextField(
                          maxLines: 2,
                          controller: descriptioncontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "eg : switch board not working",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                      SizedBox.square(dimension: 20),
                      Text("Category Of Complaint",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                      DropdownButton(
                          value: dropdownvalue,
                          icon: const Icon(Icons.arrow_drop_down),
                          items:
                              typesofcomplaints.map((String typesofcomplaints) {
                            return DropdownMenuItem(
                              child: Text(typesofcomplaints),
                              value: typesofcomplaints,
                            );
                          }).toList(),
                          onChanged: (String? newvalue) {
                            setState(() {
                              dropdownvalue = newvalue!;
                            });
                          }),
                      SizedBox.square(dimension: 9),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 140,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (descriptioncontroller.text == "") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("Fill all fields")));
                                    return;
                                  }

                                  /*


                if (snapshot.docs.isNotEmpty) {
                  wardentoken =  snapshot.docs.first["deviceToken"];

                }*/

                                  QuerySnapshot snapshot =
                                      await FirebaseFirestore.instance
                                          .collection("wardenprofiledata")
                                          .get();

                                  String wardentoken = "";

                                  if (snapshot.docs.isNotEmpty) {
                                    wardentoken =
                                        snapshot.docs.first["deviceToken"];
                                  }
                                  await addcomplaint();
                                  notificationserviceclass obj =
                                      notificationserviceclass();

                                  await obj.sendnotification(
                                      wardentoken,
                                      "New Complaint",
                                      "Room : ${roomnocontroller.text}\n${dropdownvalue.toString()}");

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Complaint added successfully")));

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              complainhomepage()));
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 4,
                                    backgroundColor: Colors.lightBlueAccent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    )),
                                child: Text(
                                  "Submit",
                                  style: TextStyle(fontSize: 17),
                                )),
                          ),
                          SizedBox(width: 20),
                          Container(
                            height: 50,
                            width: 140,
                            child: OutlinedButton(
                                onPressed: () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              complainhomepage()));
                                },
                                style: OutlinedButton.styleFrom(
                                    elevation: 4,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    )),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(fontSize: 17),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
